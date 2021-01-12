package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	
	
	public class AltimeterTapeNumber extends Sprite {
		
		
		public function AltimeterTapeNumber() {
			// constructor code
		}
		
		public function setNumber(n:Number):void {
			txt1.text = n.toString().substr(0,2);
			txt2.text = n.toString().substr(2,1) + "00";
		}
	}
	
}
