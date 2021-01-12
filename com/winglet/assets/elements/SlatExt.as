package com.winglet.assets.elements {
	
	import flash.display.MovieClip;
	
	
	public class SlatExt extends MovieClip {
		
		
		public function SlatExt() {
			// constructor code
			stop();
		}
		
		public function showState(n:int):void {
			if(n==1) this.gotoAndStop(2) else this.gotoAndStop(1);
		}
		
		public function changeTopText(s:String):void {
			if(s=="on") this.gotoAndStop(2) else this.gotoAndStop(1);
		}
		
	}
}