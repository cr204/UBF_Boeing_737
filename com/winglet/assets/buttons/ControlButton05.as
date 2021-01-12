package com.winglet.assets.buttons {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ControlButton05 extends Sprite {
		
		
		public function ControlButton05() {
			// constructor code
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
