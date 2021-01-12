package com.winglet.assets.states {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.winglet.*;
	import com.winglet.events.ElementPressedEvent;
	import com.greensock.TweenLite;
	import com.winglet.assets.panels.PanelBase;
	
	public class MainState {
		private var parentObj:MovieClip;
		private var currStateObj:StateObject;
		public static const PROCESS_DELAY_TIME:Number = 50;
		private var processDelayTimer:Timer;
		private var currSSwitch:String = "";
		private var currPSSwitch:String = "";
		private var currElement:*;
		private var currPElement:*;
		private var currPS_ID:int = -1;
		private var stateObjectParallelStatesArr:Array = [];
		public var hasKeyWait:Boolean = false;
		public var keyWait:Number = 0;
		private var currParallelStatesArr:Array = [];
		private var tempPSK_ID:int = -1;
		
		public function MainState(param1) {
			// Main State
			parentObj = param1;
			processDelayTimer = new Timer(PROCESS_DELAY_TIME);
			processDelayTimer.addEventListener(TimerEvent.TIMER, delayTimerHandler);
		}
		
		public function stateObj(sObj:StateObject, wt:Number):void {
			currStateObj = sObj;
			currPS_ID = -1;
			
			trace("keyObject: " + sObj.keyObject.element);
			
			if(sObj.keyObject.wait!="unlimited") {
				keyWait = Number(sObj.keyObject.wait);
				if(keyWait>0) {
					hasKeyWait = true;
					TweenLite.to(this, 0, {delay:keyWait, overwrite:false, onComplete:completeKeyWait})
				} else hasKeyWait = false;
			} else {
				// This time user interaction to <key> element is useless! completeKeyWait will be done by <xelement property="nextState"> 
				hasKeyWait = true;
			}
			
/*			if(sObj.keyObject.panel!="recall" && parentObj.panelHolder.numChildren>0 && parentObj.currentPanelID=="panel_0") {
				parentObj.currentPanelID = "";
				parentObj.panelHolder.removeChildAt(0);
				parentObj.guideSet.gotoAndStop(1);
			}*/
			
			if(currStateObj.hasParallelState) {
				trace("currStateObj.hasParallelState: " + currStateObj.hasParallelState);
				stateObjectParallelStatesArr = currStateObj.parallelStates;
				completeNextParallelState();
			}

			var currPanel:PanelBase = getPanel(sObj.keyObject.panel);
			if(sObj.keyObject.element!="") {
				var elementHolder = currPanel.getChildByName("elementHolder");
				currElement = elementHolder.getChildByName(sObj.keyObject.element);
/*				trace("sObj.keyObject.element: " + sObj.keyObject.element);
				trace("currElement: " + currElement);*/
				TweenLite.to(this, 0, {delay:wt, overwrite:false, onComplete:innerFN1})
			} else {
				trace("KEY PANEL: " + sObj.keyObject.panel);
				parentObj.keyPanelObject(currPanel);
			}
			
			
			// RECALL panel lights immediate turn ON.  --//apr30,2013
			if(currStateObj.hasElements) {
				for (var i:Object in currStateObj.elementObjectArray) {
					if(currStateObj.elementObjectArray[i].panel=="recall") {
						if(currStateObj.elementObjectArray[i].name!="fire_warn")
							currPanel.setRecallLight(currStateObj.elementObjectArray[i].name);
					}
				}
			}
			
			
			/*if(currStateObj.elementObjectArray[i].panel=="autopilot_test") {
						if(currStateObj.elementObjectArray[i].name=="cpt_ap_prst_light" ||
						   currStateObj.elementObjectArray[i].name=="cpt_at_prst_light" ||
						   currStateObj.elementObjectArray[i].name=="cpt_fmc_prst_light") {
								parentObj.flightdeckPanelSet.disableButtons();
								parentObj.currentPanelID = "panel_37";
								parentObj.panelHolder.addChild(parentObj.panel_AUTOPILOT_TEST);
								parentObj.guideSet.gotoAndStop("panel_37");
						   }
					}*/
			
			if(currStateObj.hasHighlighting) {
				parentObj.hightlightFlightdeckPanel(currStateObj.highlightedPanels);
			} else {
				parentObj.hightlightFlightdeckPanel("none");
			}
			
			
			function innerFN1():void {
				//currElement.active = true;
				currSSwitch = sObj.keyObject.sswitch;
				if(currElement.sSwitch) currElement.sSwitch(currSSwitch); 
				
				//Here we are cheking key parater if it has conditional parameters!
//apr12				var cs = parentObj.screenOperations;
				if(sObj.keyObject.hasCondition) {
					trace("# keyObject.hasCondition: " + sObj.keyObject.hasCondition);
//apr12						cs.conditionalKeyParamters(sObj.keyObject.c_screen, sObj.keyObject.c_element, sObj.keyObject.c_value);
				} else if(sObj.keyObject.hasOption) {
					trace("# keyObject.hasOption: " + sObj.keyObject.hasOption);
//apr12						cs.optionalKeyParamters(sObj.keyObject.o_screen, sObj.keyObject.o_element, sObj.keyObject.o_value);
					activateElement();
				} else activateElement();
			}
		
			if(currStateObj.hasInopObject) {
				parentObj.configureInopScreen(currStateObj.inopScreenName, currStateObj.hasInopWhiteLine);
			} else {
				parentObj.configureInopScreen("none", false);
			}
			
			
			if(currStateObj.hasAdditional) {
				var scrObj:Object = currStateObj.additionalScreenObject;
				trace("additionalScreen: " + scrObj.screen);
				parentObj.createAdditionalState(scrObj.screen);
			} else {
				parentObj.createAdditionalState("none");
			}
		}
		
		public function activateElement():void {
			currElement.active = true;
			currElement.addEventListener(ElementPressedEvent.PRESSED, onElementPressed);
		}
		
		public function resetState():void {
			TweenLite.killTweensOf(this);
			currElement.active = false;
			currElement.removeEventListener(ElementPressedEvent.PRESSED, onElementPressed);
			
			if(currStateObj.hasParallelState) inactiveParallelElements();
			if(currStateObj.hasAdditional) parentObj.createAdditionalState("none");
		}
		
		public function completeKeyWait():void {
			trace("completeKeyWait();");
			currElement.active = false;
			currElement.removeEventListener(ElementPressedEvent.PRESSED, onElementPressed);
			parentObj.panelOperations.switchElementState(currElement, currSSwitch);
			parentObj.helpBox.visible = false;
			completeProcess();
		}
		
		public function tempLockSystem():void {
			currElement.active = false;
			currElement.removeEventListener(ElementPressedEvent.PRESSED, onElementPressed);
		}
		
		public function unlockSystem():void {
			currElement.visible = true;
			currElement.active = true;
			currElement.addEventListener(ElementPressedEvent.PRESSED, onElementPressed);
		}
		
		private function completeNextParallelState():void {
			++currPS_ID;
//			trace("currPS_ID: " + currPS_ID + " - stateObjectParallelStatesArr.length: " + stateObjectParallelStatesArr.length);
			
			if(currPS_ID<stateObjectParallelStatesArr.length) {
				currParallelStatesArr = getMultipleParallelStates(currPS_ID);
//				var currParallelState0:Object = getParallelState(currPS_ID);
//				trace(currPS_ID + ". currParallelState0.key.panel: " + currParallelState0.keyObject.element + " - " + currParallelState0.done);
				
				var tempParallelState:Object = parentObj.parallelStates.getStateByID(int(currParallelStatesArr[0]));
				if(tempParallelState.done) {
					completeNextParallelState();
				}

				for(var i:int=0; i<currParallelStatesArr.length; ++i) {

					var currParallelState:Object = parentObj.parallelStates.getStateByID(int(currParallelStatesArr[i]));
//					trace("## currParallelState: " + currParallelState.id + "  - .done: " + currParallelState.done);
					if(!currParallelState.done) {
						var currPPanel:PanelBase = getPanel(currParallelState.keyObject.panel);
						var elementHolder = currPPanel.getChildByName("elementHolder");
						currPElement = elementHolder.getChildByName(currParallelState.keyObject.element);
						
						var wt:Number = currParallelState.waitTime;
						TweenLite.to(this, 0, {delay:wt, overwrite:false, onComplete:innerFN2})
						
						function innerFN2():void {
//							currPElement.active = true;
							currPSSwitch = currParallelState.keyObject.sswitch;
							if(currPElement.sSwitch) {
								currPElement.sSwitch(currPSSwitch); 
							}
							
//							parentObj.panelOperations.switchElementState(currPElement, currPSSwitch);
							
							//Here we are cheking key parameter if it has conditional parameters!
//apr12						var cs = parentObj.screenOperations;
							if(currParallelState.hasCondition) {
								trace("# ParalellState keyObject.hasCondition: " + currParallelState.hasCondition);
//apr12									cs.conditionalKeyParamters(currParallelState.c_screen, currParallelState.c_element, currParallelState.c_value, true);
							} else if(currParallelState.hasOption) {
								trace("# ParalellState keyObject.hasOption: " + currParallelState.hasOption);
//apr12									cs.optionalKeyParamters(currParallelState.o_screen, currParallelState.o_element, currParallelState.o_value);
								activateParallelElement();
							} else activateParallelElement();
							
						}
						
						if(!parentObj.helpBox.hasMainStateNote) {
							parentObj.helpBox.noteText.text = currParallelState.note;
						}
						
					}
					
				} // end of for() loop!
			} else {
				trace("End of parallel state! - " + currPS_ID);
				currPS_ID = -1;
				parentObj.helpBox.noteText.text = "";
			}
		}
						 
		public function activateParallelElement():void {
//			trace("activateParallelElement()");
			currPElement.active = true;
			currPElement.addEventListener(ElementPressedEvent.PRESSED, onParallelElementPressed);
		}
		
		public function inactiveParallelElements():void {
			if(parentObj.currState<parentObj.statesArrLen-1) {
				for(var i:int=0; i<currParallelStatesArr.length; ++i) {
//					trace("inactiveParallelElements: " + currParallelStatesArr[i]);
					var currParallelState:Object = parentObj.parallelStates.getStateByID(int(currParallelStatesArr[i]));
					if(!currParallelState.done) {
						var currPPanel:PanelBase = getPanel(currParallelState.keyObject.panel);
						var elementHolder = currPPanel.getChildByName("elementHolder");
						currPElement = elementHolder.getChildByName(currParallelState.keyObject.element);
						currPElement.active = false;
						currPElement.removeEventListener(ElementPressedEvent.PRESSED, onParallelElementPressed);
					}
				}
			}
		}
		
		public function onKeyPanelOpened():void {
			if(currStateObj.hasParallelState) {
				inactiveParallelElements();
			}
			
			if(currStateObj.keyObject.hasOption) {
//apr12			var cs = parentObj.screenOperations;
//apr12						cs.resetOptionalKey();
			}
		
			parentObj.helpBox.visible = false;
			processDelayTimer.start();
			
			if(parentObj.infoBox1.visible || parentObj.infoBox2.visible) {
				parentObj.infoBox1.x = parentObj.infoBox2.x = 550;
			}
		}
		
		private function onElementPressed(e:ElementPressedEvent):void {
//			trace("ElementPressedEvent.eventID: " + e.target);
			if(e.eventID=="not_timeout") { 
				parentObj.helpBox.timeout_warn.visible = true; 
				parentObj.helpBox.visible = true; 
				parentObj.btnHelp.gotoAndStop(3);
				parentObj.infoBox1.x = parentObj.infoBox2.x = 360;
			}  else {
				var targetElement = e.target;
				TweenLite.to(this, 0,{delay:.05, overwrite:false, onComplete:function(){ targetElement.active = false; }});
				//trace("MainState.onEElementPressed().targetElement.active=false;");
				//targetElement.active = false;
				targetElement.removeEventListener(ElementPressedEvent.PRESSED, onElementPressed);
			
				if(currStateObj.hasParallelState) {
					inactiveParallelElements();
				}
				
				if(currStateObj.keyObject.hasOption) {
//apr12			var cs = parentObj.screenOperations;
//apr12						cs.resetOptionalKey();
				}
			
				parentObj.panelOperations.switchElementState(targetElement, currSSwitch);
			
				parentObj.helpBox.visible = false;
				processDelayTimer.start();
				
				if(parentObj.infoBox1.visible || parentObj.infoBox2.visible) {
					parentObj.infoBox1.x = parentObj.infoBox2.x = 550;
				}
		}
		}
		
		private function onParallelElementPressed(e:ElementPressedEvent):void {
			
			if(e.eventID=="not_timeout") { 
				parentObj.helpBox.timeout_warn.visible = true; 
				parentObj.helpBox.visible = true; 
				parentObj.btnHelp.gotoAndStop(3);
				parentObj.infoBox1.x = parentObj.infoBox2.x = 360;
			} else {
				if(parentObj.helpBox.timeout_warn.visible) {
					parentObj.helpBox.timeout_warn.visible = false;
					parentObj.helpBox.visible = false; 
					if(parentObj._recallStateDone) parentObj.btnHelp.gotoAndStop(2) else parentObj.btnHelp.gotoAndStop(1);
					if(parentObj.infoBox1.visible || parentObj.infoBox2.visible) {
						parentObj.infoBox1.x = parentObj.infoBox2.x = 550;
					}
				}
				
				var targetElement = e.target;
				targetElement.active = false;
				targetElement.removeEventListener(ElementPressedEvent.PRESSED, onParallelElementPressed);
				var currParallelState:Object = getParallelStateByKeyElement(targetElement.name);
				parentObj.parallelStates.stateDone(currParallelState.id)
				
				parentObj.panelOperations.switchElementState(currPElement, currPSSwitch);
//				parentObj.panelOperations.switchElementState(currPElement, currPSSwitch);
				
				// Coplete some SCREEN and helpbox process for parallel states!
				trace("#*********#")
				trace("ParallelState.screenID: " + currParallelState.screenObject.screenID);
				parentObj.completeCurrentScreenAnimation(currParallelState.screenObject.screenID);
				if(tempPSK_ID==0) {
					inactiveParallelElements();
					completeNextParallelState();					
				}
			}
		}
		
		private function getParallelStateByKeyElement(s:String):Object {
			var retObj:Object;
			tempPSK_ID = -1;
			for(var i:int=0; i<currParallelStatesArr.length; ++i) {
				var tempPS:Object = parentObj.parallelStates.getStateByID(int(currParallelStatesArr[i]));
				if(tempPS.keyObject.element==s) {
					retObj = tempPS;
					tempPSK_ID = i;
				}
			}
			return retObj;
		}
		
		private function getParallelState(n:int):Object {
			var ret:Object = parentObj.parallelStates.getStateByID(int(stateObjectParallelStatesArr[n]));
			return ret;
		}
		
		private function getMultipleParallelStates(n:int):Array {
			var retArr:Array = [];
			var s:String = stateObjectParallelStatesArr[n];
			retArr = s.split("-")
			return retArr;
		}
		
		private function completeProcess():void {
			parentObj.helpBox.timeout_warn.visible = false;
			parentObj.helpBox.setBoxData(currStateObj.helpBoxObject);
			
			if(currStateObj.hasInfoBox1) {
				parentObj.infoBox1.visible = true;
				parentObj.infoBox1.setInfoData(currStateObj.infoBox1);
			} else parentObj.infoBox1.visible = false;
			if(currStateObj.hasInfoBox2) {
				parentObj.infoBox2.visible = true;
				parentObj.infoBox2.setInfoData(currStateObj.infoBox2);
			} else parentObj.infoBox2.visible = false;
//			showHelpBoxData();
			if(parentObj.infoBox1.visible || parentObj.infoBox2.visible) {
				parentObj.infoBox1.x = parentObj.infoBox2.x = 550;
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
			
			// Coplete some screen animations
			parentObj.completeCurrentScreenAnimation(currStateObj.screenObjectID);
			parentObj.completeNextState();
		}
		
		
		private function delayTimerHandler(e:TimerEvent):void {
			processDelayTimer.reset();
			if(!hasKeyWait) completeProcess();
		}
		
		private function getPanel(s:String):PanelBase {
			var ret:PanelBase
			switch(s) {
				case "recall":
					ret = parentObj.panel_RECALL;
					break;
				case "elt":
					ret = parentObj.panel_ELT;
					break;
				case "le_devices":
					ret = parentObj.panel_LE_DEVICES;
					break;
				case "psue":
					ret = parentObj.panel_PSUE;
					break;
				case "flt_controls":
					ret = parentObj.panel_FLT_CONTROLS;
					break;
				case "navs_and_displays":
					ret = parentObj.panel_NAVS_AND_DISPLAYS;
					break;
				case "fuel":
					ret = parentObj.panel_FUEL;
					break;
				case "irs_system_display":
					ret = parentObj.panel_IRS_SYSTEM_DISPLAY;
					break;
				case "electrical1":
					ret = parentObj.panel_ELECTRICAL1;
					break;
				case "electrical2":
					ret = parentObj.panel_ELECTRICAL2;
					break;
				case "electrical3":
					ret = parentObj.panel_ELECTRICAL3;
					break;
				case "apu":
					ret = parentObj.panel_APU;
					break;
				case "service_interphone":
					ret = parentObj.panel_SERVICE_INTERPHONE;
					break;
				case "dome_white":
					ret = parentObj.panel_DOME_WHITE;
					break;
				case "lights1":
					ret = parentObj.panel_LIGHTS1;
					break;
				case "equip_cooling":
					ret = parentObj.panel_EQUIP_COOLING;
					break;
				case "emerg_exit":
					ret = parentObj.panel_EMERG_EXIT;
					break;
				case "engine_start":
					ret = parentObj.panel_ENGINE_START;
					break;
				case "audio_selector1":
					ret = parentObj.panel_AUDIO_SELECTOR1;
					break;
				case "engines":
					ret = parentObj.panel_ENGINES1;
					break;
				case "oxygen":
					ret = parentObj.panel_OXYGEN;
					break;
				case "landing_gear1":
					ret = parentObj.panel_LANDING_GEAR1;
					break;
				case "anti_ice1":
					ret = parentObj.panel_ANTI_ICE1;
					break;
				case "anti_ice2":
					ret = parentObj.panel_ANTI_ICE2;
					break;
				case "hydraulics_doors":
					ret = parentObj.panel_HYDRAULICS_DOORS;
					break;
				case "cvr":
					ret = parentObj.panel_CVR;
					break;
				case "pressurisation1":
					ret = parentObj.panel_PRESSURISATION1;
					break;
				case "fdr_mach_test":
					ret = parentObj.panel_FDR_MACH_TEST;
					break;
				case "stall_warning":
					ret = parentObj.panel_STALL_WARNING;
					break;
				case "air_cond":
					ret = parentObj.panel_AIR_COND;
					break;
				case "pressurisation2":
					ret = parentObj.panel_PRESSURISATION2;
					break;
				case "pressurisation3":
					ret = parentObj.panel_PRESSURISATION3;
					break;
//				case "cpt_recall":
//					ret = parentObj.panel_CPT_RECALL;
//					break;
				case "mcp":
					ret = parentObj.panel_MCP;
					break;
//				case "fo_recall":
//					ret = parentObj.panel_FO_RECALL;
//					break;
				case "cpt_du":
					ret = parentObj.panel_CPT_DU;
					break;
				case "autopilot_test":
					ret = parentObj.panel_AUTOPILOT_TEST;
					break;
				case "n1_spd_ref":
					ret = parentObj.panel_N1_SPD_REF;
					break;
				case "flap_indicator":
					ret = parentObj.panel_FLAP_INDICATOR;
					break;
				case "landing_gear2":
					ret = parentObj.panel_LANDING_GEAR2;
					break;
				case "brake_press":
					ret = parentObj.panel_BRAKE_PRESS;
					break;
				case "fo_du":
					ret = parentObj.panel_FO_DU;
					break;
				case "nose_wheel":
					ret = parentObj.panel_NOSE_WHEEL;
					break;
				case "screen_selectors":
					ret = parentObj.panel_SCREEN_SELECTORS;
					break;
				case "cpt_cdu":
					ret = parentObj.panel_CPT_CDU;
					break;
				case "gpws":
					ret = parentObj.panel_GPWS;
					break;
				case "tl":
					ret = parentObj.panel_THRUST_LEVERS;
					break;
				case "fire":
					ret = parentObj.panel_FIRE;
					break;
				case "com":
					ret = parentObj.panel_COM;
					break;
				case "nav":
					ret = parentObj.panel_NAV;
					break;
				case "lights2":
					ret = parentObj.panel_LIGHTS2;
					break;
				case "cargo":
					ret = parentObj.panel_CARGO;
					break;
				case "wx_radar":
					ret = parentObj.panel_WX_RADAR;
					break;
				case "selcal":
					ret = parentObj.panel_SELCAL;
					break;
				case "xpndr":
					ret = parentObj.panel_XPNDR;
					break;
				case "rudder_and_aileron":
					ret = parentObj.panel_RUDDER_AND_AILERON;
					break;
				case "stab_trim":
					ret = parentObj.panel_STAB_TRIM;
					break;
				default:
					trace("Error in MainState, getPanel() function. Unknown panel instance name: " + s);
					break;
			}
			return ret;
		}
	}
	
}