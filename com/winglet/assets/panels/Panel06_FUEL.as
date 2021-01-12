package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel06_FUEL extends PanelBase {
		
		public function Panel06_FUEL() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.ctr_tk_l_pump_low_pressure_light.setText("LOW PRESSURE");
			elementHolder.ctr_tk_l_pump_low_pressure_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.ctr_tk_r_pump_low_pressure_light.setText("LOW PRESSURE");
			elementHolder.ctr_tk_r_pump_low_pressure_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.filter_bypass_l.setText("FILTER BYPASS");
			elementHolder.filter_bypass_l.setColors(0x333333, 0xCC9900);
			
			elementHolder.filter_bypass_r.setText("FILTER BYPASS");
			elementHolder.filter_bypass_r.setColors(0x333333, 0xCC9900);
			
			elementHolder.fwd_pump1_low_pressure_light.setText("LOW PRESSURE");
			elementHolder.fwd_pump1_low_pressure_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.aft_pump1_low_pressure_light.setText("LOW PRESSURE");
			elementHolder.aft_pump1_low_pressure_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.fwd_pump2_low_pressure_light.setText("LOW PRESSURE");
			elementHolder.fwd_pump2_low_pressure_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.aft_pump2_low_pressure_light.setText("LOW PRESSURE");
			elementHolder.aft_pump2_low_pressure_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.cross_feed_valve_open_light.setText("VALVE OPEN");
			elementHolder.eng_valve_closed_l.setText("ENG VALVE CLOSED");
			elementHolder.eng_valve_closed_r.setText("ENG VALVE CLOSED");
			
			elementHolder.spar_valve_closed_l.setText("SPAR VALVE CLOSED");
			elementHolder.spar_valve_closed_r.setText("SPAR VALVE CLOSED");
			
			
		}
		
		override protected function resetAssets():void {
			elementHolder.eng_valve_closed_l.showState(0);
			elementHolder.spar_valve_closed_l.showState(0);
			elementHolder.eng_valve_closed_r.showState(0);
			elementHolder.spar_valve_closed_r.showState(0);
			elementHolder.filter_bypass_l.showState(0);
			elementHolder.cross_feed_valve_open_light.showState(0);
			elementHolder.filter_bypass_r.showState(0);
			elementHolder.ctr_tk_l_pump_low_pressure_light.showState(0);
			elementHolder.ctr_tk_r_pump_low_pressure_light.showState(0);
			elementHolder.fwd_pump1_low_pressure_light.showState(0);
			elementHolder.aft_pump1_low_pressure_light.showState(0);
			elementHolder.fwd_pump2_low_pressure_light.showState(0);
			elementHolder.aft_pump2_low_pressure_light.showState(0);
			
			elementHolder.cross_feed_selector.gotoAndStop(1);
			elementHolder.ctr_tk_l_pump_switch.resetElement();
			elementHolder.ctr_tk_r_pump_switch.resetElement();
			elementHolder.fwd_pump1_switch.resetElement();
			elementHolder.aft_pump1_switch.resetElement();
			elementHolder.fwd_pump2_switch.resetElement();
			elementHolder.aft_pump2_switch.resetElement();
		}

	}
}