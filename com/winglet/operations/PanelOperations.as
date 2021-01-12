package com.winglet.operations {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import com.winglet.assets.panels.PanelBase;
	import com.winglet.assets.panels.Panel00_RECALL;
	import flash.media.SoundChannel;
	import flash.media.Sound;
	
	public class PanelOperations {
		private var parentObj:MovieClip;
		private var channel:SoundChannel = new SoundChannel();
		private var sound1:Sound;
		
		public function PanelOperations() {
			//
		}
		
		public function init(param1):void {
			parentObj = param1;
		}
		
		public function reset():void {
			TweenLite.killTweensOf(this);
		}
		
		public function updateElementState(eObj:Object):void {
//			trace("-------------------");
//			trace("updateElementState:");
//			trace("panel: " + eObj.panel);
//			trace("name: " + eObj.name);
//			trace("status: " + eObj.status);
//			trace("fault: " + eObj.fault);
			
			
			
			if(eObj.panel==undefined) {
				// We use specific class(sound) instead of panel
				if(eObj.sound) {
					switch(eObj.status) {
						case "on":
							sound1 = new AltetudeHorn();
							channel = sound1.play(0,99);
							break;
						case "off":
							channel.stop();
							break;
					}
				}
				
			} else {
			
				var currPanel:PanelBase = getPanel(eObj.panel);
				var currElement:*;
			
				if(eObj.panel=="recall" && eObj.name!="fire_warn" && eObj.name!="master_caut" && eObj.name!="capt_recall" && eObj.name!="fo_recall") {
//				trace("##!!## " + eObj.name + "  --> " + currPanel);
					currElement = currPanel.getRecallLight(eObj.name);
				} else {
					var elementHolder = currPanel.getChildByName("elementHolder");
					currElement = elementHolder.getChildByName(eObj.name);
				}
			
			
				for(var key:String in eObj) {
					if(key!="panel" && key!="name") {
						switch(key) {
							case "status":
								updateElement(currElement, eObj.status);
								break;
							case "alert":
								currElement.useAlert(int(eObj[key]));
								break;
							case "fault":
								updateElement04(currElement, eObj.fault);
								break;
							case "fire":
								updateElement(currElement, eObj.fire);
								break;
							case "visible":
								updateElementVisiblity(currElement, eObj[key]);
								break;
							case "value":
								//currElement.setValue(Number(eObj[key]));
								currElement.setXMLObject(eObj);
								break;
							case "light":
								currElement.changeTopText(eObj.light);
								break;
							case "text":
								currElement.text = eObj.text;
								break;
						}
					}
				}
			}
		}
		
		private function updateElementVisiblity(elm:*, sta:String):void {
			if(sta=="false") {
				elm.visible = false;
			} else if(sta=="true") {
				elm.visible = true;
			}
		}
		
		public function updateElementState1(xmlObj:XML):void {
			var wt:Number = Number(xmlObj.@wait);
			TweenLite.to(this, 0, {delay:wt, overwrite:false, onComplete:updateElementState1b, onCompleteParams:[xmlObj]})

		}
		
		// This function is also used for <panel_element> in default xml!
		private function updateElementState1b(xmlObj:XML):void {
			var currPanel:PanelBase = getPanel(xmlObj.@panel.toString());
			var elementHolder = currPanel.getChildByName("elementHolder");
			var currElement:*;
			
			var showNumberString:String = new String();
			
			var j:int=-1;
			var i:int=0;
			
			currElement = elementHolder.getChildByName(xmlObj.@name.toString());
			
			if(currElement) {
				// property tag.
				if(xmlObj.@property.toString()!="") {
					//trace("updateElementState1.xmlObj.@property: " + xmlObj.@property.toString());
					var attProperty:String = xmlObj.@property.toString();
					switch(attProperty) {
						case "gotoFrame":
							currElement.gotoAndStop(int(xmlObj.@value));
							break;
						case "visible":
							if(xmlObj.@value.toString()=="false") currElement.visible=false else currElement.visible=true;
							break;
						case "gaugeVelocityID":
							var velocitiesObj1:Object = parentObj.getVelocitiesByID(xmlObj.@value.toString());
							//trace("velocitiesObj1: " + velocitiesObj1.velocitiesXML);
							currElement.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							break;
						default:
							trace("Error! Unknow <panel_element> property: " + attProperty + " in PanelOperations.as - updateElementState1()");
							break;
					}
				}
				
				// status tag.
				if(xmlObj.@status.toString()!="") {
					updateElement(currElement, xmlObj.@status.toString());
				}
				
				// fault tag.
				if(xmlObj.@fault.toString()!="") {
					updateElement04(currElement, xmlObj.@fault.toString());
				}
				
				// fire tag.
				if(xmlObj.@fire.toString()!="") {
					updateElement(currElement, xmlObj.@fire.toString());
				}
				
				// text tag.
				if(xmlObj.@text.toString()!="") {
					currElement.text = xmlObj.@text.toString();
				}
				
				// value tag.
				if(xmlObj.@value.toString()!="" && xmlObj.@property.toString()!="gaugeVelocityID") {
					var eObj:Object = covertToXMLObject(xmlObj);
					currElement.setXMLObject(eObj);
				}
				
			} else {
				trace("Error: Unknow element name: " + xmlObj.@name.toString() + " in PO.updateElementState1b()!")
			}
		}
		
		
		private function covertToXMLObject(xml:XML):Object {
			var retObject:Object = new Object();
				var attNamesList:XMLList = xml.@*;
				for (var i:int=0; i<attNamesList.length(); i++) {
//					trace("PO." + attNamesList[i].name() + ": " + attNamesList[i].toString());
					retObject[String(attNamesList[i].name())] = attNamesList[i].toString();
				}
			return retObject;
		}
		
		
		
		private function updateElement(elm:*, sta:String):void {
		
			if(elm.name=="tl1" || elm.name=="tl2" || elm.name=="tl_both") {
				elm.updatePosition(sta);
			} else {
				switch(sta) {
					case "off":
						elm.showState(0);
						if(elm.name=="gear_lever") elm.showState(sta);
						break;
					case "on":
						elm.showState(1);
						break;
					case "dim":
						elm.showState(2);
						break;
					case "full":
						elm.defaultPosition = 4;
						break;
					case "up":
						if(elm.name=="gear_lever") elm.showState(sta);
						break;
					case "down":
						if(elm.name=="gear_lever") elm.showState(sta);
						break;
					case "idle":
						elm.defaultPosition(sta);
						break;
					case "cutoff":
						elm.defaultPosition(sta);
						break;
					
					default:
						elm.defaultPosition = int(sta);
						break;
				}
			}
		}
		
		private function updateElement04(elm:*, sta:String):void {
//			trace("updateElement04 - elm: " + elm.name + "   sta: " + sta);
			switch(sta) {
				case "0":
					elm.changeTopText(0);
					break;
				case "1":
					elm.changeTopText(1);
					break;
			}
		}

		// from KEY object
		public function switchElementState(elm:*, sta:String):void {
//			trace("PanelOperations.switchElementState: " + elm + " - " + sta);
			switch(sta) {
				case "on":
					elm.switchState(1);
					break;
				case "off":
					if(elm=="gear_lever") elm.showState(sta);
					elm.switchState(0);
					break;
			}
		}

		private function getPanel(s:String):PanelBase {
			trace("PO.s: " + s);
			
			var ret:PanelBase;
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
					trace("Error in PanelOperations, getPanel() function. Unknown panel instance name: " + s);
					break;
			}
			
			return ret;
		}
		
	}
}