package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel11_ELECTRICAL3 extends PanelBase {
		
		public function Panel11_ELECTRICAL3() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.transfer_bus1_off_light.setText("TRANSFER BUS OFF");
			elementHolder.transfer_bus1_off_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.transfer_bus2_off_light.setText("TRANSFER BUS OFF");
			elementHolder.transfer_bus2_off_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.source_bus1_off_light.setText("SOURCE OFF");
			elementHolder.source_bus1_off_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.source_bus2_off_light.setText("SOURCE OFF");
			elementHolder.source_bus2_off_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.ground_power_light.setText("GRD POWER AVAILABLE");
			elementHolder.gen1_off_bus_light.setText("GEN BUS OFF");
			elementHolder.gen2_off_bus_light.setText("GEN BUS OFF");
			elementHolder.apu_gen_off_bus_light.setText("APU GEN OFF BUS");
			
			elementHolder.gen1_switch.defaultPosition = 3;
			elementHolder.gen2_switch.defaultPosition = 3;
			
			//elementHolder.bus_transfer.guardConfirmation(elementHolder.confirmation5);
		}
		
		override protected function resetAssets():void {
			elementHolder.ground_power_light.showState(0);
			elementHolder.transfer_bus1_off_light.showState(0);
			elementHolder.source_bus1_off_light.showState(0);
			elementHolder.gen1_off_bus_light.showState(0);
			elementHolder.apu_gen_off_bus_light.showState(0);
			elementHolder.transfer_bus2_off_light.showState(0);
			elementHolder.source_bus2_off_light.showState(0);
			elementHolder.gen2_off_bus_light.showState(0);
			
			elementHolder.bus_transfer.resetElement();
			elementHolder.gen1_switch.resetElement();
			elementHolder.apu_bus1_switch.resetElement();
			elementHolder.apu_bus2_switch.resetElement();
			elementHolder.gen2_switch.resetElement();
		}
		
	}
}