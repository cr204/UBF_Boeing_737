package com.winglet.assets {
	
	import flash.display.MovieClip;
	
	
	public class HelpBox extends MovieClip {
		
		
		public function HelpBox() {
			// constructor code
		}
		
		public function setBoxData(obj:Object, n:int=1):void {
			gotoAndStop(1);
			txt.text = obj.htext;
			noteText.text = obj.note;
		}

		

	}
	
}
