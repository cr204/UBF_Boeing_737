package com.winglet.assets.elements {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.winglet.events.ElementPressedEvent;
	import com.winglet.events.ElementStateEvent;
	
	public class Element02 extends ElementMCBase {
		public var isActiveElement:Boolean = false;
		public var elementSSwitch:Number;
		private var switchState:int = 0;
		private var _isConditionalElement:Boolean = false;
		private var _sprungLoaded:Boolean = false;
		private var sprungSide:int = 0;
		
		public function Element02() {
			// constructor code
			stop();
			this.mouseChildren = false;
			this.buttonMode = true;
			// *************
		}
		
		public function set defaultPosition(n:uint):void {
			gotoAndStop(n);
			switchState = n;
			isActiveElement = false;
		}
		
		public function set active(b:Boolean):void {
			if(b) {
				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				if(_sprungLoaded) this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				this.mouseChildren = true;
			} else {
				this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				this.mouseChildren = false;
			}
			isActiveElement = b;
		}
		
		public function set sprungLoaded(b:Boolean):void {
			_sprungLoaded = b;
			if(_sprungLoaded) this.gotoAndStop(2);
		}
		
		public function sprungLoadedSide(n):void {
			sprungSide = n;
		}
		
		public function sSwitch(s:String):void {
			elementSSwitch = Number(s);
		}
		
		public function get elementState():int {
			switchState = currentFrame;
			return switchState;
		}
		
		public function set setAsConditionalElement(b:Boolean):void {
			_isConditionalElement = b;
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			var target = e.target;
			switch(target.name) {
				case "state1":
						moveUp();
					break;
				case "state2":
						moveDown();
					break;
			}
			if(_isConditionalElement) dispatchEvent(new ElementStateEvent(ElementStateEvent.CHANGED));
		}
		
		private function moveUp():void {
			if(_sprungLoaded) {
				if(this.currentFrame==3 && sprungSide==1) gotoAndStop(2) else gotoAndStop(1);
				if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
			} else {
				if(currentFrame!=1) prevFrame();
				if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
				switchState = currentFrame;
			}
		}
		
		private function moveDown():void {
			if(_sprungLoaded) {
				if(this.currentFrame==1 && sprungSide==3) gotoAndStop(2) else gotoAndStop(3);
				if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
			} else {
				if(currentFrame!=3) nextFrame();
				if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
				switchState = currentFrame;
			}
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			if(sprungSide>0 && this.currentFrame==sprungSide) {
				this.gotoAndStop(2);
			} else if(sprungSide==0) this.gotoAndStop(2);
			if(!isActiveElement) this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		public function resetElement():void {
			active = false;
			gotoAndStop(1);
			switchState = 0;
		}
		
	}
}