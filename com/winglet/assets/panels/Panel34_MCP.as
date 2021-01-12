package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Panel34_MCP extends PanelBase {
		
		public function Panel34_MCP() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			
			elementHolder.course1_lcd.range = 1;
			elementHolder.course1_lcd.maxNumber = 359;
			
			elementHolder.course2_lcd.range = 1;
			elementHolder.course2_lcd.maxNumber = 359;
			
			elementHolder.ias_mach_lcd.range = 1;
			elementHolder.ias_mach_lcd.maxNumber = 359;
			
			elementHolder.heading_lcd.range = 1;
			elementHolder.heading_lcd.maxNumber = 359;
			
			elementHolder.altitude_lcd.range = 1;
			elementHolder.altitude_lcd.maxNumber = 40000;
			
			elementHolder.vert_speed_lcd.range = 1;
			elementHolder.vert_speed_lcd.maxNumber = 40000;
			
			elementHolder.course1.appyLCD(elementHolder.course1_lcd);
			elementHolder.course2.appyLCD(elementHolder.course2_lcd);
			elementHolder.ias_mach.appyLCD(elementHolder.ias_mach_lcd);
			elementHolder.heading.appyLCD(elementHolder.heading_lcd);
			elementHolder.altitude.appyLCD(elementHolder.altitude_lcd);
			elementHolder.vert_speed.appyLCD(elementHolder.vert_speed_lcd);
			
		}
		
		override protected function resetAssets():void {
			/*
			elementHolder.data1.defaultPosition = 1;
			*/
		}
		
	}
}