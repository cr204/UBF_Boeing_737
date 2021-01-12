package com.winglet.assets.states {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.winglet.*;
	
	public class StartState {
		private var parentObj:MovieClip;
		private var currStateObj:StateObject;
		
		public function StartState(param1) {
			// Start State
			parentObj = param1;
		}
		
		public function stateObj(sObj:StateObject):void {
			currStateObj = sObj;
			parentObj.btnStart.addEventListener(MouseEvent.MOUSE_DOWN, onStartPressed);
		}
		
		private function onStartPressed(e:MouseEvent):void {
			parentObj.btnStart.removeEventListener(MouseEvent.MOUSE_DOWN, onStartPressed);
			parentObj.btnStart.gotoAndStop(15);
			parentObj._appStarted = true;
			parentObj.helpBox.visible = false;
			
			completeProcess();
		}
		
		private function completeProcess():void {
			parentObj.helpBox.setBoxData(currStateObj.helpBoxObject);
			
			if(currStateObj.hasInfoBox1) {
				parentObj.infoBox1.visible = true;
				parentObj.infoBox1.setInfoData(currStateObj.infoBox1);
			} else parentObj.infoBox1.visible = false;
			if(currStateObj.hasInfoBox2) {
				parentObj.infoBox2.visible = true;
				parentObj.infoBox2.setInfoData(currStateObj.infoBox2);
			} else parentObj.infoBox2.visible = false;
			
			if(parentObj.infoBox1.visible || parentObj.infoBox2.visible) {
//				if(parentObj.helpBox.visible) {
//					parentObj.infoBox1.x = parentObj.infoBox2.x = 360;
//				} else {
					parentObj.infoBox1.x = parentObj.infoBox2.x = 550;
//				}
			} else {
				parentObj.infoBox1.x = parentObj.infoBox2.x = 360;
			}
			
			if(currStateObj.hasElements) {
				for (var i:Object in currStateObj.elementObjectArray) {
					if(currStateObj.elementObjectArray[i].panel=="recall") {
						if(currStateObj.elementObjectArray[i].name=="fire_warn" || 
						   currStateObj.elementObjectArray[i].name=="master_caut") {
								parentObj.flightdeckPanelSet.disableButtons();
								parentObj.currentPanelID = "panel_0";
								parentObj.panelHolder.addChild(parentObj.panel_RECALL);
								parentObj.guideSet.gotoAndStop("panel_0");
						   }
					}
					if(currStateObj.elementObjectArray[i].panel=="autopilot_test") {
						if(currStateObj.elementObjectArray[i].name=="cpt_ap_prst_light" ||
						   currStateObj.elementObjectArray[i].name=="cpt_at_prst_light" ||
						   currStateObj.elementObjectArray[i].name=="cpt_fmc_prst_light") {
								parentObj.flightdeckPanelSet.disableButtons();
								parentObj.currentPanelID = "panel_37";
								parentObj.panelHolder.addChild(parentObj.panel_AUTOPILOT_TEST);
								parentObj.guideSet.gotoAndStop("panel_37");
						   }
					}
					parentObj.panelOperations.updateElementState(currStateObj.elementObjectArray[i]);
				}
			}
			
/*			if(currStateObj.hasHighlighting) {
				parentObj.hightlightFlightdeckPanel(currStateObj.highlightedPanels);
			} else {
				parentObj.hightlightFlightdeckPanel("none");
			}*/
			
			// Coplete some screen animations
			parentObj.completeCurrentScreenAnimation(currStateObj.screenObjectID);

			parentObj.completeNextState();
		}
		
	}
	
}