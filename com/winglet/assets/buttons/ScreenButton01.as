package com.winglet.assets.buttons {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ScreenButton01 extends Sprite {
		private var isActive:Boolean = false;
		
		public function ScreenButton01() {
			// constructor code
			this.alpha = 0;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		public function set active(b:Boolean):void {
			isActive = b;
			if(isActive) this.alpha = .4 else this.alpha = 0;
		}
		
		private function onMouseOver(e:MouseEvent):void {
			this.alpha = .4;
		}
		
		private function onMouseOut(e:MouseEvent):void {
			if(!isActive) this.alpha = 0;
		}
	}
	
}
