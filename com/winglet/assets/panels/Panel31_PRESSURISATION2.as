package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel31_PRESSURISATION2 extends PanelBase {
		
		public function Panel31_PRESSURISATION2() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.dual_bleed_light.setText("DUAL BLEED");
			elementHolder.dual_bleed_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.l_pack_light.setText("PACK");
			elementHolder.l_pack_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.r_pack_light.setText("PACK");
			elementHolder.r_pack_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.l_wingbody_overheat_light.setText("WING BODY OVERHEAT");
			elementHolder.l_wingbody_overheat_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.r_wingbody_overheat_light.setText("WING BODY OVERHEAT");
			elementHolder.r_wingbody_overheat_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.l_bleed_trip_off_light.setText("BLEED TRIP OFF");
			elementHolder.l_bleed_trip_off_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.r_bleed_trip_off_light.setText("BLEED TRIP OFF");
			elementHolder.r_bleed_trip_off_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.ram_l_door_full_open.setText("RAM DOOR FULL OPEN");
			elementHolder.ram_r_door_full_open.setText("RAM DOOR FULL OPEN");
			
			elementHolder.l_recirc_fan_switch.defaultPosition = 2;
			elementHolder.r_recirc_fan_switch.defaultPosition = 2;
			
			elementHolder.l_pack_switch.defaultPosition = 2;
			elementHolder.r_pack_switch.defaultPosition = 2;
			elementHolder.isolation_valve_switch.defaultPosition = 2;
			elementHolder.apu_bleed_selector.defaultPosition = 2;
			
		}
		
		override protected function resetAssets():void {
			elementHolder.dual_bleed_light.showState(0);
			elementHolder.ram_l_door_full_open.showState(0);
			elementHolder.ram_r_door_full_open.showState(0);
			elementHolder.l_pack_light.showState(0);
			elementHolder.l_wingbody_overheat_light.showState(0);
			elementHolder.l_bleed_trip_off_light.showState(0);
			elementHolder.r_pack_light.showState(0);
			elementHolder.r_wingbody_overheat_light.showState(0);
			elementHolder.r_bleed_trip_off_light.showState(0);
			
			
			elementHolder.l_recirc_fan_switch.resetElement();
			elementHolder.r_recirc_fan_switch.resetElement();
			elementHolder.l_pack_switch.resetElement();
			elementHolder.r_pack_switch.resetElement();
			elementHolder.isolation_valve_switch.resetElement();
			elementHolder.bleed1_selector.resetElement();
			elementHolder.apu_bleed_selector.resetElement();
			elementHolder.bleed2_selector.resetElement();
			
			elementHolder.right_duct_pressure.resetElement();
			elementHolder.left_duct_pressure.resetElement();
			
			
		}
		
	}
}