package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel39_FLAP_INDICATOR extends PanelBase {
		
		public function Panel39_FLAP_INDICATOR() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			
			elementHolder.le_flaps_transit_light.setText("LE FLAPS TRANZIT");
			elementHolder.le_flaps_transit_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.le_flaps_ext_light.setText("LE FLAPS   EXT");
			elementHolder.le_flaps_ext_light.setColors(Colors.GREY, Colors.GREEN);
			
		}
		
		override protected function resetAssets():void {
			elementHolder.le_flaps_transit_light.showState(0);
			elementHolder.le_flaps_ext_light.showState(0);
		}
		
	}	
}