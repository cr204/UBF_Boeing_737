package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel58_CARGO extends PanelBase {
		
		public function Panel58_CARGO() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.cargo_detector_fault_light.setText("DETECTOR FAULT");
			elementHolder.cargo_detector_fault_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.cargo_fwd_arm_button.setText("ARMED");
			elementHolder.cargo_fwd_arm_button.setColors(Colors.GREY, Colors.WHITE);
			
			elementHolder.cargo_disch_button.setText("ARMED");
			elementHolder.cargo_disch_button.setColors(Colors.GREY, Colors.WHITE);
			
			elementHolder.cargo_ext_fwd_light.setText("FWD");
			elementHolder.cargo_ext_fwd_light.setColors(Colors.GREY, Colors.GREEN);
			
			elementHolder.cargo_ext_aft_light.setText("AFT");
			elementHolder.cargo_ext_aft_light.setColors(Colors.GREY, Colors.GREEN);
		}
		
		override protected function resetAssets():void {
			elementHolder.cargo_detector_fault_light.showState(0);
			elementHolder.cargo_fwd_arm_button.showState(0);
			elementHolder.cargo_ext_fwd_light.showState(0);
			elementHolder.cargo_disch_button.showState(0);
			elementHolder.cargo_ext_aft_light.showState(0);
		}

	}
}