package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel23_ANTI_ICE1 extends PanelBase {
		
		public function Panel23_ANTI_ICE1() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			
			elementHolder.overheat_l_side_light.setText("OVERHEAT");
			elementHolder.overheat_l_side_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.overheat_l_fwd_light.setText("OVERHEAT");
			elementHolder.overheat_l_fwd_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.overheat_r_fwd_light.setText("OVERHEAT");
			elementHolder.overheat_r_fwd_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.overheat_r_side_light.setText("OVERHEAT");
			elementHolder.overheat_r_side_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.on_l_side_light.setText("ON");
			elementHolder.on_l_side_light.setColors(Colors.GREY, Colors.GREEN);
			
			elementHolder.on_l_fwd_light.setText("ON");
			elementHolder.on_l_fwd_light.setColors(Colors.GREY, Colors.GREEN);
			
			elementHolder.on_r_side_light.setText("ON");
			elementHolder.on_r_side_light.setColors(Colors.GREY, Colors.GREEN);
			
			elementHolder.on_r_fwd_light.setText("ON");
			elementHolder.on_r_fwd_light.setColors(Colors.GREY, Colors.GREEN);
			
			elementHolder.capt_pitot_light.setText("CAPT    PITOT");
			elementHolder.capt_pitot_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.fo_pitot_light.setText("F/O       PITOT");
			elementHolder.fo_pitot_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.l_elev_pitot_light.setText("L ELEV PITOT");
			elementHolder.l_elev_pitot_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.r_elev_pitot_light.setText("R ELEV PITOT");
			elementHolder.r_elev_pitot_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.l_alpha_vane_light.setText("L ALPHA PITOT");
			elementHolder.l_alpha_vane_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.r_alpha_vane_light.setText("R ALPHA PITOT");
			elementHolder.r_alpha_vane_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.temp_probe_light.setText("TEMP PROBE");
			elementHolder.temp_probe_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.aux_pitot_light.setText("AUX     PITOT");
			elementHolder.aux_pitot_light.setColors(Colors.GREY, Colors.AMBER);
		}
		
		override protected function resetAssets():void {
			elementHolder.overheat_l_side_light.showState(0);
			elementHolder.on_l_side_light.showState(0);
			elementHolder.overheat_l_fwd_light.showState(0);
			elementHolder.on_l_fwd_light.showState(0);
			elementHolder.overheat_r_fwd_light.showState(0);
			elementHolder.on_r_side_light.showState(0);
			elementHolder.overheat_r_side_light.showState(0);
			elementHolder.on_r_fwd_light.showState(0);
			elementHolder.capt_pitot_light.showState(0);
			elementHolder.l_elev_pitot_light.showState(0);
			elementHolder.l_alpha_vane_light.showState(0);
			elementHolder.temp_probe_light.showState(0);
			elementHolder.fo_pitot_light.showState(0);
			elementHolder.r_elev_pitot_light.showState(0);
			elementHolder.r_alpha_vane_light.showState(0);
			elementHolder.aux_pitot_light.showState(0);
			
			elementHolder.overheat_l_side_switch.resetElement();
			elementHolder.overheat_l_fwd_switch.resetElement();
			elementHolder.window_ovht_test_switch .resetElement();
			elementHolder.overheat_r_fwd_switch.resetElement();
			elementHolder.overheat_r_side_switch.resetElement();
			elementHolder.probe_heat_a_switch.resetElement();
			elementHolder.probe_heat_b_switch.resetElement();
		}
		
	}
}