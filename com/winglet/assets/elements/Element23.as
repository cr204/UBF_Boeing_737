package com.winglet.assets.elements {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.winglet.events.ElementPressedEvent;
	import com.winglet.events.ElementStateEvent;
	
	public class Element23 extends ElementSpriteBase {
		public var isActiveElement:Boolean = false;
		public var elementSSwitch:Number;
		private var _isConditionalElement:Boolean = false;
		
		public function Element23() {
			// constructor code
			this.mouseChildren = false;
			this.buttonMode = true;
		}
		
		public function set active(b:Boolean):void {
			if(b) {
				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			} else {
				this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
			isActiveElement = b;
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
			this.scaleX = this.scaleY = .95;
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
			this.scaleX = this.scaleY = 1;
//			if(_timeOut) {
//				if(currState==0) currState=1 else currState=0;
				changeBottomText();
				this.dispatchEvent(new ElementPressedEvent("off"));
//			} else {
//				this.dispatchEvent(new ElementPressedEvent("not_timeout"));
//			}
//			_timeOut = false;
		}
		
		public function sSwitch(s:String):void {
			//
		}
		
		public function showState(n:int):void {
			if(n==1) txt2.gotoAndStop(2) else txt2.gotoAndStop(1);
		}
		
		public function changeTopText(s:String):void {
			if(s=="on") txt1.gotoAndStop(2) else txt1.gotoAndStop(1);
		}
		
		public function changeBottomText():void {
			if(txt2.currentFrame==1) txt2.gotoAndStop(2) else txt2.gotoAndStop(1);
 		}
		
		
		
		
		
		
		
		
		
		public function resetElement():void {
			
		}
		
	}
}