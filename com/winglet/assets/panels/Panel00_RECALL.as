package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	import com.winglet.assets.elements.Element30;
	
	public class Panel00_RECALL extends PanelBase {
		
		public function Panel00_RECALL() {
			// constructor code
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
		}
		
		override public function setRecallLight(s:String):void {
			if(s=="master_caut") { 
				//To light ON master_caut immediately!
				elementHolder.master_caut.ignoreTurnOff();
			} else {
				//To light ON recall lights immediately!
				var tempLight:Element30 = getRecallLight(s);
				tempLight.ignoreTurnOff();
			}
		}
		
		override public function getRecallLight(s:String):Element30 {
			var ret:Element30;
			switch(s) {
				case "flt_cont_light":
					ret = elementHolder.recall.capt_recall.txt1;
					break;
				case "irs_light":
					ret = elementHolder.recall.capt_recall.txt2;
					break;
				case "fuel_light":
					ret = elementHolder.recall.capt_recall.txt3;
					break;
				case "elec_light":
					ret = elementHolder.recall.capt_recall.txt4;
					break;
				case "apu_light":
					ret = elementHolder.recall.capt_recall.txt5;
					break;
				case "ovht_det_light":
					ret = elementHolder.recall.capt_recall.txt6;
					break;
				case "anti_ice_light":
					ret = elementHolder.recall.fo_recall.txt1;
					break;
				case "hyd_light":
					ret = elementHolder.recall.fo_recall.txt2;
					break;
				case "doors_light":
					ret = elementHolder.recall.fo_recall.txt3;
					break;
				case "eng_light":
					ret = elementHolder.recall.fo_recall.txt4;
					break;
				case "overhead_light":
					ret = elementHolder.recall.fo_recall.txt5;
					break;
				case "air_cond_light":
					ret = elementHolder.recall.fo_recall.txt6;
					break;
				
			}
			return ret;
		}

		override protected function initAssets():void {
			
			elementHolder.fire_warn.pressTimeOut(10); //(mainTL.keyPressingTime);
			elementHolder.fire_warn.recallButtons(elementHolder.recall);
			elementHolder.master_caut.pressTimeOut(mainTL.keyPressingTime);
			elementHolder.master_caut.recallButtons(elementHolder.recall);
			elementHolder.recall.masterCautionButton(elementHolder.master_caut);
			
			elementHolder.recall.pressTimeOut(mainTL.keyPressingTime);
			
			elementHolder.recall.capt_recall.txt1.setText("FLT CONT");
			elementHolder.recall.capt_recall.txt1.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.recall.capt_recall.txt2.setText("IRS");
			elementHolder.recall.capt_recall.txt2.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.recall.capt_recall.txt3.setText("FUEL");
			elementHolder.recall.capt_recall.txt3.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.recall.capt_recall.txt4.setText("ELEC");
			elementHolder.recall.capt_recall.txt4.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.recall.capt_recall.txt5.setText("APU");
			elementHolder.recall.capt_recall.txt5.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.recall.capt_recall.txt6.setText("OVHT/DET");
			elementHolder.recall.capt_recall.txt6.setColors(Colors.GREY, Colors.AMBER);
			
			
			elementHolder.recall.fo_recall.txt1.setText("ANTI-ICE");
			elementHolder.recall.fo_recall.txt1.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.recall.fo_recall.txt2.setText("HYD");
			elementHolder.recall.fo_recall.txt2.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.recall.fo_recall.txt3.setText("DOORS");
			elementHolder.recall.fo_recall.txt3.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.recall.fo_recall.txt4.setText("ENG");
			elementHolder.recall.fo_recall.txt4.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.recall.fo_recall.txt5.setText("OVERHEAD");
			elementHolder.recall.fo_recall.txt5.setColors(Colors.GREY, Colors.AMBER);
			
			elementHolder.recall.fo_recall.txt6.setText("AIR COND");
			elementHolder.recall.fo_recall.txt6.setColors(Colors.GREY, Colors.AMBER);
		}
		
		override protected function resetAssets():void {
			trace("Panel00_RECALL.resetAssets()")
			elementHolder.fire_warn.resetElement();
			elementHolder.master_caut.resetElement();
			elementHolder.recall.resetElement();
		}
		
	}
}