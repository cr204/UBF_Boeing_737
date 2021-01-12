package com.winglet.assets {
	
	import flash.display.MovieClip;
	
	
	public class InfoBox extends MovieClip {
		
		
		public function InfoBox() {
			// constructor code
		}
		
		public function setInfoData(obj:Object):void {
			if(obj.boxFrame=="1") {
				this.gotoAndStop(1);
			} else if(obj.boxFrame=="2") {
				this.gotoAndStop(2);
			} else this.gotoAndStop(3);
			txt1.text = obj.infoText;
		}
	}
	
}
