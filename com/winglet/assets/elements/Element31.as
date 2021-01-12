package com.winglet.assets.elements {
	
	import flash.display.MovieClip;
	
	
	public class Element31 extends MovieClip {
		
		
		public function Element31() {
			// constructor code
			stop();
		}
		
		public function showState(n:int):void {
			if(n==0) gotoAndStop(1) else gotoAndStop(2);
		}
		
	}
}