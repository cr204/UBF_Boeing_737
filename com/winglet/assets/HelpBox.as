package com.winglet.assets {
	
	import flash.display.MovieClip;
	
	
	public class HelpBox extends MovieClip {
		public var hasMainStateNote:Boolean = false;
		
		private var sText:String = "";
		private var tText:String = "";
		
		public function HelpBox() {
			// constructor code
			stop();
		}
		
		public function setBoxData(obj:Object, n:int=1):void {
			var ntxt:String = "";
			if(obj.completed=="yes") {
				ntxt = noteText.text;
				gotoAndStop(2);
				noteText.text = ntxt;
			} else gotoAndStop(n);
			txt.text = obj.htext;
			if(obj.note=="") {
				hasMainStateNote = false;
				noteText.text = "";
				if(ntxt!="") noteText.text = ntxt;
			} else {
				noteText.text = obj.note;
				hasMainStateNote = true;
			}
			
			switch(obj.source) {
				case "ECAM":
					sourceBox.gotoAndStop(1);
					sourceBox.txt.text = "Source: ECAM";
					break;
				case "QRH":
					sourceBox.gotoAndStop(2);
					sourceBox.txt.text = "Source: QRH";
					break;
				case "SOPS":
					sourceBox.gotoAndStop(3);
					sourceBox.txt.text = "Source: SOPS";
					break;
				case "BEST PRACTICE":
					sourceBox.gotoAndStop(4);
					sourceBox.txt.text = "Source: BEST PRACTICE";
					break;
				case "":
					sourceBox.gotoAndStop(5);
					break;
				default:
					trace("Error! Unknown type of HelpBox.SOURCE: " + obj.source + "in HelpBox.as - setBoxData() function.");
					break;
			}
		}
		
		public function setBoxNote(s:String):void {
			trace("setBoxNote()");
		}
		
		public function blockSystemMessage(msg:String):void {
			tText = txt.text;
			txt.text = msg;
			
			//sText = 
		}
		
		public function unblock():void {
			trace("unblock!");
			if(tText!="") txt.text = tText;
			tText = "";
			//sourceBox
			sText = "";
			this.visible = false;
		}

	}
	
}
