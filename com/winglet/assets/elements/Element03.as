package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.events.ElementPressedEvent;
	
	public class Element03 extends ElementSpriteBase {
		private var rotArr:Array = [];
		private var currPos:int = 0;
		public var isActiveElement:Boolean = false;
		public var elementSSwitch:Number;
		private var _defaultPosition:int = 0;
		
		public function Element03() {
			// constructor code
			this.buttonMode = true;
			this.mouseChildren = false;
		}
		public function rotationDegrees(...args:Array):void {
			var ts:String = args.toString();
			rotArr = ts.split(",");
		}
		
		public function set defaultPosition(n:int):void {
			if(currPos>rotArr.length-1) currPos = 0 else currPos = n;
			isActiveElement = false;
			_defaultPosition = n;
			position(currPos);
		}
		
		public function set active(b:Boolean) {
			if(b) {
				this.addEventListener(MouseEvent.MOUSE_DOWN, onRotateBtn);
				this.mouseChildren = true;
			} else {
				this.removeEventListener(MouseEvent.MOUSE_DOWN, onRotateBtn);
				this.mouseChildren = false;
			}
			isActiveElement = b;
		}
		
		public function sSwitch(s:String):void {
			elementSSwitch = Number(s);
		}
		
		private function onRotateBtn(e:MouseEvent):void {
			var target = e.target;
			switch(target.name) {
				case "state1":
						--currPos;
						if(currPos<0) currPos = 0;
					break;
				case "state2":
						++currPos;
						if(currPos>rotArr.length-1) currPos = rotArr.length-1;
					break;
			}
			position(currPos);
			if(elementSSwitch==currPos) this.dispatchEvent(new ElementPressedEvent(String(currPos)));
		}
		
		
		private function position(n:Number):void {
			if(rotArr[n] != undefined) {
				btn.rotationZ = uint(rotArr[n]);
			}
		}
		
		public function resetElement():void {
			active = false;
			position(_defaultPosition);
		}
		
		
	}
}