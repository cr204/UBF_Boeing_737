package com.winglet.assets.buttons {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ControlButton01 extends MovieClip {
		
		
		public function ControlButton01() {
			// constructor code
			stop();
			bg.alpha = 0;
			this.buttonMode = true;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function onMouseOver(e:MouseEvent):void {
			bg.alpha = .4;
		}
		
		private function onMouseOut(e:MouseEvent):void {
			bg.alpha = 0;
		}
	}
}
