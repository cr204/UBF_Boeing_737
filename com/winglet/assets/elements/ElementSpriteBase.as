package com.winglet.assets.elements {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	public class ElementSpriteBase extends Sprite {
		public var conf:MovieClip;
		
		public function ElementSpriteBase() {
			// constructor code
		}
		
		public function guardConfirmation(con:MovieClip):void {
			conf = con;
		}

	}
}