package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Panel15_LIGHTS extends PanelBase {
		
		public function Panel15_LIGHTS() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			/*
			elementHolder.data1.rotationDegrees(290, 320, 340, 15, 40, 65);
			elementHolder.data1.defaultPosition = 1;
			*/
		}
		
		override protected function resetAssets():void {
			elementHolder.circuit_breaker_light_selector.resetElement();
			elementHolder.panel_light_selector.resetElement();
		}
		
	}
}
