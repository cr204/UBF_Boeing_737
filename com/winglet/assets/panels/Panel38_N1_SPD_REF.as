package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel38_N1_SPD_REF extends PanelBase {
		
		public function Panel38_N1_SPD_REF() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			
			elementHolder.auto_brake.rotationDegrees(225, 270, 315, 0, 45, 92);
			elementHolder.auto_brake.defaultPosition = 1;
			
			elementHolder.auto_brake_disarm_light.setText("AUTO BRAKE DISARM");
			elementHolder.auto_brake_disarm_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.anti_skid_inop_light.setText("ANTI SKID INOP");
			elementHolder.anti_skid_inop_light.setColors(Colors.GREY, Colors.AMBER);
		}
		
		override protected function resetAssets():void {
			elementHolder.auto_brake_disarm_light.showState(0);
			elementHolder.anti_skid_inop_light.showState(0);
			
			elementHolder.auto_brake.resetElement();
		}

	}	
}