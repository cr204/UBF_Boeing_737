package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel28_FDR_MACH_TEST extends PanelBase {
		
		public function Panel28_FDR_MACH_TEST() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			
			elementHolder.flight_recorder_off_light.setText("OFF");
			elementHolder.flight_recorder_off_light.setColors(Colors.GREY, Colors.AMBER);
		}
		
		override protected function resetAssets():void {
			elementHolder.flight_recorder_off_light.showState(0);
			elementHolder.flight_recorder_switch.resetElement();
		}
		
	}
}