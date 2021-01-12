package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel01_ELT extends PanelBase {
		
		public function Panel01_ELT() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.elt_light.setText("ELT");
			elementHolder.elt_light.setColors(Colors.GREY, Colors.AMBER);
			
		}
		
		override protected function resetAssets():void {
			elementHolder.elt_light.showState(0);
			elementHolder.elt_switch.resetElement();
		}
		
	}
}
