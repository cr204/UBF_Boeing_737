package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel40_LANDING_GEAR2 extends PanelBase {
		
		public function Panel40_LANDING_GEAR2() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.nose_red_gear_light.setText("NOSE GEAR");
			elementHolder.nose_red_gear_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.right_lower_green_gear_light.setText("NOSE GEAR");
			elementHolder.right_lower_green_gear_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.right_red_gear_light.setText("LEFT GEAR");
			elementHolder.right_red_gear_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.left_red_gear_light.setText("LEFT GEAR");
			elementHolder.left_red_gear_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.nose_red_gear_light.setText("RIGHT GEAR");
			elementHolder.nose_red_gear_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.left_lower_green_gear_light.setText("RIGHT GEAR");
			elementHolder.left_lower_green_gear_light.setColors(Colors.GREY, Colors.AMBER);
		}
		
		override protected function resetAssets():void {
			elementHolder.nose_red_gear_light.showState(0);
			elementHolder.right_lower_green_gear_light.showState(0);
			elementHolder.right_red_gear_light.showState(0);
			elementHolder.left_red_gear_light.showState(0);
			elementHolder.nose_red_gear_light.showState(0);
			elementHolder.left_lower_green_gear_light.showState(0);
		}

	}	
}