 package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	
	public class Panel07_IRS_SYSTEM_DISPLAY extends PanelBase {
		
		public function Panel07_IRS_SYSTEM_DISPLAY() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}

		override protected function initAssets():void {
			elementHolder.irs_l.rotationDegrees(290, 330, 38, 70);
			elementHolder.irs_l.defaultPosition = 0;
			
			elementHolder.irs_r.rotationDegrees(290, 330, 38, 70);
			elementHolder.irs_r.defaultPosition = 0;
			
			elementHolder.dspl_sel.rotationDegrees(275, 305, 337, 28, 60);
			elementHolder.dspl_sel.defaultPosition = 0;
			
			elementHolder.sys_dspl.rotationDegrees(330, 32);
			elementHolder.sys_dspl.defaultPosition = 0;
			
			elementHolder.gps_light.setText("GPS");
			elementHolder.gps_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.align_l_light.setText("ALIGN");
			elementHolder.align_l_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.on_dc_l_light.setText("ON DC");
			elementHolder.on_dc_l_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.fault_l_light.setText("FAULT");
			elementHolder.fault_l_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.dc_fail_l_light.setText("DC FAIL");
			elementHolder.dc_fail_l_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.align_r_light.setText("ALIGN");
			elementHolder.align_r_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.on_dc_r_light.setText("ON DC");
			elementHolder.on_dc_r_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.fault_r_light.setText("FAULT");
			elementHolder.fault_r_light.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.dc_fail_r_light.setText("DC FAIL");
			elementHolder.dc_fail_r_light.setColors(Colors.GREY, Colors.AMBER);
		}
		
		override protected function resetAssets():void {
			elementHolder.gps_light.showState(0);
			elementHolder.align_l_light.showState(0);
			elementHolder.on_dc_l_light.showState(0);
			elementHolder.fault_l_light.showState(0);
			elementHolder.dc_fail_l_light.showState(0);
			elementHolder.align_r_light.showState(0);
			elementHolder.on_dc_r_light.showState(0);
			elementHolder.fault_r_light.showState(0);
			elementHolder.dc_fail_r_light.showState(0);
			
			elementHolder.irs_l.resetElement();
			elementHolder.irs_r.resetElement();
		}

	}
}
