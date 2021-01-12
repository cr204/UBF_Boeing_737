package com.winglet.assets.elements {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.greensock.*;
	
	public class Element23Guard extends MovieClip {
		private var element:*;
		private var myTween:TweenLite;
		public var isActiveElement:Boolean = false;
		public var conf:MovieClip = new MovieClip();
		
		public function Element23Guard() {
			// constructor code
			stop();
			this.buttonMode = true
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
		}
		
		public function guardElement(elm:Sprite):void {
			element = elm;
		}
		
		public function active(b:Boolean) {
			isActiveElement = b;
		}

		private function mouseOverHandler(e:MouseEvent):void {
			if(element.isActiveElement) myTween = new TweenLite(this, 0, {delay:.2, onComplete:openGuard });
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			if(element!=null) {
				this.removeEventListener(MouseEvent.MOUSE_DOWN, interactToElement);
				this.removeEventListener(MouseEvent.MOUSE_UP, interactToElement);
				interactToElement(e);
			}
			if(element.isActiveElement) {
				myTween.restart();
				myTween.pause();
			}
			gotoAndStop(1);
		}
		
		private function openGuard():void {
			gotoAndStop(2);
			if(element!=null) {
				this.addEventListener(MouseEvent.MOUSE_DOWN, interactToElement);
				this.addEventListener(MouseEvent.MOUSE_UP, interactToElement);
			}
		}
		
		private function interactToElement(e:MouseEvent):void {
			element.dispatchEvent(e);
		}
		
	}
}