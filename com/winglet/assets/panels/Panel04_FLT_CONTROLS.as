package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel04_FLT_CONTROLS extends PanelBase {
		
		public function Panel04_FLT_CONTROLS() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}
		
		override protected function initAssets():void {
			elementHolder.standby_hyd_low_quantity_light.setText("LOW QUANTITY");
			elementHolder.standby_hyd_low_quantity_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.standby_hyd_low_pressure_light.setText("LOW PRESSURE");
			elementHolder.standby_hyd_low_pressure_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.stby_rud_on_light.setText("STBY           RUD ON");
			elementHolder.stby_rud_on_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.yaw_damper_light.setText("YAW DAMPER");
			elementHolder.yaw_damper_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.feel_diff_press_light.setText("FEEL          DIFF PRESS");
			elementHolder.feel_diff_press_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.speed_trim_fail_light.setText("SPEED TRIM FAIL");
			elementHolder.speed_trim_fail_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.mach_trim_fail_light.setText("MACH TRIM FAIL");
			elementHolder.mach_trim_fail_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.auto_slat_fail_light.setText("AUTO SLAT FAIL");
			elementHolder.auto_slat_fail_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.flight_control_light_a.setText("LOW PRESSURE");
			elementHolder.flight_control_light_a.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.flight_control_light_b.setText("LOW PRESSURE");
			elementHolder.flight_control_light_b.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.flight_control_switch_a.guardConfirmation(elementHolder.confirmation1);
			elementHolder.flight_control_switch_b.guardConfirmation(elementHolder.confirmation2);
			elementHolder.spoiler_a_switch.guardConfirmation(elementHolder.confirmation3);
			elementHolder.spoiler_b_switch.guardConfirmation(elementHolder.confirmation4);
			elementHolder.alternate_flaps_master_switch.guardConfirmation(elementHolder.confirmation5);
					
		}
		
		override protected function resetAssets():void {
			elementHolder.standby_hyd_low_quantity_light.showState(0);
			elementHolder.standby_hyd_low_pressure_light.showState(0);
			elementHolder.stby_rud_on_light.showState(0);
			elementHolder.flight_control_light_a.showState(0);
			elementHolder.flight_control_light_b.showState(0);
			elementHolder.yaw_damper_light.showState(0);
			elementHolder.feel_diff_press_light.showState(0);
			elementHolder.speed_trim_fail_light.showState(0);
			elementHolder.mach_trim_fail_light.showState(0);
			elementHolder.auto_slat_fail_light.showState(0);
			
			elementHolder.flight_control_switch_a.resetElement();
			elementHolder.flight_control_switch_b.resetElement();
			elementHolder.alternate_flaps_master_switch.resetElement();
			elementHolder.spoiler_a_switch.resetElement();
			elementHolder.spoiler_b_switch.resetElement();
			
			elementHolder.alternate_flaps_toggle_switch.resetElement();
			elementHolder.yaw_damper_switch.resetElement();
		}
		
	}
}
