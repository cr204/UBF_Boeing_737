package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.events.ElementPressedEvent;
	
	public class Element48 extends ElementSpriteBase {
		public var isActiveElement:Boolean = false;
		public var elementSSwitch:String;
		
		public function Element48() {
			// constructor code
			btn.buttonMode = true;
		}
		
		public function resetElement():void {
			this.active = false;
			btn.y = 0;
		}
		
		public function sSwitch(s:String):void {
			elementSSwitch = s;
		}
		
		// defaultPosition is used to control Flap Levers postion from XML, same as showState!
		public function set defaultPosition(n:uint):void {
			switch(n) {
				case 0:
					btn.y = 0;
					break;
				case 1:
					btn.y = 28;
					break;
				case 2:
					btn.y = 63;
					break;
				case 5:
					btn.y = 98;
					break;
				case 10:
					btn.y = 130;
					break;
				case 15:
					btn.y = 163;
					break;
				case 25:
					btn.y = 195;
					break;
				case 30:
					btn.y = 230;
					break;
				case 40:
					btn.y = 260;
					break;
			}
		}
		
		public function set active(b:Boolean):void {
			if(b) {
				btn.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			} else {
				btn.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			}
			isActiveElement = b;
			btn.isActiveElement = b;
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			checkPosition();
		}
		
		private function mouseMoveHandler(e:MouseEvent):void {
			if(this.mouseY<28) {
				btn.y = 0;
		    } else if(this.mouseY>28 && this.mouseY<60) {
				btn.y = 28;
			} else if(this.mouseY>60 && this.mouseY<95) {
				btn.y = 63;
			} else if(this.mouseY>95 && this.mouseY<128) {
				btn.y = 98;
			} else if(this.mouseY>128 && this.mouseY<160) {
				btn.y = 130;
			} else if(this.mouseY>160 && this.mouseY<190) {
				btn.y = 163;
			} else if(this.mouseY>190 && this.mouseY<228) {
				btn.y = 195;
			} else if(this.mouseY>228 && this.mouseY<260) {
				btn.y = 230;
			} else if(this.mouseY>260 && this.mouseY<290) {
				btn.y = 260;
			}
		}
		
		private function checkPosition():void {
			switch(btn.y) {
				case 0:
					if(elementSSwitch=="0") this.dispatchEvent(new ElementPressedEvent("0"));
					break;
				case 28:
					if(elementSSwitch=="1") this.dispatchEvent(new ElementPressedEvent("1"));
					break;
				case 63:
					if(elementSSwitch=="2") this.dispatchEvent(new ElementPressedEvent("2"));
					break;
				case 98:
					if(elementSSwitch=="5") this.dispatchEvent(new ElementPressedEvent("3"));
					break;
				case 130:
					if(elementSSwitch=="10") this.dispatchEvent(new ElementPressedEvent("10"));
					break;
				case 163:
					if(elementSSwitch=="15") this.dispatchEvent(new ElementPressedEvent("15"));
					break;
				case 195:
					if(elementSSwitch=="25") this.dispatchEvent(new ElementPressedEvent("25"));
					break;
				case 230:
					if(elementSSwitch=="30") this.dispatchEvent(new ElementPressedEvent("30"));
					break;
				case 260:
					if(elementSSwitch=="40") this.dispatchEvent(new ElementPressedEvent("40"));
					break;
			}
		}
		
	}
}