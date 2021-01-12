package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel16_EQUIP_COOLING extends PanelBase {
		
		public function Panel16_EQUIP_COOLING() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.smoke_light.setText("SMOKE");
			elementHolder.smoke_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.equip_cooling_supply_off_light.setText("OFF");
			elementHolder.equip_cooling_supply_off_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.equip_cooling_exhaust_off_light.setText("OFF");
			elementHolder.equip_cooling_exhaust_off_light.setColors(Colors.GREY, Colors.AMBER);
		}
		
		override protected function resetAssets():void {
			elementHolder.smoke_light.showState(0);
			elementHolder.equip_cooling_supply_off_light.showState(0);
			elementHolder.equip_cooling_exhaust_off_light.showState(0);
			elementHolder.equip_cooling_supply_switch.resetElement();
			elementHolder.equip_cooling_exhaust_switch.resetElement();
		}
		
	}
}