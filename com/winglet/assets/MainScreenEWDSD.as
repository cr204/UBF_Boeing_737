package com.winglet.assets {
	
	import flash.display.Sprite;
	
	
	public class MainScreenEWDSD extends Sprite {
		
		
		public function MainScreenEWDSD() {
			// constructor code
			
			var pObj:* = parent;
			screenEWD.init(pObj);

			sdBlankScreen.visible = false;
		}
	}
	
}
