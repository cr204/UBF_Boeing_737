package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel35_FO_RECALL extends PanelBase {
		
		public function Panel35_FO_RECALL() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			
			elementHolder.anti_ice_light.setText("ANTI-ICE");
			elementHolder.anti_ice_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.hyd_light.setText("HYD");
			elementHolder.hyd_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.doors_light.setText("DOORS");
			elementHolder.doors_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.eng_light.setText("ENG");
			elementHolder.eng_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.overhead_light.setText("OVERHEAD");
			elementHolder.overhead_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.air_cond_light.setText("AIR COND");
			elementHolder.air_cond_light.setColors(Colors.GREY, Colors.AMBER);
		}
		
		override protected function resetAssets():void {
			/*
			elementHolder.data1.defaultPosition = 1;
			*/
		}
		
	}
}