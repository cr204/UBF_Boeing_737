package com.winglet {
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.net.navigateToURL;

	import com.winglet.*;
	import com.winglet.events.*;
	import com.winglet.assets.*;
	import com.winglet.operations.*;
	import com.winglet.assets.panels.*;
	import com.winglet.assets.states.*;
//	import com.winglet.assets.screens.*;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	import com.winglet.qrh.YellowPage;
	
	public class Main extends MovieClip {
		public static const APPLICATION_PRELOADER_UPDATE_TIME:Number = 200;
		private static const KEY_PRESS_TIME:int = 0;
		private var DEFAULT_XML_PATH:String = "xml/wm_training02.xml";
		//private var DEFAULT_XML_PATH:String = "xml/ECAM ELEC GEN 1 FAULT IN CRUISE.xml";
		private var MAIN_XML_PATH:String;
				
		private var statesArr:Array = [];
		public var statesArrLen:Number = 0;
		private var xmlSettings:XMLSettings;
		public var parallelStates:ParallelStates;
		private var screenStates:ScreenStates;
		public var screenDefaults:ScreenDefaults;
		public var recallStateSet:Boolean = false;
		
		// Panel declarations
		public var panel_RECALL:Panel00_RECALL;
		public var panel_ELT:Panel01_ELT;
		public var panel_LE_DEVICES:Panel02_LE_DEVICES;
		public var panel_PSUE:Panel03_PSUE;
		public var panel_FLT_CONTROLS:Panel04_FLT_CONTROLS;
		public var panel_NAVS_AND_DISPLAYS:Panel05_NAVS_AND_DISPLAYS;
		public var panel_FUEL:Panel06_FUEL;
		public var panel_IRS_SYSTEM_DISPLAY:Panel07_IRS_SYSTEM_DISPLAY;
//		public var panel08:Panel08;
		public var panel_ELECTRICAL1:Panel09_ELECTRICAL1;
		public var panel_ELECTRICAL2:Panel10_ELECTRICAL2;
		public var panel_ELECTRICAL3:Panel11_ELECTRICAL3;
		public var panel_APU:Panel12_APU;
		public var panel_SERVICE_INTERPHONE:Panel13_SERVICE_INTERPHONE;
		public var panel_DOME_WHITE:Panel14_DOME_WHITE;
		public var panel_LIGHTS1:Panel15_LIGHTS;
		public var panel_EQUIP_COOLING:Panel16_EQUIP_COOLING;
		public var panel_EMERG_EXIT:Panel17_EMERG_EXIT;
		public var panel_ENGINE_START:Panel18_ENGINE_START;
		public var panel_AUDIO_SELECTOR1:Panel19_AUDIO_SELECTOR;
		public var panel_ENGINES1:Panel20_ENGINES;
		public var panel_OXYGEN:Panel21_OXYGEN;
		public var panel_LANDING_GEAR1:Panel22_LANDING_GEAR1;
		public var panel_ANTI_ICE1:Panel23_ANTI_ICE1;
		public var panel_ANTI_ICE2:Panel24_ANTI_ICE2;
		public var panel_HYDRAULICS_DOORS:Panel25_HYDRAULICS_DOORS;
		public var panel_CVR:Panel26_CVR;
		public var panel_PRESSURISATION1:Panel27_PRESSURISATION1;
		public var panel_FDR_MACH_TEST:Panel28_FDR_MACH_TEST;
		public var panel_STALL_WARNING:Panel29_STALL_WARNING;
		public var panel_AIR_COND:Panel30_AIR_COND;
		public var panel_PRESSURISATION2:Panel31_PRESSURISATION2;
		public var panel_PRESSURISATION3:Panel32_PRESSURISATION3;
//		public var panel_CPT_RECALL:Panel33_CPT_RECALL;
		public var panel_MCP:Panel34_MCP;
//		public var panel_FO_RECALL:Panel35_FO_RECALL;
		public var panel_CPT_DU:Panel36_CPT_DU;
		public var panel_AUTOPILOT_TEST:Panel37_AUTOPILOT_TEST;
		public var panel_N1_SPD_REF:Panel38_N1_SPD_REF;
		public var panel_FLAP_INDICATOR:Panel39_FLAP_INDICATOR;
		public var panel_LANDING_GEAR2:Panel40_LANDING_GEAR2;
		public var panel_BRAKE_PRESS:Panel41_BRAKE_PRESS;
		public var panel_FO_DU:Panel42_FO_DU;
		public var panel_NOSE_WHEEL:Panel43_NOSE_WHEEL;
		public var panel_SCREEN_SELECTORS:Panel44_SCREEN_SELECTORS;
		public var panel_CPT_CDU:Panel45_CPT_CDU;
//		public var panel46:Panel46;
		public var panel_GPWS:Panel47_GPWS;
//		public var panel48:Panel48;
//		public var panel49:Panel49;
		public var panel_THRUST_LEVERS:Panel50_THRUST_LEVERS;
//		public var panel51:Panel51;
//		public var panel52:Panel52;
		public var panel_FIRE:Panel53_FIRE;
		public var panel_COM:Panel54_COM;
		public var panel_NAV:Panel55_NAV;
//		public var panel56:Panel56;
		public var panel_LIGHTS2:Panel57_LIGHTS2;
		public var panel_CARGO:Panel58_CARGO;
		public var panel_WX_RADAR:Panel59_WX_RADAR;
		public var panel_SELCAL:Panel60_SELCAL;
		public var panel_XPNDR:Panel61_XPNDR;
//		public var panel62:Panel62;
		public var panel_RUDDER_AND_AILERON:Panel63_RUDDER_AND_AILERON;
//		public var panel64:Panel54_COM;
//		public var panel65:Panel55_NAV;
		public var panel_STAB_TRIM:Panel67_STAB_TRIM;
		


		public var currentPanel: *;
		public var currentPanelID: String = "";
		private var pID:String = "";
		private var tempBool:Boolean;
		private var _mainXMLLoaded:Boolean = true;
		public var _appStarted:Boolean = false;
		private var _defaultStateDone:Boolean = false;
		private var _startStateDone:Boolean = false;
		public var _recallStateDone:Boolean = false;
		public var _mainStatesDone:Boolean = false;
		public var currState:int = -1;
		public var inopScreenName:String = "none";
		public var currSystemState:MainState;
//		private var currAdditionalState:AdditionalState;
		public var recallObj:Object;
//		private var recallState:RecallState;
		private var _ecamSwitchingDisable:String = "";
		public var keyPressingTime:int = KEY_PRESS_TIME;
		private var _hasKeyPanel:Boolean = false;
		private var _keyPanel:PanelBase;
		private var quickReference:YellowPage;

		public var panelOperations:PanelOperations;
		public var screenOperations:ScreenOperations;

			
		public function Main() {
			stop();
			
			MAIN_XML_PATH = root.loaderInfo.parameters.mainXML;

			if(MAIN_XML_PATH==null) MAIN_XML_PATH=DEFAULT_XML_PATH;
			//trace("MAIN_XML_PATH: " + MAIN_XML_PATH);
		
			var mainLoader:URLLoader = new URLLoader();
			mainLoader.addEventListener(Event.COMPLETE, onMainXMLLoad);
			mainLoader.load(new URLRequest(MAIN_XML_PATH));

			
			var loadingTimer:Timer = new Timer(APPLICATION_PRELOADER_UPDATE_TIME);
			loadingTimer.addEventListener(TimerEvent.TIMER, appLoadingHandler);
			loadingTimer.start();
			
		}
		
		// FUNCTION onMainXMLLoad() 
		private function onMainXMLLoad(e:Event):void {
			try {
				trace("XML loaded succesfully!");
				var mainData:XML = new XML( e.target.data );
				
				if(mainData.settings) {
					xmlSettings = new XMLSettings(mainData.settings);
					if(xmlSettings.parallelStatesFN == "") {
						trace("No parallel states!");
					} else {
						parallelStates = new ParallelStates(xmlSettings.parallelStatesFN);
					}
					
					if(xmlSettings.screenFN == "") trace("Error! Screen XML filename is not shown.") else screenStates = new ScreenStates(xmlSettings.screenFN);
					if(xmlSettings.screenDFN == "") trace("Error! Screen defaults XML filename is not shown.") else screenDefaults = new ScreenDefaults(xmlSettings.screenDFN);
					if(xmlSettings.quickReference == "") trace("Error! QRH XML filename is not shown.") else quickReference = new YellowPage(xmlSettings.quickReference);
				}

				if(mainData.states) {
					
					for each(var element:XML in mainData.states.elements()) {
						var parsedState:Object = {
										id: element.@id.toString(),
										fdisable: element.@flightdeck.toString(),
										waitTime: Number(element.@wait),
										ecamSwitching: element.@ecam_switching.toString(),
										paramXML: element 
										}
						statesArr.push(parsedState);
					}
				}
				//trace(statesArr[2].paramXML);
				statesArrLen = statesArr.length;
				
//				if(mainData.recall) {
//					recallObj = new Object();
//					recallObj.retStateID = mainData.recall.recall.@stateID.toString();
//					recallObj.screenID = mainData.recall.recall.@screenID.toString();
//					if(mainData.recall.recall.@stateID.toString()=="") {
//						trace("No reCall state!");
//					} else {
//						recallStateSet = true;
//					}
//				}
				
				_mainXMLLoaded = true;
				
			} catch(err:Error) {
				trace(MAIN_XML_PATH + " file loading Error:" + err.message);
				_mainXMLLoaded = true;
				return;
			}
		}
		
		
		private function onApplicationLoaded():void {
			gotoAndStop(2);
			whiteCover.visible = false;
			init();
			completeNextState();
		}
		
		public function completeNextState():void {
			++currState;
			if(currState<statesArrLen) doState(currState) else {
				btnHelp.gotoAndStop(2);
				_mainStatesDone = true;
/*				createAdditionalState("all");
				if(!_recallStateDone) {
					enableRecall();
				} else {
					recallState.enable();
				}*/
			}
			if(currState>1) btnRestart.visible = true;
		}
		
		private function doState(n:int):void {
			trace("***********");
			trace("doState: " + n);
			
			var currStateObj:StateObject = new StateObject(statesArr[n].paramXML);
			trace("##doState.stateID: " + currStateObj.stateID);
			
			switch(currStateObj.stateID) {
				case "default":
						if(!_defaultStateDone) {
							screenOperations.setScreenDefaults();
							var dState:DefaultState = new DefaultState(this);
							dState.stateObj(currStateObj);
							_defaultStateDone = true;
//							screenOperations.completeScreenMathCalculations();
						} else trace("Error: _defaultStateDone is already: " + _defaultStateDone);
						break;
				case "start":
						if(!_startStateDone) {
							flightdeckPanelSet.disableButtons();
							var sState:StartState = new StartState(this);
							sState.stateObj(currStateObj);
							_startStateDone = true;
						} else trace("Error: _startStateDone is already: " + _startStateDone);
						break;
				default:
						if(_recallStateDone) btnHelp.gotoAndStop(2) else btnHelp.gotoAndStop(1);
						if(statesArr[n].fdisable=="disable") flightdeckPanelSet.disableButtons() else flightdeckPanelSet.enableButtons();
						var mState:MainState = new MainState(this);
						mState.stateObj(currStateObj, statesArr[n].waitTime);
//						trace("statesArr[" + n + "].ecamSwitching: " + statesArr[n].ecamSwitching);
						_ecamSwitchingDisable = statesArr[n].ecamSwitching;
						currSystemState = mState;
						break;
			}
		}
		
		public function configureInopScreen(s:String, b:Boolean):void {
//			inopScreenName = s;
//			if(inopScreenName!="none") trace("inopScreenName: " + inopScreenName);
		}
		
		public function completeCurrentScreenAnimation(s:String):void {
			var screenObj:Object = screenStates.getScreenByID(s);
			screenOperations.screenObject(screenObj);
		}
		
/*		public function completeAdditionalScreenAnimation(sObj:*):void {
//			screenOperations.addAdditionalSystemToSD(sObj.name, sObj.currentState);
		}
		
		public function setSDScreenSeries(s:String):void {
//			screenOperations.addSeriesToSD(s);
		}
*/		
		public function completePanelOperationFromScreenXML(xmlObj:XML):void {
			panelOperations.updateElementState1(xmlObj);
		}
	
		public function createAdditionalState(s:String):void {
/*			if(currAdditionalState) {
				currAdditionalState.enableElements("none");
				currAdditionalState = null;
			}
			
			if(s!="none") {
				var aState:AdditionalState = new AdditionalState(this);

//				if(inopScreenName=="none") aState.enableElements(s, false) else aState.enableElements(s, true);
				currAdditionalState = aState;
				currAdditionalState.ecamSwitching = _ecamSwitchingDisable;
				if(inopScreenName=="none") currAdditionalState.enableElements(s, false) else currAdditionalState.enableElements(s, true);
				
			}*/
		}
		
		public function getVelocitiesByID(s:String):Object {
			var retObj:Object = screenStates.getVelocitiesByID(s);
			return retObj;
		} 
		
		public function hightlightFlightdeckPanel(s:String):void {
			flightdeckPanelSet.hightlightFlightdeckPanel(s);
		}
		
		private function init():void {
			
			screen_PFD_ND.visible = false;
			
			panelOperations = new PanelOperations();
			panelOperations.init(this);
			
			screenOperations = new ScreenOperations();
			screenOperations.init(this);
			
			if(xmlSettings.quickReference != "") {
				quickReference.x = -411;
				qrhHolder.addChild(quickReference);
			}
			
			btnHelp.addEventListener(MouseEvent.MOUSE_DOWN, openHelpBox);
			btnInfo.addEventListener(MouseEvent.MOUSE_DOWN, openInfoLink);
			btnRestart.visible = false;
			helpBox.visible = false;
			infoBox1.visible = false;
			infoBox2.visible = false;
			
			initScreens();
			initPanels();
			
			flightdeckPanelSet.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			
			// adding Event Listeners to panels
			panel_ELT.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_LE_DEVICES.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_PSUE.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_FLT_CONTROLS.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_NAVS_AND_DISPLAYS.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_FUEL.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_IRS_SYSTEM_DISPLAY.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
//			panel08.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_ELECTRICAL1.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_ELECTRICAL2.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_ELECTRICAL3.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_APU.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_SERVICE_INTERPHONE.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_DOME_WHITE.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_LIGHTS1.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_EQUIP_COOLING.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_EMERG_EXIT.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_ENGINE_START.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_AUDIO_SELECTOR1.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_ENGINES1.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_OXYGEN.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_LANDING_GEAR1.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_ANTI_ICE1.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_ANTI_ICE2.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_HYDRAULICS_DOORS.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_CVR.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_PRESSURISATION1.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_FDR_MACH_TEST.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_STALL_WARNING.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_AIR_COND.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_PRESSURISATION2.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_PRESSURISATION3.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
//			panel_CPT_RECALL.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_MCP.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
//			panel_FO_RECALL.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_CPT_DU.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_AUTOPILOT_TEST.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_N1_SPD_REF.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_FLAP_INDICATOR.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_LANDING_GEAR2.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_BRAKE_PRESS.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_FO_DU.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_NOSE_WHEEL.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_SCREEN_SELECTORS.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_CPT_CDU.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
//			panel46.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_GPWS.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
//			panel48.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
//			panel49.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_THRUST_LEVERS.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
//			panel51.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
//			panel52.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_FIRE.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_COM.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_NAV.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_LIGHTS2.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_CARGO.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_WX_RADAR.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_SELCAL.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_XPNDR.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_RUDDER_AND_AILERON.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
//			panel64.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
//			panel65.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			panel_STAB_TRIM.addEventListener(PanelSelectedEvent.SELECTED, onPanelSelected);
			
			
			btnRestart.addEventListener(MouseEvent.MOUSE_DOWN, onRestartApplication);
			btnStart.init();
			
//			flightdeckPanelSet.hiddenCover.visible = false;

		}
		
		private function initScreens():void {
			screen_PFD_ND.screenHolder1.capt_PFD.init(this);
			screen_PFD_ND.screenHolder1.capt_ND.init(this);
			screen_PFD_ND.screenHolder1.fo_PFD.init(this);
			screen_PFD_ND.screenHolder1.fo_ND.init(this);
			
			
		}
		
		private function onRestartApplication(e:MouseEvent):void {
			trace("onRestartApplication");
			whiteCover.visible = true;
			
			TweenLite.killTweensOf(this);	
			if(currSystemState!=null) currSystemState.resetState();
			resetPanels();
			resetScreens();
			
//			if(qrhHolder.numChildren>0) removeObjChildren(qrhHolder);
			
			btnStart.init();
			btnRestart.visible = false;
			btnHelp.gotoAndStop(1);
			helpBox.visible = false;
			infoBox1.visible = false;
			infoBox2.visible = false;
					
			if(parallelStates!=null) parallelStates.resetStates();
			
			TweenLite.to(this, 0, {delay:1, onComplete:function(){ whiteCover.visible = false; }});
			
			resetVariables();
			panelOperations.reset();
			
			completeNextState();
		}
		
		private function resetVariables():void {
			currentPanel = null;
			currentPanelID = "";
			pID = "";
			tempBool = false;
			_appStarted = false;
			_defaultStateDone = false;
			_startStateDone = false;
			_recallStateDone = false;
			_mainStatesDone = false;
			currState = -1;
			inopScreenName = "none";
			currSystemState = null;
		}
		
/*		private function getIndexByStateID(s:String):int {
			var ret:int = 0;
			for(var i:int=0; i<statesArr.length; ++i) {
				if(s==statesArr[i].id) ret=i;
			}
			return ret;
		}
		*/
		private function appLoadingHandler(e:TimerEvent):void {
			var bTotal = stage.loaderInfo.bytesTotal;
			var bLoaded = stage.loaderInfo.bytesLoaded;
//			var percLoaded:int = Math.floor( Math.round(bLoaded*100/bTotal));
//			preLogo.gotoAndStop(percLoaded);
			
			var _PSLoaded:Boolean = false;
			var _SSLoaded:Boolean = false;
			var _SDLoaded:Boolean = false;
			var _QRHLoaded:Boolean = false;
			if(xmlSettings!=null) {
				if(xmlSettings.parallelStatesFN=="") _PSLoaded=true else _PSLoaded=parallelStates.loaded;
				if(xmlSettings.screenFN=="") _SSLoaded=true else _SSLoaded=screenStates.loaded;
				if(xmlSettings.screenDFN=="") _SDLoaded=true else _SDLoaded=screenDefaults.loaded;
				if(xmlSettings.quickReference=="") _QRHLoaded=true else _QRHLoaded=quickReference.loaded;
			}

			if((bLoaded >= bTotal) && _mainXMLLoaded && _PSLoaded && _SSLoaded && _SDLoaded && _QRHLoaded) {
				Timer(e.currentTarget).stop();
				Timer(e.currentTarget).removeEventListener(TimerEvent.TIMER, appLoadingHandler);
				onApplicationLoaded();
			}
		}
		
/*		public function tempLockSystem():void {
			//TweenLite.to(this, .5, {delay:.5, onComplete:function(){ currSystemState.tempLockSystem(); } })
			TweenLite.to(this, 0, {delay:.3, onComplete:function(){ currSystemState.tempLockSystem(); } })
		}
		
		public function unlockSystem():void {
			currSystemState.unlockSystem();
		}*/
		
		public function keyPanelObject(pn:PanelBase):void {
			_hasKeyPanel = true;
			_keyPanel = pn;
		}
		
		private function checkKeyPanel():void {
			trace("checkKeyPanel");
			if(_hasKeyPanel) {
				if(currentPanel==_keyPanel) {
					trace("Key Panel opened!");
					_hasKeyPanel = false;
					currSystemState.onKeyPanelOpened();
				}
			}
		}
		
		private function onPanelSelected(e:PanelSelectedEvent):void {
			
			pID = e.panelID;
			closePanel();
			tempBool = true;
			
			if(currentPanelID!=pID) {
			
				// Switch case
				switch(pID) {
					case "panel_1":
						currentPanel = panel_ELT;
						break;
					case "panel_2":
						currentPanel = panel_LE_DEVICES;
						break;
					case "panel_3":
						currentPanel = panel_PSUE;
						break;
					case "panel_4":
						currentPanel = panel_FLT_CONTROLS;
						break;
					case "panel_5":
						currentPanel = panel_NAVS_AND_DISPLAYS;
						break;
					case "panel_6":
						currentPanel = panel_FUEL;
						break;
					case "panel_7":
						currentPanel = panel_IRS_SYSTEM_DISPLAY;
						break;
/*					case "panel_8":
						currentPanel = panel08;
						break;  */
					case "panel_9":
						currentPanel = panel_ELECTRICAL1;
						break;
					case "panel_10":
						currentPanel = panel_ELECTRICAL2;
						break;
					case "panel_11":
						currentPanel = panel_ELECTRICAL3;
						break;
					case "panel_12":
						currentPanel = panel_APU;
						break;
					case "panel_13":
						currentPanel = panel_SERVICE_INTERPHONE;
						break;
					case "panel_14":
						currentPanel = panel_DOME_WHITE;
						break;
					case "panel_15":
						currentPanel = panel_LIGHTS1;
						break;
					case "panel_16":
						currentPanel = panel_EQUIP_COOLING;
						break;
					case "panel_17":
						currentPanel = panel_EMERG_EXIT;
						break;
					case "panel_18":
						currentPanel = panel_ENGINE_START;
						break;
					case "panel_19":
						currentPanel = panel_AUDIO_SELECTOR1;
						break;
					case "panel_20":
						currentPanel = panel_ENGINES1;
						break;
					case "panel_21":
						currentPanel = panel_OXYGEN;
						break;
					case "panel_22":
						currentPanel = panel_LANDING_GEAR1;
						break;
					case "panel_23":
						currentPanel = panel_ANTI_ICE1;
						break;
					case "panel_24":
						currentPanel = panel_ANTI_ICE2;
						break;
					case "panel_25":
						currentPanel = panel_HYDRAULICS_DOORS;
						break;
					case "panel_26":
						currentPanel = panel_CVR;
						break;
					case "panel_27":
						currentPanel = panel_PRESSURISATION1;
						break;
					case "panel_28":
						currentPanel = panel_FDR_MACH_TEST;
						break;
					case "panel_29":
						currentPanel = panel_STALL_WARNING;
						break;
					case "panel_30":
						currentPanel = panel_AIR_COND;
						break;
					case "panel_31":
						currentPanel = panel_PRESSURISATION2;
						break;
					case "panel_32":
						currentPanel = panel_PRESSURISATION3;
						break;
					case "panel_33":
						currentPanel = panel_RECALL;
						break;
					case "panel_34":
						currentPanel = panel_MCP;
						break;
					case "panel_35":
						currentPanel = panel_RECALL;
						break;
					case "panel_36":
						currentPanel = panel_CPT_DU;
						break;
					case "panel_37":
						currentPanel = panel_AUTOPILOT_TEST;
						break;
					case "panel_38":
						currentPanel = panel_N1_SPD_REF;
						break;
					case "panel_39":
						currentPanel = panel_FLAP_INDICATOR;
						break;
					case "panel_40":
						currentPanel = panel_LANDING_GEAR2;
						break;
					case "panel_41":
						currentPanel = panel_BRAKE_PRESS;
						break;
					case "panel_42":
						currentPanel = panel_FO_DU;
						break;
					case "panel_43":
						currentPanel = panel_NOSE_WHEEL;
						break;
					case "panel_44":
						currentPanel = panel_SCREEN_SELECTORS;
						break;
					case "panel_45":
						currentPanel = panel_CPT_CDU;
						break;
/*					case "panel_46":
						currentPanel = panel46;
						break;*/
					case "panel_47":
						currentPanel = panel_GPWS;
						break;
/*					case "panel_48":
						currentPanel = panel48;
						break;
					case "panel_49":
						currentPanel = panel49;
						break;  */
					case "panel_50":
						currentPanel = panel_THRUST_LEVERS;
						break;
/*					case "panel_51":
						currentPanel = panel51;
						break;						
					case "panel_52":
						currentPanel = panel52;
						break;						*/
					case "panel_53":
						currentPanel = panel_FIRE;
						break;						
					case "panel_54":
						currentPanel = panel_COM;
						break;						
					case "panel_55":
						currentPanel = panel_NAV;
						break;						
					case "panel_57":
						currentPanel = panel_LIGHTS2;
						break;						
					case "panel_58":
						currentPanel = panel_CARGO;
						break;						
					case "panel_59":
						currentPanel = panel_WX_RADAR;
						break;						
					case "panel_60":
						currentPanel = panel_SELCAL;
						break;
					case "panel_61":
						currentPanel = panel_XPNDR;
						break;	
					case "panel_63":
						currentPanel = panel_RUDDER_AND_AILERON;
						break;	
/*					case "panel_64":
						currentPanel = panel64;
						break;
					case "panel_65":
						currentPanel = panel65;
						break;	*/	
					case "panel_67":
						trace("Panel 67");
						currentPanel = panel_STAB_TRIM;
						break;	

					default:
						trace("Error! Unknow panel ID: " + pID);
						tempBool = false;
						break;
				}
				
				if(currentPanel) currentPanel.enableHolder = true;
				currentPanelID = pID;
				if(tempBool) panelHolder.addChild(currentPanel);
				guideSet.gotoAndStop(pID);
			} else {
				//closePanel();
				currentPanelID="";
			}
			
			if(_hasKeyPanel) checkKeyPanel();
		}
		
		public function closePanel():void {
			if(currentPanel!=undefined) currentPanel.enableHolder = false;
			if(panelHolder.numChildren>0) { 
				if(currentPanel==undefined) panelHolder.removeChildAt(0) else
												panelHolder.removeChild(currentPanel);
				guideSet.gotoAndStop(1);
			}
			currentPanel = undefined;
		}
		
		public function showITooltip():void {
			incorrectToolTip.gotoAndPlay(1);
			incorrectToolTip.x = stage.mouseX + 13;
			incorrectToolTip.y = stage.mouseY + 5;
		}
	
		private function openHelpBox(e:MouseEvent):void {
			if(_recallStateDone) btnHelp.gotoAndStop(2) else btnHelp.gotoAndStop(1);
			if(!helpBox.visible) {
				helpBox.timeout_warn.visible = false;
				helpBox.visible = true;
				if(infoBox1.visible || infoBox2.visible) {
					infoBox1.x = infoBox2.x = 360;
				}
			} else {
				helpBox.visible = false;
				if(infoBox1.visible || infoBox2.visible) {
					infoBox1.x = infoBox2.x = 550;
				}
			}
		}
		
		private function openInfoLink(e:MouseEvent):void {
			var url:String = "http://www.usebeforeflight.com/training3.0/_information2.php?id=4";
			var req:URLRequest = new URLRequest(url);
    		try {            
				navigateToURL(req, "_blank");
            } catch (err:Error) {
                // handle error here
            }
		}


		private function initPanels():void {
			
			// initializing Panels
			panel_RECALL = new Panel00_RECALL();
			panel_RECALL.init(this);
			panel_RECALL.x = 391;
			panel_RECALL.y = 596;
			
			panel_ELT = new Panel01_ELT();
			panel_ELT.init(this);
			panel_ELT.x = 559;
			panel_ELT.y = 209;
			
			panel_LE_DEVICES = new Panel02_LE_DEVICES();
			panel_LE_DEVICES.init(this);
			panel_LE_DEVICES.x = 558;
			panel_LE_DEVICES.y = 222;
			
			panel_PSUE = new Panel03_PSUE();
			panel_PSUE.init(this);
			panel_PSUE.x = 558;
			panel_PSUE.y = 235;
			
			panel_FLT_CONTROLS = new Panel04_FLT_CONTROLS();
			panel_FLT_CONTROLS.init(this);
			panel_FLT_CONTROLS.x = 420;
			panel_FLT_CONTROLS.y = 190;
			
			panel_NAVS_AND_DISPLAYS = new Panel05_NAVS_AND_DISPLAYS();
			panel_NAVS_AND_DISPLAYS.init(this);
			panel_NAVS_AND_DISPLAYS.x = 582;
			panel_NAVS_AND_DISPLAYS.y = 285;
			
			panel_FUEL = new Panel06_FUEL();
			panel_FUEL.init(this);
			panel_FUEL.x = 547;
			panel_FUEL.y = 172;
			
			panel_IRS_SYSTEM_DISPLAY = new Panel07_IRS_SYSTEM_DISPLAY();
			panel_IRS_SYSTEM_DISPLAY.init(this);
			panel_IRS_SYSTEM_DISPLAY.x = 627;
			panel_IRS_SYSTEM_DISPLAY.y = 215;
			
/*			panel08 = new Panel08();
			panel08.init(this);
			panel08.x = 541;
			panel08.y = 220;*/
			
			panel_ELECTRICAL1 = new Panel09_ELECTRICAL1();
			panel_ELECTRICAL1.init(this);
			panel_ELECTRICAL1.x = 574;
			panel_ELECTRICAL1.y = 273;
			
			panel_ELECTRICAL2 = new Panel10_ELECTRICAL2();
			panel_ELECTRICAL2.init(this);
			panel_ELECTRICAL2.x = 590;
			panel_ELECTRICAL2.y = 310;
			
			panel_ELECTRICAL3 = new Panel11_ELECTRICAL3();
			panel_ELECTRICAL3.init(this);
			panel_ELECTRICAL3.x = 590;
			panel_ELECTRICAL3.y = 317;
			
			panel_APU = new Panel12_APU();
			panel_APU.init(this);
			panel_APU.x = 547;
			panel_APU.y = 310;
			
			panel_SERVICE_INTERPHONE = new Panel13_SERVICE_INTERPHONE();
			panel_SERVICE_INTERPHONE.init(this);
			panel_SERVICE_INTERPHONE.x = 757;
			panel_SERVICE_INTERPHONE.y = 210;
			
			panel_DOME_WHITE = new Panel14_DOME_WHITE();
			panel_DOME_WHITE.init(this);
			panel_DOME_WHITE.x = 770;
			panel_DOME_WHITE.y = 235;
			
			panel_LIGHTS1 = new Panel15_LIGHTS();
			panel_LIGHTS1.init(this);
			panel_LIGHTS1.x = 747;
			panel_LIGHTS1.y = 238;
			
			panel_EQUIP_COOLING = new Panel16_EQUIP_COOLING();
			panel_EQUIP_COOLING.init(this);
			panel_EQUIP_COOLING.x = 747;
			panel_EQUIP_COOLING.y = 258;
			
			panel_EMERG_EXIT = new Panel17_EMERG_EXIT();
			panel_EMERG_EXIT.init(this);
			panel_EMERG_EXIT.x = 607;
			panel_EMERG_EXIT.y = 182;
			
			panel_ENGINE_START = new Panel18_ENGINE_START();
			panel_ENGINE_START.init(this);
			panel_ENGINE_START.x = 490;
			panel_ENGINE_START.y = 352;
			
			panel_AUDIO_SELECTOR1 = new Panel19_AUDIO_SELECTOR();
			panel_AUDIO_SELECTOR1.init(this);
			panel_AUDIO_SELECTOR1.x = 636;
			panel_AUDIO_SELECTOR1.y = 203;
			
			panel_ENGINES1 = new Panel20_ENGINES();
			panel_ENGINES1.init(this);
			panel_ENGINES1.x = 647;
			panel_ENGINES1.y = 216;
			
			panel_OXYGEN = new Panel21_OXYGEN();
			panel_OXYGEN.init(this);
			panel_OXYGEN.x = 647;
			panel_OXYGEN.y = 225;
			
			panel_LANDING_GEAR1 = new Panel22_LANDING_GEAR1();
			panel_LANDING_GEAR1.init(this);
			panel_LANDING_GEAR1.x = 632;
			panel_LANDING_GEAR1.y = 262;
			
			panel_ANTI_ICE1 = new Panel23_ANTI_ICE1();
			panel_ANTI_ICE1.init(this);
			panel_ANTI_ICE1.x = 591;
			panel_ANTI_ICE1.y = 257;
			
			panel_ANTI_ICE2 = new Panel24_ANTI_ICE2();
			panel_ANTI_ICE2.init(this);
			panel_ANTI_ICE2.x = 627;
			panel_ANTI_ICE2.y = 318;
			
			panel_HYDRAULICS_DOORS = new Panel25_HYDRAULICS_DOORS();
			panel_HYDRAULICS_DOORS.init(this);
			panel_HYDRAULICS_DOORS.x = 627;
			panel_HYDRAULICS_DOORS.y = 318;
			
			panel_CVR = new Panel26_CVR();
			panel_CVR.init(this);
			panel_CVR.x = 642;
			panel_CVR.y = 318;
			
			panel_PRESSURISATION1 = new Panel27_PRESSURISATION1();
			panel_PRESSURISATION1.init(this);
			panel_PRESSURISATION1.x = 610;
			panel_PRESSURISATION1.y = 318;
			
			panel_FDR_MACH_TEST = new Panel28_FDR_MACH_TEST();
			panel_FDR_MACH_TEST.init(this);
			panel_FDR_MACH_TEST.x = 627;
			panel_FDR_MACH_TEST.y = 235;
			
			panel_STALL_WARNING = new Panel29_STALL_WARNING();
			panel_STALL_WARNING.init(this);
			panel_STALL_WARNING.x = 657;
			panel_STALL_WARNING.y = 235;
			
			panel_AIR_COND = new Panel30_AIR_COND();
			panel_AIR_COND.init(this);
			panel_AIR_COND.x = 572;
			panel_AIR_COND.y = 235;
			
			panel_PRESSURISATION2 = new Panel31_PRESSURISATION2();
			panel_PRESSURISATION2.init(this);
			panel_PRESSURISATION2.x = 524;
			panel_PRESSURISATION2.y = 185;
			
			panel_PRESSURISATION3 = new Panel32_PRESSURISATION3();
			panel_PRESSURISATION3.init(this);
			panel_PRESSURISATION3.x = 525;
			panel_PRESSURISATION3.y = 215;
			
//			panel_CPT_RECALL = new Panel33_CPT_RECALL();
//			panel_CPT_RECALL.init(this);
//			panel_CPT_RECALL.x = 568;
//			panel_CPT_RECALL.y = 174;
			
			panel_MCP = new Panel34_MCP();
			panel_MCP.init(this);
			panel_MCP.x = 110;
			panel_MCP.y = 495;
			
//			panel_FO_RECALL = new Panel35_FO_RECALL();
//			panel_FO_RECALL.init(this);
//			panel_FO_RECALL.x = 849;
//			panel_FO_RECALL.y = 174;
			
			panel_CPT_DU = new Panel36_CPT_DU();
			panel_CPT_DU.init(this);
			panel_CPT_DU.x = 509;
			panel_CPT_DU.y = 185;
			
			panel_AUTOPILOT_TEST = new Panel37_AUTOPILOT_TEST();
			panel_AUTOPILOT_TEST.init(this);
			panel_AUTOPILOT_TEST.x = 617;
			panel_AUTOPILOT_TEST.y = 183;
			
			panel_N1_SPD_REF = new Panel38_N1_SPD_REF();
			panel_N1_SPD_REF.init(this);
			panel_N1_SPD_REF.x = 602;
			panel_N1_SPD_REF.y = 160;
			
			panel_FLAP_INDICATOR = new Panel39_FLAP_INDICATOR();
			panel_FLAP_INDICATOR.init(this);
			panel_FLAP_INDICATOR.x = 764;
			panel_FLAP_INDICATOR.y = 180;
			
			panel_LANDING_GEAR2 = new Panel40_LANDING_GEAR2();
			panel_LANDING_GEAR2.init(this);
			panel_LANDING_GEAR2.x = 647;
			panel_LANDING_GEAR2.y = 30;
			
			panel_BRAKE_PRESS = new Panel41_BRAKE_PRESS();
			panel_BRAKE_PRESS.init(this);
			panel_BRAKE_PRESS.x = 671;
			panel_BRAKE_PRESS.y = 180;
			
			panel_FO_DU = new Panel42_FO_DU();
			panel_FO_DU.init(this);
			panel_FO_DU.x = 694;
			panel_FO_DU.y = 180;
			
			panel_NOSE_WHEEL = new Panel43_NOSE_WHEEL();
			panel_NOSE_WHEEL.init(this);
			panel_NOSE_WHEEL.x = 550;
			panel_NOSE_WHEEL.y = 245;
			
			panel_SCREEN_SELECTORS = new Panel44_SCREEN_SELECTORS();
			panel_SCREEN_SELECTORS.init(this);
			panel_SCREEN_SELECTORS.x = 456;
			panel_SCREEN_SELECTORS.y = 250;
			
			panel_CPT_CDU = new Panel45_CPT_CDU();
			panel_CPT_CDU.init(this);
			panel_CPT_CDU.x = 480;
			panel_CPT_CDU.y = 102;
			
/*			panel46 = new Panel45();
			panel46.init(this);
			panel46.x = 540;
			panel46.y = 102;*/
			
			panel_GPWS = new Panel47_GPWS();
			panel_GPWS.init(this);
			panel_GPWS.x = 460;
			panel_GPWS.y = 258;
			
/*			panel48 = new Panel48();
			panel48.init(this);
			panel48.x = 541;
			panel48.y = 220;
			
			panel49 = new Panel49();
			panel49.init(this);
			panel49.x = 541;
			panel49.y = 220;  */
			
			panel_THRUST_LEVERS = new Panel50_THRUST_LEVERS();
			panel_THRUST_LEVERS.init(this);
			panel_THRUST_LEVERS.x = 541;
			panel_THRUST_LEVERS.y = 220;
			
/*			panel51 = new Panel51();
			panel51.init(this);
			panel51.x = 541;
			panel51.y = 220;
			
			panel52 = new Panel52();
			panel52.init(this);
			panel52.x = 541;
			panel52.y = 220; */
			
			panel_FIRE = new Panel53_FIRE();
			panel_FIRE.init(this);
			panel_FIRE.x = 328;
			panel_FIRE.y = 328;
			
			panel_COM = new Panel54_COM();
			panel_COM.init(this);
			panel_COM.x = 508;
			panel_COM.y = 218;
			
			panel_NAV = new Panel55_NAV();
			panel_NAV.init(this);
			panel_NAV.x = 531;
			panel_NAV.y = 136;
			
/*			panel56 = new Panel56();
			panel56.init(this);
			panel56.x = 541;
			panel56.y = 220;*/
			
			panel_LIGHTS2 = new Panel57_LIGHTS2();
			panel_LIGHTS2.init(this);
			panel_LIGHTS2.x = 585;
			panel_LIGHTS2.y = 425;
			
			panel_CARGO = new Panel58_CARGO();
			panel_CARGO.init(this);
			panel_CARGO.x = 634;
			panel_CARGO.y = 374;
			
			panel_WX_RADAR = new Panel59_WX_RADAR();
			panel_WX_RADAR.init(this);
			panel_WX_RADAR.x = 634;
			panel_WX_RADAR.y = 380;
			
			panel_SELCAL = new Panel60_SELCAL();
			panel_SELCAL.init(this);
			panel_SELCAL.x = 653;
			panel_SELCAL.y = 436;
			
			panel_XPNDR = new Panel61_XPNDR();
			panel_XPNDR.init(this);
			panel_XPNDR.x = 583;
			panel_XPNDR.y = 384;
			
/*			panel62 = new Panel62();
			panel62.init(this);
			panel62.x = 541;
			panel62.y = 220;*/
			
			panel_RUDDER_AND_AILERON = new Panel63_RUDDER_AND_AILERON();
			panel_RUDDER_AND_AILERON.init(this);
			panel_RUDDER_AND_AILERON.x = 465;
			panel_RUDDER_AND_AILERON.y = 175;
			
/*			panel64 = new Panel64
			panel64.init(this);
			panel64.x = 600;
			panel64.y = 218;
			
			panel65 = new Panel65();
			panel65.init(this);
			panel65.x = 614;
			panel65.y = 136;
			*/
			
			panel_STAB_TRIM = new Panel67_STAB_TRIM();
			panel_STAB_TRIM.init(this);
			panel_STAB_TRIM.x = 660;
			panel_STAB_TRIM.y = 417;
			
		}
		
		private function resetPanels():void {
			panel_RECALL.resetPanel();
			panel_ELT.resetPanel();
			panel_LE_DEVICES.resetPanel();
			panel_PSUE.resetPanel();
			panel_FLT_CONTROLS.resetPanel();
			panel_NAVS_AND_DISPLAYS.resetPanel();
			panel_FUEL.resetPanel();
			panel_IRS_SYSTEM_DISPLAY.resetPanel();
			panel_ELECTRICAL1.resetPanel();
			panel_ELECTRICAL2.resetPanel();
			panel_ELECTRICAL3.resetPanel();
			panel_APU.resetPanel();
			panel_SERVICE_INTERPHONE.resetPanel();
			panel_DOME_WHITE.resetPanel();
			panel_LIGHTS1.resetPanel();
			panel_EQUIP_COOLING.resetPanel();
			panel_EMERG_EXIT.resetPanel();
			panel_ENGINE_START.resetPanel();
			panel_AUDIO_SELECTOR1.resetPanel();
			panel_ENGINES1.resetPanel();
			panel_OXYGEN.resetPanel();
			panel_LANDING_GEAR1.resetPanel();
			panel_ANTI_ICE1.resetPanel();
			panel_ANTI_ICE2.resetPanel();
			panel_HYDRAULICS_DOORS.resetPanel();
			panel_CVR.resetPanel();
			panel_PRESSURISATION1.resetPanel();
			panel_FDR_MACH_TEST.resetPanel();
			panel_STALL_WARNING.resetPanel();
			panel_AIR_COND.resetPanel();
			panel_PRESSURISATION2.resetPanel();
			panel_PRESSURISATION3.resetPanel();
			panel_MCP.resetPanel();
			panel_CPT_DU.resetPanel();
			panel_AUTOPILOT_TEST.resetPanel();
			panel_N1_SPD_REF.resetPanel();
			panel_FLAP_INDICATOR.resetPanel();
			panel_LANDING_GEAR2.resetPanel();
			panel_BRAKE_PRESS.resetPanel();
			panel_FO_DU.resetPanel();
			panel_NOSE_WHEEL.resetPanel();
			panel_SCREEN_SELECTORS.resetPanel();
			panel_CPT_CDU.resetPanel();
			panel_GPWS.resetPanel();
			panel_THRUST_LEVERS.resetPanel();
			panel_FIRE.resetPanel();
			panel_COM.resetPanel();
			panel_NAV.resetPanel();
			panel_LIGHTS2.resetPanel();
			panel_CARGO.resetPanel();
			panel_WX_RADAR.resetPanel();
			panel_SELCAL.resetPanel();
			panel_XPNDR.resetPanel();
			panel_RUDDER_AND_AILERON.resetPanel();
			panel_STAB_TRIM.resetPanel();
			
			flightdeckPanelSet.resetFlightDeck();
			currentPanelID = "";
			closePanel();
		}
		
		private function resetScreens():void {
			screen_UDU_LDU.screenUDU.resetScreen();
			screen_UDU_LDU.screenLDU.resetScreen();
			screen_PFD_ND.screenHolder1.capt_PFD.resetScreen();
			screen_PFD_ND.screenHolder1.capt_ND.resetScreen();
			screen_PFD_ND.screenHolder1.fo_PFD.resetScreen();
			screen_PFD_ND.screenHolder1.fo_ND.resetScreen();
		}

		private function getPressTime(s:String):int {
			var ret:int = KEY_PRESS_TIME;
			if(s) {
				switch(s) {
					case "long":
						ret = 0;
						break;
					case "short":
						ret = 1;
						break;
					case "none":
						ret = 2;
						break;
				}
			}
			return ret;
		}
		
		private function removeObjChildren(obj:Object):void {
			while(obj.numChildren) {
            	obj.removeChildAt(0);
            }
		}
		
	}
}