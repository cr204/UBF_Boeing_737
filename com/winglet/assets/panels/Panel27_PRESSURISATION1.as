package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Panel27_PRESSURISATION1 extends PanelBase {
		
		public function Panel27_PRESSURISATION1() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			/*
			elementHolder.data1.rotationDegrees(290, 320, 340, 15, 40, 65);
			elementHolder.data1.defaultPosition = 1;
			*/
		}
		
		override protected function resetAssets():void {
			elementHolder.cabin_alt.resetElement();
			elementHolder.diff_press_gauge.resetElement();
			elementHolder.cabin_vs_gauge.resetElement();
		}
		
	}
}