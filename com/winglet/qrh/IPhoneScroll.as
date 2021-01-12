package com.winglet.qrh {
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.system.ApplicationDomain;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;

	public class IPhoneScroll {

        // Constant variables
        private static var DECAY:Number = 0.93;
        private static var MOUSE_DOWN_DECAY:Number = 0.5;
        private static var SPEED_SPRINGNESS:Number = 0.4;
        private static var BOUNCING_SPRINGESS:Number = 0.2;

		// variables
        private var _mouseDown:Boolean = false;
        private var _velocity:Number = 0;
        private var _mouseDownY:Number = 0;
        private var _mouseDownPoint:Point = new Point();
        private var _lastMouseDownPoint:Point = new Point();
        		
        // elements
        private var _canvasHeight:Number = 0;
		private var _myScrollElement:*;
		private var _stage:Stage;
		private var _started:Boolean;
		private var _scrollSlider:*;
		private var margin:Number = 5;
		private var _mask:MovieClip
		//private var last_Velocity:Number;
		private var tm:Timer = new Timer(2000);
		
		public function IPhoneScroll(pContent:DisplayObjectContainer, pMask:MovieClip, pStage:Stage ) {
			
			_stage = pStage;
			_myScrollElement =pContent.getChildByName("contentHolder");
			
			_mask = pMask;
			_canvasHeight = _myScrollElement.height;
			_scrollSlider = pContent.getChildByName("scrollSlider");
			_scrollSlider.alpha = 0;
			
			start();
			
			_scrollSlider.height = Number(_mask.height/_myScrollElement.height)*_mask.height;
			
			// add handlers
			_myScrollElement.addEventListener(MouseEvent.MOUSE_DOWN, on_mouse_down);
			_myScrollElement.addEventListener(MouseEvent.MOUSE_UP, myScroll_mouse_up);
			_myScrollElement.addEventListener(Event.ENTER_FRAME, on_enter_frame);
			tm.addEventListener(TimerEvent.TIMER, scrollHide)
		}
		
		
		private function myScroll_mouse_up(e:MouseEvent):void{
			tm.reset();
			tm.start();
		}
		private function on_enter_frame(e:Event):void {
			if ( started )
			{// decay the velocity
				if(_mouseDown)
				{
					_velocity *= MOUSE_DOWN_DECAY
				}
				else 
				{
					_velocity *= DECAY;
					
					if(_scrollSlider.scaleY < 1 ){
						_scrollSlider.scaleY += 0.03;
					}
					
				}
				// if not mouse down, then move the element with the velocity
				if (!_mouseDown)
				{
					var textHeight:Number = _myScrollElement.height;
					var y:Number = _myScrollElement.y;
					var bouncing:Number = 0;
					// calculate a bouncing when the text moves over the canvas size
					if (y > 0 || textHeight <= _canvasHeight) // textHeight <= _canvasHeight => when the item is smaller than the stage.height, align to the top
					{
						bouncing = -y * BOUNCING_SPRINGESS;
						
					}else if( y + textHeight < _canvasHeight){
						
						bouncing = (_canvasHeight - textHeight - y) * BOUNCING_SPRINGESS;
					}
					
					_myScrollElement.y = y + _velocity + bouncing;
					
					_scrollSlider.y = -((_mask.height/_myScrollElement.height)* _myScrollElement.y);
					
					
					_scrollSlider.height = Number(_mask.height/_myScrollElement.height)*_mask.height;
					}
				}
		}
		
		// when mouse button up
        private function on_mouse_down(e:MouseEvent):void
        {
			/*tm.reset();
			tm.start();*/
			_scrollSlider.alpha = 1;
			 if (!_mouseDown)
            {
				// get some initial properties
                _mouseDownPoint = new Point(e.stageX, e.stageY);
                _lastMouseDownPoint = new Point(e.stageX, e.stageY);
                _mouseDown = true;
                _mouseDownY = _myScrollElement.y;
				// add some more mouse handlers
                _stage.addEventListener(MouseEvent.MOUSE_UP, on_mouse_up);
                _stage.addEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);
				
            }
        }

        // when mouse is moving
        private function  on_mouse_move(e:MouseEvent):void
        {
			
			  if (_mouseDown)
            {
				// update the element position
                var point:Point = new Point(e.stageX, e.stageY);
				_myScrollElement.y = _mouseDownY + (point.y - _mouseDownPoint.y);
				// update the velocity _scrollSlider
				_scrollSlider.y = -((_mask.height/_myScrollElement.height)* _myScrollElement.y);
                _velocity += ((point.y - _lastMouseDownPoint.y) * SPEED_SPRINGNESS);
				_lastMouseDownPoint = point;
				if(_myScrollElement.y>0){
					_scrollSlider.y = 0;
					_scrollSlider.scaleY -= 0.002;
					
				}
				if(_scrollSlider.y >  Number(_mask.height -_scrollSlider.height)){
					_scrollSlider.y = Number(_mask.height -_scrollSlider.height);
					_scrollSlider.scaleY -= 0.002;
					
				}
				
			}
			
        }

        // clear everythign when mouse up
        private function  on_mouse_up(e:MouseEvent):void
        {
			
            if (_mouseDown)
            {
                _mouseDown = false;
                _stage.removeEventListener(MouseEvent.MOUSE_UP, on_mouse_up);
                _stage.removeEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);
				
            }
			
        }
		
		private function scrollHide(e:TimerEvent):void{
			tm.stop()
//			Tweener.addTween(_scrollSlider, {alpha:0, time:0.5, transition:"linear"});
			TweenLite.to(_scrollSlider, .5, {alpha:0, ease:Linear.easeNone});
			
		}
		public function release():void
		{
			_myScrollElement.removeEventListener(MouseEvent.MOUSE_DOWN, on_mouse_down);
			_myScrollElement.removeEventListener(Event.ENTER_FRAME, on_enter_frame);
			_myScrollElement = null;
		}
		
		public function start():void
		{
			_started = true;
			
		}
		
		public function stop():void
		{
			_started 	= false;
			_velocity 	= 0;
			
			
		}
		
		public function set canvasHeight( pVal:Number ):void
		{
			_canvasHeight = pVal;
		}
		
		public function get canvasHeight():Number
		{
			return _canvasHeight;
		}
		
		public function get percPosition():Number
		{
			var finalPos:Number 	= _canvasHeight - _myScrollElement.height;
			var currentPos:Number 	= _myScrollElement.y;
			return currentPos / finalPos;
		}
		
		public function get started():Boolean { return _started; }
		
		public function set started(value:Boolean):void 
		{
			if ( value )
			{ 	
			
				start()
			}
			else{
				stop();
				
			}
		}
		
		public function get myScrollElement():DisplayObjectContainer { return _myScrollElement; }
	}
}