package com.winglet.assets.buttons {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ControlButton03 extends MovieClip {
		
		
		public function ControlButton03() {
			// constructor code
			this.buttonMode = true;
			this.mouseChildren = false;
		}
		
		public function init():void {
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			play();
		}
		
		
		private function onMouseOver(e:MouseEvent):void {
			gotoAndStop(1);
		}
		
		private function onMouseOut(e:MouseEvent):void {
			play();
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			gotoAndStop(15);
		}
	}
	
}
