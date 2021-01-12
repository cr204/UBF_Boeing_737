package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import fl.motion.easing.Linear;
	
	public class PFD_AH_Graphics extends Sprite {
		
		
		public function PFD_AH_Graphics() {
			// constructor code
		}
		
		public function setAHPositionY(p:Number, t:Number):void {
			var posY:Number = -68 + p * 3.05;
			TweenLite.to(ah, t, {y:posY, ease:Linear.easeNone, overwrite:false});
		}
		
		public function reset():void {
			TweenLite.killTweensOf(ah);
			ah.y = -68;
		}
		
	}
}