package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel25_HYDRAULICS_DOORS extends PanelBase {
		
		public function Panel25_HYDRAULICS_DOORS() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.hyd_pump_elec1_overheat_light.setText("OVERHEAT");
			elementHolder.hyd_pump_elec1_overheat_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.hyd_pump_elec2_overheat_light.setText("OVERHEAT");
			elementHolder.hyd_pump_elec2_overheat_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.hyd_pump_elec2_overheat_light.setText("OVERHEAT");
			elementHolder.hyd_pump_elec2_overheat_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.hyd_pump_eng1_low_pressure_light.setText("LOW PRESSURE");
			elementHolder.hyd_pump_eng1_low_pressure_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.hyd_pump_elec1_low_pressure_light.setText("LOW PRESSURE");
			elementHolder.hyd_pump_elec1_low_pressure_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.hyd_pump_elec2_low_pressure_light.setText("LOW PRESSURE");
			elementHolder.hyd_pump_elec2_low_pressure_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.hyd_pump_eng2_low_pressure_light.setText("LOW PRESSURE");
			elementHolder.hyd_pump_eng2_low_pressure_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.hyd_pump_elec2_overheat_light.setText("OVERHEAT");
			elementHolder.hyd_pump_elec2_overheat_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.equip_light.setText("EQUIP");
			elementHolder.equip_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.fwd_entry_light.setText("FWD ENTRY");
			elementHolder.fwd_entry_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.left_fwd_overwing_light.setText("LEFT FWD OVERWING");
			elementHolder.left_fwd_overwing_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.left_aft_overwing_light.setText("LEFT AFT OVERWING");
			elementHolder.left_aft_overwing_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.aft_entry_light.setText("AFT ENTRY");
			elementHolder.aft_entry_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.fwd_service_light.setText("FWD SERVICE");
			elementHolder.fwd_service_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.right_fwd_overwing_light.setText("RIGHT FWD OVERWING");
			elementHolder.right_fwd_overwing_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.right_aft_overwing_light.setText("RIGHT AFT OVERWING");
			elementHolder.right_aft_overwing_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.aft_service_light.setText("AFT SERVICE");
			elementHolder.aft_service_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.fwd_cargo_light.setText("FWD    CARGO");
			elementHolder.fwd_cargo_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.aft_cargo_light.setText("AFT    CARGO");
			elementHolder.aft_cargo_light.setColors(Colors.GREY, Colors.AMBER);
		}
		
		override protected function resetAssets():void {
			elementHolder.hyd_pump_elec1_overheat_light.showState(0);
			elementHolder.hyd_pump_elec2_overheat_light.showState(0);
			elementHolder.hyd_pump_eng1_low_pressure_light.showState(0);
			elementHolder.hyd_pump_elec1_low_pressure_light.showState(0);
			elementHolder.hyd_pump_elec2_low_pressure_light.showState(0);
			elementHolder.hyd_pump_eng2_low_pressure_light.showState(0);
			elementHolder.fwd_entry_light.showState(0);
			elementHolder.fwd_service_light.showState(0);
			elementHolder.left_fwd_overwing_light.showState(0);
			elementHolder.right_fwd_overwing_light.showState(0);
			elementHolder.fwd_cargo_light.showState(0);
			elementHolder.equip_light.showState(0);
			elementHolder.left_aft_overwing_light.showState(0);
			elementHolder.right_aft_overwing_light.showState(0);
			elementHolder.aft_cargo_light.showState(0);
			elementHolder.aft_entry_light.showState(0);
			elementHolder.aft_service_light.showState(0);
			
			elementHolder.hyd_pump_eng1_switch.resetElement();
			elementHolder.hyd_pump_elec2_switch.resetElement();
			elementHolder.hyd_pump_elec1_switch.resetElement();
			elementHolder.hyd_pump_eng2_switch.resetElement();
		}
		
	}
}