package com.winglet.assets.elements {
	import flash.display.MovieClip;
	
	public class ElementMCBase extends MovieClip {
		public var conf:MovieClip;
		
		public function ElementMCBase() {
			// constructor code
		}
		
		public function guardConfirmation(con:MovieClip):void {
			conf = con;
		}

	}
}