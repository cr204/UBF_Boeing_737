package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel41_BRAKE_PRESS extends PanelBase {
		
		public function Panel41_BRAKE_PRESS() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.fo_ap_prst_light.setText("A/P     P/RST");
			elementHolder.fo_ap_prst_light.setColors(Colors.GREY, Colors.RED);
			elementHolder.fo_ap_prst_light.pressTimeOut(0);
			
			elementHolder.fo_at_prst_light.setText("A/T     P/RST");
			elementHolder.fo_at_prst_light.setColors(Colors.GREY, Colors.RED);
			elementHolder.fo_at_prst_light.pressTimeOut(0);
			
			elementHolder.fo_fmc_prst_light.setText("FMC     P/RST");
			elementHolder.fo_fmc_prst_light.setColors(Colors.GREY, Colors.RED);
			elementHolder.fo_fmc_prst_light.pressTimeOut(0);
			
			elementHolder.speedbrakes_extended_light.setText("SPEED BRAKE EXTENDED");
			elementHolder.speedbrakes_extended_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.below_gs_inhibit_light.setText("BELOW G/S INHIBIT");
			elementHolder.below_gs_inhibit_light.setColors(Colors.GREY, Colors.AMBER);
		}
		
		override protected function resetAssets():void {
			elementHolder.speedbrakes_extended_light.showState(0);
			elementHolder.below_gs_inhibit_light.showState(0);
		}

	}	
}