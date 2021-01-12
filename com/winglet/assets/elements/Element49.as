package com.winglet.assets.elements {
	
	import com.winglet.assets.elements.ElementSpriteBase;
	import com.winglet.events.ElementPressedEvent;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import com.greensock.TweenLite;
	
	public class Element49 extends ElementSpriteBase {
		public var isActiveElement:Boolean = false;
		public var elementSSwitch:String;
		private var pointer0:Point = new Point();
	
		public function Element49() {
			// constructor code
			btn.buttonMode = true;
		}
		
		public function resetElement():void {
			this.active = false;
			btn.y = 0;
		}
		
		public function switchState(n:int):void {
			//
		}

		
		public function sSwitch(s:String):void {
			elementSSwitch = s;
		}
		
		// defaultPosition is used to control Flap Levers postion from XML, same as showState!
		public function set defaultPosition(n:uint):void {
			
		}
		
		public function showState(s:String):void {
			switch(s) {
				case "up":
					updateLeverPosition(-107);
					break;
				case "down":
					updateLeverPosition(228);
					break;
				case "off":
					updateLeverPosition(60);
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
			if(this.mouseY>-107 && this.mouseY<228) {
				updateLeverPosition(this.mouseY);
			}
		}
		
		private function updateLeverPosition(n:Number):void {
			btn.y = n;
			var sclY:Number;
			if(n<60) {
				sclY = (167 - Math.abs(-107 - n)) / -167;
			} else {
				sclY = (-61 + n) / 167;
			}
			lever.scaleY = sclY;
		}
		
		private function checkPosition():void {
			pointer0.x = btn.y;
			if(btn.y<=5) movePosition(-107);
			if(btn.y>5 && btn.y<=130) movePosition(60);
			if(btn.y>130) movePosition(228);
		}
		
		private function movePosition(n:Number):void {
			TweenLite.to(pointer0, .3, {x:n, onUpdate:uFunction, onComplete:fnCompleted});
			
		}
		
		private function uFunction():void {
			updateLeverPosition(pointer0.x);
		}
		
		private function fnCompleted():void {
			switch(btn.y) {
				case -107:
					if(elementSSwitch=="up") this.dispatchEvent(new ElementPressedEvent("up"));
					break;
				case 60:
					if(elementSSwitch=="off") this.dispatchEvent(new ElementPressedEvent("off"));
					break;
				case 228:
					if(elementSSwitch=="down") this.dispatchEvent(new ElementPressedEvent("down"));
					break;
				default:
					trace("Error btn.y: " + btn.y + " - position in Element49.as!");
					break;
			}
		}
		
	}
}