package com.winglet.assets.elements {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.winglet.events.ElementPressedEvent;
	import com.greensock.TweenLite;
	
	public class Element06_3 extends ElementMCBase {
		public var isActiveElement:Boolean = false;
		public var elementSSwitch:Number;
		private var myTween:TweenLite;
		private var currPosition:int = 2;
		private var _sprungLoaded:Boolean = false;
		private var sprungSide:int = 0;
		
		public var isPanel10:Boolean = false;
		
		public function Element06_3() {
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
			currPosition = n + 1;
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
			//if(_sprungLoaded) this.gotoAndStop(3);
		}
		
		public function sprungLoadedSide(n):void {
			sprungSide = n;
		}

		public function sSwitch(s:String):void {
			elementSSwitch = Number(s) + 1;
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			if(conf) {
				if(isActiveElement) conf.confValue=true else conf.confValue=false;
				conf.displayTooltip();
				if(isActiveElement) myTween = new TweenLite(this, 0, {delay:1.5, onComplete:openGuard });
			} else openGuard();
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			if(conf) conf.reset();
			if(isPanel10) {
				if(this.currentFrame>3) gotoAndStop(1);
			} else {
				if(this.currentFrame!=2) gotoAndStop(1);
			}
			
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			var n:Number = e.target.mouseY;
			if(n<46) moveUp() else moveDown();
//			if(currentFrame==4) gotoAndStop(2) else nextFrame();
//			if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
		}
		
		private function moveUp():void {
			if(_sprungLoaded) {
				if(this.currentFrame==4 && sprungSide==1) gotoAndStop(3) else gotoAndStop(2);
				if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
			} else {
				if(currentFrame>2) prevFrame();
				currPosition = this.currentFrame;
				if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
			}
		}
		
/*		private function moveUp():void {
			if(currentFrame>2) prevFrame();
			currPosition = this.currentFrame;
			if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
		} */
		
		private function moveDown():void {
			if(_sprungLoaded) {
				if(this.currentFrame==2 && sprungSide==3) gotoAndStop(3) else gotoAndStop(4);
				if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
			} else {
				if(currentFrame<4) nextFrame();
				currPosition = this.currentFrame;
				if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
			}
		}
		
/*		private function moveDown():void {
			if(currentFrame<4) nextFrame();
			currPosition = this.currentFrame;
			if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
		}  */
		
		private function mouseUpHandler(e:MouseEvent):void {
			if(sprungSide>0 && this.currentFrame==sprungSide+1) {
				this.gotoAndStop(3);
			} else if(sprungSide==0) this.gotoAndStop(3);
			if(!isActiveElement) this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function openGuard():void {
			if(this.currentFrame==1) gotoAndStop(currPosition);
		}
		
		public function resetElement():void {
			active = false;
			gotoAndStop(1);
			currPosition = 2;
		}
		
	}
}