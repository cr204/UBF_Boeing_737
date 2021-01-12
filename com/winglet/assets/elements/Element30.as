package com.winglet.assets.elements {

	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	public class Element30 extends Sprite {
		private var ct:ColorTransform=new ColorTransform();
		private var colorArr:Array = [];
		private var _ignoreTurnOff:Boolean = false;
		
		public function Element30() {
			// constructor code
		}
		
		public function setText(s:String):void {
			txt.text = s;
		}
		
		public function ignoreTurnOff():void {
			_ignoreTurnOff = true;
		}
		
		public function setColors(...args:Array):void {
			colorArr = args; //ts.split(",");
		}
		
		public function showState(n:int):void {
//			trace("Element30.showState.n:" + n);
//			trace("_ignoreTurnOff: " + _ignoreTurnOff);
			if(n==0) { 
			   if(!_ignoreTurnOff) tintClip(txt, colorArr[n]);
			   _ignoreTurnOff = false;
			 } else tintClip(txt, colorArr[n]);
			
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