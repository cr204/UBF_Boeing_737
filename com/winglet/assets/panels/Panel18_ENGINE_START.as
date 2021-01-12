package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Panel18_ENGINE_START extends PanelBase {
		
		public function Panel18_ENGINE_START() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.start_switch_1.rotationDegrees(317, 0, 41, 62);
			elementHolder.start_switch_1.defaultPosition = 1;
			
			
			elementHolder.start_switch_2.rotationDegrees(317, 0, 41, 62);
			elementHolder.start_switch_2.defaultPosition = 1;
			
		}
		
		override protected function resetAssets():void {
			elementHolder.start_switch_1.resetElement();
			elementHolder.start_switch_2.resetElement();
			elementHolder.ignition_switch.resetElement();
		}
		
	}
}