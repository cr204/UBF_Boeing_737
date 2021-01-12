package com.winglet.assets.elements {
	
	import flash.display.MovieClip;
	import com.winglet.events.ElementPressedEvent;
	import flash.events.MouseEvent;
	
	public class Element24 extends ElementMCBase {
		public var isActiveElement:Boolean = false;
		
		public function Element24() {
			// constructor code
			this.mouseChildren = false;
			this.buttonMode = true;
			stop();
		}
		
		public function resetElement():void {
			isActiveElement = false;
			this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		public function set active(b:Boolean):void {
			if(b) {
				this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			} else {
				this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
			isActiveElement = b;
		}
		
		public function switchState(n:Number):void {
			//
		}
		
		public function sSwitch(s:String):void {
			//
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			if(!isActiveElement) this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			this.dispatchEvent(new ElementPressedEvent("0"));
		}
		
	}
}