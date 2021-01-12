package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel12_APU extends PanelBase {
		
		public function Panel12_APU() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.l_wiper_selector.rotationDegrees(0, 45, 90, 135);
			elementHolder.l_wiper_selector.defaultPosition = 0;
			
			elementHolder.r_wiper_selector.rotationDegrees(0, 45, 90, 135);
			elementHolder.r_wiper_selector.defaultPosition = 0;
			
			elementHolder.apu_low_oil_pressure_light.setText("LOW OIL PRESSURE");
			elementHolder.apu_low_oil_pressure_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.apu_fault_light.setText("FAULT");
			elementHolder.apu_fault_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.apu_overspeed_light.setText("OVER    SPEED");
			elementHolder.apu_overspeed_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.apu_maint_light.setText("MAINT");
			
			elementHolder.start_switch.sprungLoaded = true;
			elementHolder.start_switch.sprungLoadedSide(3);
		}
		
		override protected function resetAssets():void {
			elementHolder.apu_maint_light.showState(0);
			elementHolder.apu_low_oil_pressure_light.showState(0);
			elementHolder.apu_fault_light.showState(0);
			elementHolder.apu_overspeed_light.showState(0);
			
			elementHolder.l_wiper_selector.resetElement();
			elementHolder.r_wiper_selector.resetElement();
			elementHolder.start_switch.resetElement();
			elementHolder.egt_gauge.resetElement();
		}

	}
}
