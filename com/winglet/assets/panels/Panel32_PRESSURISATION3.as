package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel32_PRESSURISATION3 extends PanelBase {
		
		public function Panel32_PRESSURISATION3() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			
			elementHolder.dial.rotationDegrees(330, 0, 30);
			elementHolder.dial.defaultPosition = 0;
			
			elementHolder.flt_alt_lcd.range = 100;
			elementHolder.flt_alt_lcd.maxNumber = 40000;
			elementHolder.land_alt_lcd.range = 50;
			elementHolder.land_alt_lcd.maxNumber = 11000;
			
			elementHolder.flt_alt.appyLCD(elementHolder.flt_alt_lcd);
			elementHolder.land_alt.appyLCD(elementHolder.land_alt_lcd);
			
			elementHolder.manual_switch.sprungLoaded = true;
			
			elementHolder.auto_fail_light.setText("AUTO FAIL");
			elementHolder.auto_fail_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.off_sched_descent_light.setText("OFF SCHED LIGHT");
			elementHolder.off_sched_descent_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.altn_light.setText("ALTN");
			elementHolder.altn_light.setColors(Colors.GREY, Colors.GREEN);
			
			elementHolder.manual_light.setText("MANUAL");
			elementHolder.manual_light.setColors(Colors.GREY, Colors.GREEN);
		}
		
		override protected function resetAssets():void {
			elementHolder.valve.resetElement();
			elementHolder.manual_switch.resetElement();
			elementHolder.dial.resetElement();
			elementHolder.flt_alt.resetElement();
			elementHolder.land_alt.resetElement();
			
			elementHolder.auto_fail_light.showState(0);
			elementHolder.off_sched_descent_light.showState(0);
			elementHolder.altn_light.showState(0);
			elementHolder.manual_light.showState(0);
		}
		
	}
}