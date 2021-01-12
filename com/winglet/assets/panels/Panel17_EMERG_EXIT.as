package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Panel17_EMERG_EXIT extends PanelBase {
		
		public function Panel17_EMERG_EXIT() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.call_light.setText("CALL");
			
			elementHolder.emer_exit_lights_switch.guardConfirmation(elementHolder.confirmation1);
		}
		
		override protected function resetAssets():void {
			elementHolder.emer_exit_not_armed_light.gotoAndStop(1);
			elementHolder.call_light.showState(0);
			elementHolder.emer_exit_lights_switch.resetElement();
			elementHolder.no_smoking_switch.resetElement();
			elementHolder.seat_belts_switch.resetElement();
		}
		
	}	
}
