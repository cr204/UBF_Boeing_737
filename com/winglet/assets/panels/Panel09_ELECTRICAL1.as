package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel09_ELECTRICAL1 extends PanelBase {
		
		public function Panel09_ELECTRICAL1() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.dc_meters_selector.rotationDegrees(235, 270, 315, 0, 45, 90, 135);
			elementHolder.dc_meters_selector.defaultPosition = 3;

			elementHolder.ac_meters_selector.rotationDegrees(235, 270, 315, 0, 45, 90, 135);
			elementHolder.ac_meters_selector.defaultPosition = 3;
			
			elementHolder.bat_discharge_light.setText("BAT DISCHARGE");
			elementHolder.bat_discharge_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.tr_unit_light.setText("TR UNIT");
			elementHolder.tr_unit_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.elec_light.setText("ELEC");
			elementHolder.elec_light.setColors(Colors.GREY, Colors.AMBER);
			
		}
		
		override protected function resetAssets():void {
			elementHolder.bat_discharge_light.showState(0);
			elementHolder.tr_unit_light.showState(0);
			elementHolder.elec_light.showState(0);
			
			elementHolder.dc_meters_selector.resetElement();
			elementHolder.ac_meters_selector.resetElement();
			elementHolder.cab_util.resetElement();
			elementHolder.ife_pass_seat.resetElement();
			elementHolder.battery_switch.resetElement();
		}

	}
}