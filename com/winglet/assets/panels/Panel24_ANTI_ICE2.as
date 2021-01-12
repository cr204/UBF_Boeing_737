package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel24_ANTI_ICE2 extends PanelBase {
		
		public function Panel24_ANTI_ICE2() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.cowl_anti_ice1_light.setText("COWL      ANTI-ICE");
			elementHolder.cowl_anti_ice1_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.cowl_anti_ice2_light.setText("COWL      ANTI-ICE");
			elementHolder.cowl_anti_ice2_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.l_valve_open_light.setText("L VALVE OPEN");
			elementHolder.r_valve_open_light.setText("R VALVE OPEN");
			
			elementHolder.cowl_valve1_open_light.setText("COWL VALV OPEN");
			elementHolder.cowl_valve2_open_light.setText("COWL VALV OPEN");
		}
		
		override protected function resetAssets():void {
			elementHolder.cowl_anti_ice1_light.showState(0);
			elementHolder.cowl_anti_ice2_light.showState(0);
			elementHolder.l_valve_open_light.showState(0);
			elementHolder.r_valve_open_light.showState(0);
			elementHolder.cowl_valve1_open_light.showState(0);
			elementHolder.cowl_valve2_open_light.showState(0);
			
			elementHolder.wing_anti_ice_switch.resetElement();
			elementHolder.eng_anti_ice1_switch.resetElement();
			elementHolder.eng_anti_ice2_switch.resetElement();
		}
		
	}
}