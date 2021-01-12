package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel10_ELECTRICAL2 extends PanelBase {
		
		public function Panel10_ELECTRICAL2() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.drive1_disconnect_light.setText("DRIVE");
			elementHolder.drive1_disconnect_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.drive2_disconnect_light.setText("DRIVE");
			elementHolder.drive2_disconnect_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.standby_power_off_light.setText("STANDBY PWR OFF");
			elementHolder.standby_power_off_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.drive1_disconnect_switch.guardConfirmation(elementHolder.confirmation1);
			elementHolder.drive2_disconnect_switch.guardConfirmation(elementHolder.confirmation3);
			
			elementHolder.drive1_disconnect_switch.sprungLoaded = true;
			elementHolder.drive1_disconnect_switch.sprungLoadedSide(1);
			elementHolder.drive1_disconnect_switch.isPanel10 = true;
			elementHolder.drive2_disconnect_switch.sprungLoaded = true;
			elementHolder.drive2_disconnect_switch.sprungLoadedSide(1);
			elementHolder.drive2_disconnect_switch.isPanel10 = true;
		}
		
		override protected function resetAssets():void {
			elementHolder.drive1_disconnect_light.showState(0);
			elementHolder.standby_power_off_light.showState(0);
			elementHolder.drive2_disconnect_light.showState(0);
			
			elementHolder.drive1_disconnect_switch.resetElement();
			elementHolder.standby_power_off_switch.resetElement();
			elementHolder.drive2_disconnect_switch.resetElement();
		}
		
	}
}
