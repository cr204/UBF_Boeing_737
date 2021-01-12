package com.winglet.assets {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.events.PanelSelectedEvent;
	import com.winglet.assets.buttons.PanelButton;
	
	public class FlightDeckPanelSet extends Sprite {
		private var currSelectedPanel:*;
		
		public function FlightDeckPanelSet() {
			// constructor code
			enableButtons();

			for(var i:uint=1; i<68; i++) {
				var tmpP = this.getChildByName("panel_" + i);
				if(tmpP) tmpP.addEventListener(MouseEvent.MOUSE_DOWN, onPanelClicked);
			}
			
			initPanelButtons();
			initScreens();
			screen_UDULDU.active = true;
			pName.visible = false;
		}
		
		public function hideActivePanel():void {
			trace("hideActivePanel! " + currSelectedPanel);
			//currSelectedPanel.isSelected = false;
			//currSelectedPanel.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
			//currSelectedPanel = undefined;
		}
		
		public function disableButtons():void {
			if(currSelectedPanel!=undefined) {
				dispatchEvent(new PanelSelectedEvent(currSelectedPanel.name));
				currSelectedPanel = undefined;
			}
			hiddenCover.visible = true;
			this.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveFlightdeck);
		}
		
		public function enableButtons():void {
			hiddenCover.visible = false;
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveFlightdeck);
		}
		
		public function hightlightFlightdeckPanel(s:String):void {
			resetPanelButtons();
			var panelsArr:Array = s.split(",");
			for each (var st:String in panelsArr) {
				trace("FDPS.panelsArr: " + st);
				var panel:PanelButton = getPanelButton(st);
				panel.highlighted = true ;
			}
		}
		
		private function getPanelButton(s:String):PanelButton {
			var ret:PanelButton;
			s = trimWhitespace(s);
			switch(s) {
				case "elt":
					ret = panel_1;
					break;
				case "le_devices":
					ret = panel_2;
					break;
				case "psue":
					ret = panel_3;
					break;
				case "flt_controls":
					ret = panel_4;
					break;
				case "navs_and_displays":
					ret = panel_5;
					break;
				case "fuel":
					ret = panel_6;
					break;
				case "irs_system_display":
					ret = panel_7;
					break;
				case "electrical1":
					ret = panel_9;
					break;
				case "electrical2":
					ret = panel_10;
					break;
				case "electrical3":
					ret = panel_11;
					break;
				case "apu":
					ret = panel_12;
					break;
				case "service_interphone":
					ret = panel_13;
					break;
				case "dome_white":
					ret = panel_14;
					break;
				case "lights1":
					ret = panel_15;
					break;
				case "equip_cooling":
					ret = panel_16;
					break;
				case "emerg_exit":
					ret = panel_17;
					break;
				case "engine_start":
					ret = panel_18;
					break;
				case "audio_selector1":
					ret = panel_19;
					break;
				case "engines":
					ret = panel_20;
					break;
				case "oxygen":
					ret = panel_21;
					break;
				case "landing_gear1":
					ret = panel_22;
					break;
				case "anti_ice1":
					ret = panel_23;
					break;
				case "anti_ice2":
					ret = panel_24;
					break;
				case "hydraulics_doors":
					ret = panel_25;
					break;
				case "cvr":
					ret = panel_26;
					break;
				case "pressurisation1":
					ret = panel_27;
					break;
				case "fdr_mach_test":
					ret = panel_28;
					break;
				case "stall_warning":
					ret = panel_29;
					break;
				case "air_cond":
					ret = panel_30;
					break;
				case "pressurisation2":
					ret = panel_31;
					break;
				case "pressurisation3":
					ret = panel_32;
					break;
				case "cpt_recall":
					ret = panel_33;
					break;
				case "mcp":
					ret = panel_34;
					break;
				case "fo_recall":
					ret = panel_35;
					break;
				case "cpt_du":
					ret = panel_36;
					break;
				case "autopilot_test":
					ret = panel_37;
					break;
				case "n1_spd_ref":
					ret = panel_38;
					break;
				case "flap_indicator":
					ret = panel_39;
					break;
				case "landing_gear2":
					ret = panel_40;
					break;
				case "brake_press":
					ret = panel_41;
					break;
				case "fo_du":
					ret = panel_42;
					break;
				case "nose_wheel":
					ret = panel_43;
					break;
				case "screen_selectors":
					ret = panel_44;
					break;
				case "cpt_cdu":
					ret = panel_45;
					break;
				case "fo_cdu":
					ret = panel_46;
					break;
				case "gpws":
					ret = panel_47;
					break;
				case "tl":
					ret = panel_50;
					break;
				case "fire":
					ret = panel_53;
					break;
				case "com":
					ret = panel_54;
					break;
				case "nav":
					ret = panel_55;
					break;
				case "lights2":
					ret = panel_57;
					break;
				case "cargo":
					ret = panel_58;
					break;
				case "wx_radar":
					ret = panel_59;
					break;
				case "selcal":
					ret = panel_60;
					break;
				case "xpndr":
					ret = panel_61;
					break;
				case "rudder_and_aileron":
					ret = panel_63;
					break;
				case "stab_trim":
					ret = panel_67;
					break;
				case "none":
					ret = new PanelButton();
					break;
				default:
					trace("Error in PanelOperations, getPanel() function. Unknown panel instance name: " + s);
					break;
					
					
					
					
			}
			return ret;
		}
				
		public function resetFlightDeck():void {
			currSelectedPanel = undefined;
		}
		
		private function onPanelClicked(e:MouseEvent):void {
			var targetPanel = e.target;
			if(currSelectedPanel!=targetPanel) {
				if(currSelectedPanel!=undefined) {
								currSelectedPanel.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
				}
				currSelectedPanel = targetPanel;
			} else {
				currSelectedPanel = undefined;
			}
			dispatchEvent(new PanelSelectedEvent(targetPanel.name));
		}
		
		private function resetPanelButtons():void {
			for(var i:int=1; i<68; ++i) {
				var p:PanelButton = this.getChildByName("panel_" + i.toString()) as PanelButton;
				p.highlighted = false;
			}
			
		}
		
		private function initPanelButtons():void {
			for(var i:int=1; i<68; ++i) {
				var p:PanelButton = this.getChildByName("panel_" + i.toString()) as PanelButton;
				p.init();
			}
		}

		private function initScreens():void {
			screen_UDULDU.addEventListener(MouseEvent.MOUSE_DOWN, onScreenSelected);
			screen_CAPT.addEventListener(MouseEvent.MOUSE_DOWN, onScreenSelected);
			screen_FO.addEventListener(MouseEvent.MOUSE_DOWN, onScreenSelected);
		}

		private function onScreenSelected(e:MouseEvent):void {
			var targetScreen = e.target;
			var parentObj = parent;
			
			switch(targetScreen.name) {
				case "screen_UDULDU":
					parentObj.screen_UDU_LDU.visible = true;
					parentObj.screen_PFD_ND.visible = false;
					screen_CAPT.active = false;
					screen_UDULDU.active = true;
					screen_FO.active = false;
					break;
				case "screen_CAPT":
					parentObj.screen_UDU_LDU.visible = false;
					parentObj.screen_PFD_ND.visible = true;
					//parentObj.screen_PFD_ND.switchScreenTo("capt");
					parentObj.screen_PFD_ND.screenHolder1.y = 30;
					screen_CAPT.active = true;
					screen_UDULDU.active = false;
					screen_FO.active = false;
					break;
				case "screen_FO":
					parentObj.screen_UDU_LDU.visible = false;
					parentObj.screen_PFD_ND.visible = true;
					parentObj.screen_PFD_ND.screenHolder1.y = -314;
					screen_CAPT.active = false;
					screen_UDULDU.active = false;
					screen_FO.active = true;
					break;
			}
		}
		
		
		private function onMouseMoveFlightdeck(e:MouseEvent):void {
			pName.x = this.mouseX - 112;
			pName.y = this.mouseY - 32;
			var pt:String = getPanelName(e.target.name);
			pName.setText(pt);
			if(pt=="") pName.visible=false else pName.visible=true;
		}
		
		
		// getPanelName
		private function getPanelName(s:String):String {
			var ret:String = "PANEL";
			
			switch(s) {
				case "panel_1":
					ret = "ELT";
					break;
				case "panel_2":
					ret = "LE DEVICES";
					break;
				case "panel_3":
					ret = "PSEU";
					break;
				case "panel_4":
					ret = "FLT CONTROL";
					break;
				case "panel_5":
					ret = "NAV & DISP";
					break;
				case "panel_6":
					ret = "FUEL";
					break;
				case "panel_7":
					ret = "IRS";
					break;
				case "panel_9":
					ret = "ELEC";
					break;
				case "panel_10":
					ret = "EMERG ELEC";
					break;
				case "panel_11":
					ret = "ELEC";
					break;
				case "panel_12":
					ret = "APU";
					break;
				case "panel_13":
					ret = "SERV INT";
					break;
				case "panel_14":
					ret = "DOME WHITE";
					break;
				case "panel_15":
					ret = "LIGHTS";
					break;
				case "panel_16":
					ret = "EQUIP COOLING";
					break;
				case "panel_17":
					ret = "EMERG EXIT";
					break;
				case "panel_18":
					ret = "ENGINE START";
					break;
				case "panel_19":
					ret = "AUDIO SELECTOR";
					break;
				case "panel_20":
					ret = "ENGINES";
					break;
				case "panel_21":
					ret = "OXYGEN";
					break;
				case "panel_22":
					ret = "LANDING GEAR";
					break;
				case "panel_23":
					ret = "ANTI ICE 1";
					break;
				case "panel_24":
					ret = "ANTI ICE 2";
					break;
				case "panel_25":
					ret = "HYDRAULICS DOORS";
					break;
				case "panel_26":
					ret = "CVR";
					break;
				case "panel_27":
					ret = "PRESURIZACION";
					break;
				case "panel_28":
					ret = "FDR MACH TEST";
					break;
				case "panel_29":
					ret = "STALL WARNING";
					break;
				case "panel_30":
					ret = "AIR COND";
					break;
				case "panel_31":
					ret = "PRESURIZACION 2";
					break;
				case "panel_32":
					ret = "PRESURIZACION 3";
					break;
				case "panel_33":
					ret = "CAPT RECALL";
					break;
				case "panel_34":
					ret = "MCP";
					break;
				case "panel_35":
					ret = "FO RECALL";
					break;
				case "panel_36":
					ret = "CPT DU";
					break;
				case "panel_37":
					ret = "AUTOPILOT TEST";
					break;
				case "panel_38":
					ret = "N1 SPD REF";
					break;
				case "panel_39":
					ret = "FLAP INDICATOR";
					break;
				case "panel_40":
					ret = "ING GEAR";
					break;
				case "panel_41":
					ret = "BRAKE PRESS";
					break;
				case "panel_42":
					ret = "FO DU";
					break;
				case "panel_43":
					ret = "NOSE WHEEL";
					break;
				case "panel_44":
					ret = "SCREEN SELECTORS";
					break;
				case "panel_45":
					ret = "CAPT CDU";
					break;
				case "panel_46":
					ret = "FO CDU";
					break;
				case "panel_47":
					ret = "GPWS";
					break;
					
				case "panel_50":
					ret = "THRUST LEVERS";
					break;					
					
					
				case "panel_53":
					ret = "FIRE";
					break;
				case "panel_54":
					ret = "COM";
					break;
				case "panel_55":
					ret = "NAV";
					break;
				case "panel_57":
					ret = "LIGHTS";
					break;
				case "panel_58":
					ret = "CARGO";
					break;
				case "panel_59":
					ret = "WX RADAR";
					break;
				case "panel_60":
					ret = "SELCAL";
					break;
				case "panel_61":
					ret = "XPNDR";
					break;
				case "panel_63":
					ret = "RUDDER";
					break;
				case "panel_64":
					ret = "COM";
					break;
				case "panel_65":
					ret = "NAV";
					break;
				case "panel_67":
					ret = "STAB TRIM";
					break;
				
				default:
					ret = "";
					break;
			}
			
			return ret;
		}
		
		private function trimWhitespace($string:String):String {
			if ($string == null) return "";
			return $string.replace(/^\s+|\s+$/g, "");
		}
		
	}
	
}