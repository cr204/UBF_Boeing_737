package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	
	public class Element04 extends ElementSpriteBase {
		private var ct:ColorTransform=new ColorTransform();
		private var colorArr:Array = [];
		
		public function Element04() {
			// constructor code
			this.mouseChildren = false;
		}
		
		public function setText(s:String):void {
			//var n:Array = s.split(" ");
			//if(n.length<2) txt.y = 7;
			
			txt.text = s;
			var n:int = txt.numLines;
			if(n<2) txt.y = 7;
			
		}
		
		public function setColors(...args:Array):void {
//			var ts:String = args.toString();
			colorArr = args; //ts.split(",");
		}
		
		public function showState(n:int):void {
			tintClip(txt, colorArr[n]);
			tintClip(bline, colorArr[n]);
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