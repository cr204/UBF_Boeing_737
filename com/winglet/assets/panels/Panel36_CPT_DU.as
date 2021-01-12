package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Panel36_CPT_DU extends PanelBase {
		
		public function Panel36_CPT_DU() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.main_panel_du.rotationDegrees(303, 0, 54, 104, 149);
			elementHolder.main_panel_du.defaultPosition = 1;
			
			elementHolder.lower_du.rotationDegrees(303, 0, 54);
			elementHolder.lower_du.defaultPosition = 1;
		}
		
		override protected function resetAssets():void {
			elementHolder.main_panel_du.resetElement();
			elementHolder.lower_du.resetElement();
		}

	}	
}