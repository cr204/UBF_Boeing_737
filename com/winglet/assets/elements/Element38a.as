package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	import com.winglet.events.ElementPressedEvent;
	
	public class Element38a extends ThrustLever {
		private var mainTL:*;
        public var isActiveElement:Boolean = false;
        public var elementSSwitch:String;
		public var conf:MovieClip;
		private var locY:Number = 0;
		
		public function Element38a() {
			// constructor code
			lever.buttonMode = true;
			lever.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			lever.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);

		}
		
		public function init(obj:*):void {
			mainTL = obj;
		}
		
		public function resetElement():void {
            isActiveElement = false;
			curState = STATE_NOTHING;
			lever.y = 66;
		}
		
		public function set active(b:Boolean):void {
			if(b) {
//				lever.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
//				lever.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			} else {
				lever.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				lever.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				lever.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				curState = STATE_NOTHING;
				if(conf) conf.hideTooltip();
			}
			isActiveElement = b;
		}
		
		public function leverConfirmation(con:MovieClip):void {
			conf = con;
			lever.conf = con;
			conf.y = lever.y * .77 + 200;
		}
		
		public function sSwitch(s:String):void {
			elementSSwitch = s;
		}
		
		public function defaultPosition(s:String):void {
			if(s=="idle") lever.y=0 else lever.y=66;
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			if (curState == STATE_NOTHING) {
				curState = STATE_CONFIRMING;
				if(conf!=null) {
					conf.y = lever.y + 410;
					if(isActiveElement) {
						conf.confValue=true;
						TweenLite.to(this, 0, {delay:1, onComplete:onConfirmTweenFinished});
					} else conf.confValue=false;
					conf.displayTooltip();
				}				
			}
		}
		
		private function onConfirmTweenFinished() {
			if (curState != STATE_NOTHING) { 
				curState = STATE_CONFIRMED;
				lever.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				lever.active = true;			
			}
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			if (curState == STATE_CONFIRMED) {
				curState = STATE_MOVING_LEVER;
			}
			
			lever.active = false;
			if(conf!=null) conf.hideTooltip();
			lever.active = true;
			locY = e.localY;
			
			lever.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler); // remove mouse out listener as we are now dragging the lever
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			if (curState != STATE_MOVING_LEVER) {
				curState = STATE_NOTHING;
				if (conf != null) { conf.hideTooltip(); }
			}
			
			lever.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			lever.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			if (curState == STATE_MOVING_LEVER) {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler); // stop tracking mouse.y
				stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				lever.active = false;
				lever.removeEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
				lever.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		
				if(conf!=null) conf.hideTooltip();
				
				correctPos();
				if (curState != STATE_COMPLETE) { 				
					curState = STATE_CONFIRMED; // user dropped the lever - they need to click on it and 'pick it up' again
				}
			}
		}		
		
		private function mouseMoveHandler(e:MouseEvent):void {
			if((mouseY - locY)<66 && (mouseY - locY) > 0) {
				lever.y = mouseY - locY;
			}
		}
		
		private function correctPos():void {
			var nextPos:Number = 0;
			if(lever.y>34) nextPos = 66;
			TweenLite.to(lever, .2,{y:nextPos, onComplete:moveCompleted});
		}
		
		private function moveCompleted():void {
			var cPos:String = "cutoff";
			if(lever.y<33) cPos="idle"
			if(elementSSwitch==cPos) this.dispatchEvent(new ElementPressedEvent(cPos));
		}
		
		
	}
}