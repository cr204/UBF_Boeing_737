package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel30_AIR_COND extends PanelBase {
		
		public function Panel30_AIR_COND() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.air_temp_supply_duct_selector.rotationDegrees(0, 45, 90, 135, 180, 225, 270, 315);
			elementHolder.air_temp_supply_duct_selector.defaultPosition = 0;
			
			elementHolder.cont_cab_zone_temp_selector.rotationDegrees(0, 40, 75, 100, 130, 180, 230, 260, 290, 320);
			elementHolder.cont_cab_zone_temp_selector.defaultPosition = 0;
			
			elementHolder.fwd_cab_zone_temp_selector.rotationDegrees(0, 40, 75, 100, 130, 180, 230, 260, 290, 320);
			elementHolder.fwd_cab_zone_temp_selector.defaultPosition = 0;
			
			elementHolder.aft_cab_zone_temp_selector.rotationDegrees(0, 40, 75, 100, 130, 180, 230, 260, 290, 320);
			elementHolder.aft_cab_zone_temp_selector.defaultPosition = 0;
			
			elementHolder.cont_cab_zone_temp_light.setText("ZONE    TEMP");
			elementHolder.cont_cab_zone_temp_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.fwd_cab_zone_temp_light.setText("ZONE    TEMP");
			elementHolder.fwd_cab_zone_temp_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.aft_cab_zone_temp_light.setText("ZONE    TEMP");
			elementHolder.aft_cab_zone_temp_light.setColors(Colors.GREY, Colors.AMBER);
		}
		
		override protected function resetAssets():void {
			elementHolder.cont_cab_zone_temp_light.showState(0);
			elementHolder.fwd_cab_zone_temp_light.showState(0);
			elementHolder.aft_cab_zone_temp_light.showState(0);
			
			elementHolder.air_temp_supply_duct_selector.resetElement();
			elementHolder.cont_cab_zone_temp_selector.resetElement();
			elementHolder.fwd_cab_zone_temp_selector.resetElement();
			elementHolder.aft_cab_zone_temp_selector.resetElement();
			elementHolder.trim_air_switch.resetElement();
			
			//elementHolder.air_temp_gauge.resetElement();
		}
		
	}	
}