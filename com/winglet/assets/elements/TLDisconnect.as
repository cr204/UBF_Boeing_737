package com.winglet.assets.elements {
	import flash.display.Sprite;
	import com.winglet.events.ElementPressedEvent;
	
	public class TLDisconnect extends ElementSpriteBase {
		private var tl1:Element32;
		private var tl2:Element32a;
		public var isActiveElement:Boolean = false;

		public function TLDisconnect() {
			// constructor code
		}
		
		public function thrustLevers(t1:Element32, t2:Element32a):void {
			tl1 = t1;
			tl2 = t2;
		}
		
		public function set active(b:Boolean):void {
			tl1.activateDisconnect = tl2.activateDisconnect = b;
			if(b) {
				tl1.addEventListener(ElementPressedEvent.PRESSED, onElementPressed);
				tl2.addEventListener(ElementPressedEvent.PRESSED, onElementPressed);
			} else {
				tl1.removeEventListener(ElementPressedEvent.PRESSED, onElementPressed);
				tl2.removeEventListener(ElementPressedEvent.PRESSED, onElementPressed);
			}
			isActiveElement = b;
		}
		
		public function sSwitch(s:String):void {
			//
		}
		
		public function switchState(n:Number):void {
			//
		}
		
		public function resetElement():void {
			active = false;
		}
		
		private function onElementPressed(e:ElementPressedEvent):void {
			this.dispatchEvent(new ElementPressedEvent("1"));
		}
		
	}
}