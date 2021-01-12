package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel00_MASTER_CAUTION extends PanelBase {
		
		
		public function Panel00_MASTER_CAUTIOND() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}
		
		override protected function initAssets():void {
			elementHolder.fire_warn.pressTimeOut(mainTL.keyPressingTime);
			elementHolder.master_caut.pressTimeOut(mainTL.keyPressingTime);
		}
		
		override protected function resetAssets():void {
			// reset assets
		}
		
	}
}