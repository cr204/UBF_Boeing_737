package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel53_FIRE extends PanelBase {
		
		public function Panel53_FIRE() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.eng1_overheat_light.setText("ENG 1 OVERHEAT");
			elementHolder.eng1_overheat_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.wheel_well_light.setText("WHEEL WELL");
			elementHolder.wheel_well_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.fire_det_fault_light.setText("FAULT");
			elementHolder.fire_det_fault_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.apu_det_inop_light.setText("APU DET INOP");
			elementHolder.apu_det_inop_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.apu_bottle_discharge_light.setText("APU BOTTLE DISCHARGE");
			elementHolder.apu_bottle_discharge_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.eng2_overheat_light.setText("ENG 2 OVERHEAT");
			elementHolder.eng2_overheat_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.l_bottle_discharge_light.setText("L BOTTLE DISCHARGE");
			elementHolder.l_bottle_discharge_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.r_bottle_discharge_light.setText("R BOTTLE DISCHARGE");
			elementHolder.r_bottle_discharge_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.ovht_det.defaultPosition = 2;
		}
		
		override protected function resetAssets():void {
			elementHolder.eng1_overheat_light.showState(0);
			elementHolder.wheel_well_light.showState(0);
			elementHolder.fire_det_fault_light.showState(0);
			elementHolder.apu_det_inop_light.showState(0);
			elementHolder.apu_bottle_discharge_light.showState(0);
			elementHolder.eng2_overheat_light.showState(0);
			elementHolder.l_bottle_discharge_light.showState(0);
			elementHolder.r_bottle_discharge_light.showState(0);
			
			elementHolder.ovht_det.resetElement();
			elementHolder.switch1.resetElement();
			elementHolder.switch_apu.resetElement();
			elementHolder.switch2.resetElement();
			
		}

	}
}