package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel20_ENGINES extends PanelBase {
		
		public function Panel20_ENGINES() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.engine1_reverser_light.setText("REVERSER");
			elementHolder.engine1_reverser_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.engine2_reverser_light.setText("REVERSER");
			elementHolder.engine2_reverser_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.engine_control1_light.setText("ENGINE CONTROL");
			elementHolder.engine_control1_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.engine_control2_light.setText("ENGINE CONTROL");
			elementHolder.engine_control2_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.guard1.guardElement(elementHolder.eec1_button);
//			elementHolder.eec1_button.active = true;
			elementHolder.guard2.guardElement(elementHolder.eec2_button);
		}
		
		override protected function resetAssets():void {
			elementHolder.engine1_reverser_light.showState(0);
			elementHolder.engine2_reverser_light.showState(0);
			elementHolder.engine_control1_light.showState(0);
			elementHolder.engine_control2_light.showState(0);
			elementHolder.eec1_button.resetElement();
			elementHolder.eec2_button.resetElement();
		}
		
	}
}