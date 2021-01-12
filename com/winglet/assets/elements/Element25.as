package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	
	public class Element25 extends ElementSpriteBase {
		private var ct:ColorTransform=new ColorTransform();
		private var colorArr:Array = new Array(0x004574, 0x0099FF, 0x196C99);
		
		public function Element25() {
			// constructor code
		}
		
		public function setText(s:String):void {
			txt.text = s;
			var n:int = txt.numLines;
			if(n<2) txt.y = 5;
			
		}
		
		public function setColors(...args:Array):void {
//			var ts:String = args.toString();
			//colorArr = args; //ts.split(",");
		}
		
		public function showState(n:int):void {
			tintClip(bg, colorArr[n]);
		}

		
		
		private function tintClip(obj:*, c:uint):void {
			
			var color:uint=c; //picker.selectedColor;
			var mul:Number=1; //slider.value/100;
			var ctMul:Number=(1-mul);
			var ctRedOff:Number=Math.round(mul*extractRed(color));
			var ctGreenOff:Number=Math.round(mul*extractGreen(color));
			var ctBlueOff:Number=Math.round(mul*extractBlue(color));
			ct=new ColorTransform(ctMul,ctMul,ctMul,1,ctRedOff,ctGreenOff,ctBlueOff,0);
			obj.transform.colorTransform=ct;
		}
		
		private function extractRed(c:uint):uint {
			return (( c >> 16 ) & 0xFF);
		}
		
		private function extractGreen(c:uint):uint {
			return ( (c >> 8) & 0xFF );
		}
		
		private function extractBlue(c:uint):uint {
			return ( c & 0xFF );
		}
	}
}
