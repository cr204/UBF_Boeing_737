package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Panel05_NAVS_AND_DISPLAYS extends PanelBase {
		
		public function Panel05_NAVS_AND_DISPLAYS() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.display_source_selector.rotationDegrees(309, 0, 48);
			elementHolder.display_source_selector.defaultPosition = 1;
			
		}
		
		override protected function resetAssets():void {
			elementHolder.vhf_nav_selector.resetElement();
			elementHolder.irs_selector.resetElement();
			elementHolder.fmc_selector.resetElement();
			elementHolder.display_control_panel_selector.resetElement();
			elementHolder.display_source_selector.resetElement();
		}

	}
}
