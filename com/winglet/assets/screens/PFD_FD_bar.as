package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	
	public class PFD_FD_bar extends Sprite {
		
		
		public function PFD_FD_bar() {
			// constructor code
			//fd_pitch_bar
			//fd_roll_bar
		}
		
		public function setPitchPosition(val:Number, time:Number):void {
			var posY:Number = 43 + val * 3.05;
			TweenLite.to(fd_pitch_bar, time, {y:posY, ease:Linear.easeNone, overwrite:false});
		}
		
		public function setRollPosition(val:Number, time:Number):void {
			var posX:Number = 43 + val * 3.05;
			TweenLite.to(fd_roll_bar, time, {x:posX, ease:Linear.easeNone, overwrite:false});
		}
		
		
	}
}