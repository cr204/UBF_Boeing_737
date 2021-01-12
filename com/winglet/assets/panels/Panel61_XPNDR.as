package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Panel61_XPNDR extends PanelBase {
		
		public function Panel61_XPNDR() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.dial.rotationDegrees(270, 300, 340, 20, 55, 90);
			elementHolder.dial.defaultPosition = 4;
		}
		
		override protected function resetAssets():void {
			/*
			elementHolder.data1.defaultPosition = 1;
			*/
		}

	}
}