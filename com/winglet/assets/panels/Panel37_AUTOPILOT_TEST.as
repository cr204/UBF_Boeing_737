package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel37_AUTOPILOT_TEST extends PanelBase {
		
		public function Panel37_AUTOPILOT_TEST() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.cpt_ap_prst_light.setText("A/P     P/RST");
			elementHolder.cpt_ap_prst_light.setColors(Colors.GREY, Colors.RED);
			elementHolder.cpt_ap_prst_light.useNoise = true;
			elementHolder.cpt_ap_prst_light.pressTimeOut(0);
			
			elementHolder.cpt_at_prst_light.setText("A/T     P/RST");
			elementHolder.cpt_at_prst_light.setColors(Colors.GREY, Colors.RED);
			elementHolder.cpt_at_prst_light.pressTimeOut(0);
			
			elementHolder.cpt_fmc_prst_light.setText("FMC     P/RST");
			elementHolder.cpt_fmc_prst_light.setColors(Colors.GREY, Colors.RED);
			elementHolder.cpt_fmc_prst_light.pressTimeOut(0);
			
			elementHolder.speed_brake_armed_light.setText("SPEED BRAKE DO NOT ARM");
			elementHolder.speed_brake_armed_light.setColors(Colors.GREY, Colors.GREEN);
			
			elementHolder.speed_brake_not_armed_light.setText("SPEED BRAKE EXTENDED");
			elementHolder.speed_brake_not_armed_light.setColors(Colors.GREY, Colors.AMBER);
		}
		
		override protected function resetAssets():void {
			elementHolder.speed_brake_armed_light.showState(0);
			elementHolder.speed_brake_not_armed_light.showState(0);
			elementHolder.cpt_ap_prst_light.showState(0);
			elementHolder.cpt_at_prst_light.showState(0);
			elementHolder.cpt_fmc_prst_light.showState(0);
			elementHolder.stab_out_of_trim_light.showState(0);
			
			//elementHolder.elt_switch.resetElement();
		}

	}	
}