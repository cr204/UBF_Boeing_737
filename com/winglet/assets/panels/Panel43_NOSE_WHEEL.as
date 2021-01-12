package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Panel43_NOSE_WHEEL extends PanelBase {
		
		public function Panel43_NOSE_WHEEL() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			//elementHolder.nose_wheel_steering.guardConfirmation(elementHolder.confirmation1);
			
		}
		
		override protected function resetAssets():void {
			elementHolder.nose_wheel_steering.resetElement();
		}

	}	
}