package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Panel42_FO_DU extends PanelBase {
		
		public function Panel42_FO_DU() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.main_panel_du.rotationDegrees(210, 248, 300, 0, 60);
			elementHolder.main_panel_du.defaultPosition = 3;
			
			elementHolder.lower_du.rotationDegrees(303, 0, 54);
			elementHolder.lower_du.defaultPosition = 1;
		}
		
		override protected function resetAssets():void {
			elementHolder.main_panel_du.resetElement();
			elementHolder.lower_du.resetElement();
		}

	}	
}