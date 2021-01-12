package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel22_LANDING_GEAR1 extends PanelBase {
		
		public function Panel22_LANDING_GEAR1() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.left_upper_green_gear_light.setText("LEFT     GEAR");
			elementHolder.left_upper_green_gear_light.setColors(Colors.GREY, Colors.GREEN);
			
			elementHolder.right_upper_green_gear_light.setText("RIGHT   GEAR");
			elementHolder.right_upper_green_gear_light.setColors(Colors.GREY, Colors.GREEN);
			
			elementHolder.nose_upper_green_gear_light.setText("NOSE   GEAR");
			elementHolder.nose_upper_green_gear_light.setColors(Colors.GREY, Colors.GREEN);
		}
		
		override protected function resetAssets():void {
			elementHolder.left_upper_green_gear_light.showState(0);
			elementHolder.right_upper_green_gear_light.showState(0);
			elementHolder.nose_upper_green_gear_light.showState(0);
		}
		
	}
}