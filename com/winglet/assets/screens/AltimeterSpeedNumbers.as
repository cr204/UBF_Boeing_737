package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import com.winglet.assets.screens.AltimeterTapeNumber;
	
	public class AltimeterSpeedNumbers extends Sprite {
		
		
		public function AltimeterSpeedNumbers() {
			// constructor code
			holder.n1.setNumber(430);
			buildNumbers();
		}
		
		private function buildNumbers():void {
			var posY:Number = -2;
			
			for(var i:int=429; i>0; --i) {
				i -=1;
				var atn:AltimeterTapeNumber = new AltimeterTapeNumber();
				posY += 55;
				atn.y = posY;
				atn.setNumber(i);
				holder.addChild(atn);
			}
			
			//trace("Child: " + this.numChildren + "  Height: " + this.height);
			
		}
		
		
	}
}