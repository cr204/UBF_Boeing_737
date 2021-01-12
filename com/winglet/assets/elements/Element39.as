package com.winglet.assets.elements {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.winglet.events.ElementPressedEvent;
	
	public class Element39 extends ElementMCBase {
		public var isActiveElement:Boolean = false;
		public var elementSSwitch:Number;
		private var currState:int = 0;;
		
		public function Element39() {
			// constructor code
			stop();
			this.buttonMode = true
			dots.visible = false;
		}
		
		public function sSwitch(s:String):void {
			if(s=="on") elementSSwitch=1 else elementSSwitch=0;
			//elementSSwitch = Number(s);
		}
		
		public function showState(n:int):void {
			if(n==0) dots.visible=false else dots.visible=true;
		}
		
		public function switchState(s:String):void {
			//
		}
		
		public function set active(b:Boolean):void {
			if(b) {
				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			} else {
				this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
			isActiveElement = b;
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
			gotoAndStop(2);
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			gotoAndStop(1);
			this.removeEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
			if(elementSSwitch==1) dots.visible=true else dots.visible=false;
			//if(elementSSwitch==this.currentFrame) this.dispatchEvent(new ElementPressedEvent(String(this.currentFrame)));
			this.dispatchEvent(new ElementPressedEvent(String(elementSSwitch)));
		}
		
		public function resetElement():void {
			currState = 0;
			active = false;
			gotoAndStop(1);
			dots.visible = false;
		}
		
		
	}
}