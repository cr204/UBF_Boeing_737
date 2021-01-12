package com.winglet.assets.elements {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.winglet.events.ElementPressedEvent;
	
	public class Element01 extends ElementMCBase {
		public var isActiveElement:Boolean = false;
		public var elementSSwitch:Number;
		
		public function Element01() {
			// constructor code
			stop();
			this.buttonMode = true
			this.mouseChildren = false;
		}
		
		public function set defaultPosition(n:uint):void {
			gotoAndStop(n);
			isActiveElement = false;
		}
		
		public function set active(b:Boolean):void {
			if(b) {
				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				this.mouseChildren = true;
			} else {
				this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				this.mouseChildren = false;
			}
			isActiveElement = b;
		}

		public function sSwitch(s:String):void {
			elementSSwitch = Number(s);
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			if(currentFrame==1) gotoAndStop(2) else gotoAndStop(1);
			if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
		}
		
		public function resetElement():void {
			active = false;
			gotoAndStop(1);
		}
		

	}
	
}
