package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Panel47_GPWS extends PanelBase {
		
		public function Panel47_GPWS() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.gpws_inop_light.setText("INOP");
			elementHolder.gpws_inop_light.setColors(0x333333, 0xFF6600);
		}
		
		override protected function resetAssets():void {
			elementHolder.gpws_inop_light.showState(0);
			elementHolder.flap_inhibit.resetElement();
			elementHolder.gear_inhibit.resetElement();
			elementHolder.terr_inhibit.resetElement();
		}

	}
}