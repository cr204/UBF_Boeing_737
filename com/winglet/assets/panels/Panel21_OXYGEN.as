package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel21_OXYGEN extends PanelBase {
		
		public function Panel21_OXYGEN() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.pass_oxy_light.setText("PASS OXY ON");
			elementHolder.pass_oxy_light.setColors(Colors.GREY, Colors.AMBER);
			
			//elementHolder.pass_oxy_switch.guardConfirmation(elementHolder.confirmation1);
		}
		
		override protected function resetAssets():void {
			elementHolder.pass_oxy_light.showState(0);
			elementHolder.pass_oxy_switch.resetElement();
		}
		
	}	
}