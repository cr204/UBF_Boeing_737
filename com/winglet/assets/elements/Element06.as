package com.winglet.assets.elements {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.winglet.events.ElementPressedEvent;
	import com.greensock.TweenLite;
	
	public class Element06 extends ElementMCBase {
		public var isActiveElement:Boolean = false;
		public var elementSSwitch:Number;
		private var myTween:TweenLite;
		private var currPosition:int = 2;
		
		public function Element06() {
			// constructor code
			stop();
			this.buttonMode = true
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			// *************
			//isActiveElement = true;
			//active = true;
		}
		
		public function set defaultPosition(n:int):void {
			//gotoAndStop(n + 1);
			currPosition = n + 1;
			isActiveElement = false;
		}
		
		public function set active(b:Boolean):void {
			if(b) {
				// Mouse DOWN must be enabled only after guard is opened!
				//this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			} else {
				this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			}
			isActiveElement = b;
		}

		public function sSwitch(s:String):void {
			elementSSwitch = Number(s) + 1;
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			if(conf) {
				if(isActiveElement) {
					conf.confValue=true;
					myTween = new TweenLite(this, 0, {delay:1.3, onComplete:openGuard });
				} else conf.confValue=false;
				conf.displayTooltip();
			} else if(isActiveElement)openGuard();
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			if(conf) conf.reset();
			if(this.currentFrame!=2) gotoAndStop(1);
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			if(currentFrame==2) gotoAndStop(3) else gotoAndStop(2);
			currPosition = this.currentFrame;
			if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
		}
		
		private function openGuard():void {
			// Mouse DOWN must be enabled only after guard is opened!
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			gotoAndStop(currPosition);
		}
		
		public function resetElement():void {
			active = false;
			gotoAndStop(1);
			currPosition = 2;
		}
		
	}
}