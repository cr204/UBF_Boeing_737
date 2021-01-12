package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import com.winglet.operations.ScreenElementOperations;
	import com.greensock.TweenLite;
	
	public class ScreenUDU extends Sprite {
		private var ct:ColorTransform=new ColorTransform();
		private var currStateID:String;
		private var t1:String = "";
		private var sEOperations:ScreenElementOperations = new ScreenElementOperations();
		private var mainTL:*;
		
		public function ScreenUDU() {
			// constructor code
		}
		
		public function init(pObj:*):void {
			mainTL = pObj;
			//n1_gauge.setPointerPosition(60);
		}
		
		public function resetScreen():void {
			resetScreenElements();
		}
		
		public function setParameters(pArr:Array, sID:String) {
			currStateID = sID;

			for (var i:int=0; i<pArr.length; ++i) {
				setElementParameter(pArr[i]);
			}
		}
		
		public function setXParameters(eXML:XML) {
			setElementParameter(eXML, true);
		}
		
		public function completeXElementByID(s:String):void {
			mainTL.screenOperations.completeXElementByID(s);
		}

		private function setElementParameter(xmlObj:XML, isX:Boolean=false):void {
			var innerMC:*;
			
			if(String(xmlObj.localName())=="panel_element") {
				mainTL.completePanelOperationFromScreenXML(xmlObj);
			}
			
			if((String(xmlObj.localName())=="element" && !isX) || isX) {
			
				var eName = xmlObj.@name.toString();
				var velocitiesObj1:Object;
				switch(eName) {
					case "eng1_n1_gauge":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng1_n1_gauge.setPointerPosition(Number(xmlObj.@value)) else eng1_n1_gauge.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng1_n1_gauge.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng2_n1_gauge":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng2_n1_gauge.setPointerPosition(Number(xmlObj.@value)) else eng2_n1_gauge.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng2_n1_gauge.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng1_egt_gauge":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng1_egt_gauge.setPointerPosition(Number(xmlObj.@value)) else eng1_egt_gauge.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng1_egt_gauge.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng2_egt_gauge":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng2_egt_gauge.setPointerPosition(Number(xmlObj.@value)) else eng2_egt_gauge.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng2_egt_gauge.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng1_fuel_gauge":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng1_fuel_gauge.setPointerPosition(Number(xmlObj.@value)) else eng1_fuel_gauge.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng1_fuel_gauge.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						if(xmlObj.@color.toString()!="") {
							eng1_fuel_gauge.updateColor(xmlObj.@color.toString());
						}
						break;
					case "eng2_fuel_gauge":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng2_fuel_gauge.setPointerPosition(Number(xmlObj.@value)) else eng2_fuel_gauge.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng2_fuel_gauge.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						if(xmlObj.@color.toString()!="") {
							eng2_fuel_gauge.updateColor(xmlObj.@color.toString());
						}
						break;
					case "fuel_gauge":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") fuel_gauge.setPointerPosition(Number(xmlObj.@value)) else fuel_gauge.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								fuel_gauge.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						if(xmlObj.@color.toString()!="") {
							fuel_gauge.updateColor(xmlObj.@color.toString());
						}
						break;
					case "eng1_start_valve_open":
						if(xmlObj.@property.toString()=="visible") {
							innerMC = this.getChildByName(eName);
							if(currStateID=="default") {
								sEOperations.completeOperation(innerMC, xmlObj);
							} else innerMC.showState(Boolean(xmlObj.@value));
						}
						break;
					case "eng2_start_valve_open":
						if(xmlObj.@property.toString()=="visible") {
							innerMC = this.getChildByName(eName);
							if(currStateID=="default") {
								sEOperations.completeOperation(innerMC, xmlObj);
							} else innerMC.showState(Boolean(xmlObj.@value));
						}
						break;
					case "eng1_oil_filter_bypass":
						if(xmlObj.@property.toString()=="visible") {
							innerMC = this.getChildByName(eName);
							if(currStateID=="default") {
								sEOperations.completeOperation(innerMC, xmlObj);
							} else innerMC.showState(Boolean(xmlObj.@value));
						}
						break;
					case "eng2_oil_filter_bypass":
						if(xmlObj.@property.toString()=="visible") {
							innerMC = this.getChildByName(eName);
							if(currStateID=="default") {
								sEOperations.completeOperation(innerMC, xmlObj);
							} else innerMC.showState(Boolean(xmlObj.@value));
						}
						break;
					case "eng1_low_oil_pressure":
						if(xmlObj.@property.toString()=="visible") {
							innerMC = this.getChildByName(eName);
							if(currStateID=="default") {
								sEOperations.completeOperation(innerMC, xmlObj);
							} else innerMC.showState(Boolean(xmlObj.@value));
						}
						break;
					case "eng2_low_oil_pressure":
						if(xmlObj.@property.toString()=="visible") {
							innerMC = this.getChildByName(eName);
							if(currStateID=="default") {
								sEOperations.completeOperation(innerMC, xmlObj);
							} else innerMC.showState(Boolean(xmlObj.@value));
						}
						break;
						
						
						
						
/*					case "blank_screen":
						if(xmlObj.@property.toString()=="visible") {
							if(String(xmlObj.@value)=="false") {
								screen_blank.visible=false;
								screen_blank.gotoAndStop(1);
							} else {
								screen_blank.visible=true;
								if(xmlObj.@gotoFrame.toString()=="2") screen_blank.gotoAndStop(26) else screen_blank.gotoAndStop(25);
							}
						}
						break;
*/
					default:
						var tempMC:*;
						for(var i:int=0; i<this.numChildren; ++i) {
							if(eName==this.getChildAt(i).name) {
							tempMC = this.getChildAt(i);
							}
						}
						if(tempMC!=undefined) {
							sEOperations.completeOperation(tempMC, xmlObj);
						} else {
							trace("Error! Unknown element name: " + eName + " in ScreenEWD.as")
						} 
						break;
				}
			} 
		}
		
		private function resetScreenElements():void {
			eng1_rev.visible=true;
			eng1_rev.gotoAndStop(1);
			eng2_rev.visible=true;
			eng2_rev.gotoAndStop(1);
			eng1_tai.visible=true;
			eng2_tai.visible=true;
			eng1_start_valve_open.visible = true;
			eng2_start_valve_open.visible = true;
			eng1_oil_filter_bypass.visible = true;
			eng2_oil_filter_bypass.visible = true;
			eng1_low_oil_pressure.visible = true;
			eng2_low_oil_pressure.visible = true;
			
			eng1_n1_gauge.resetAsset();
			eng2_n1_gauge.resetAsset();
			eng1_egt_gauge.resetAsset();
			eng2_egt_gauge.resetAsset();
			fuel_gauge.resetAsset();
			eng1_fuel_gauge.resetAsset();
			eng2_fuel_gauge.resetAsset();
		}

		private function tintClip(obj:*, c:uint):void {
			
			var color:uint=c; //picker.selectedColor;
			var mul:Number=1; //slider.value/100;
			var ctMul:Number=(1-mul);
			var ctRedOff:Number=Math.round(mul*extractRed(color));
			var ctGreenOff:Number=Math.round(mul*extractGreen(color));
			var ctBlueOff:Number=Math.round(mul*extractBlue(color));
			ct=new ColorTransform(ctMul,ctMul,ctMul,1,ctRedOff,ctGreenOff,ctBlueOff,0);
			obj.transform.colorTransform=ct;
		}
		
		
		private function extractRed(c:uint):uint {
			return (( c >> 16 ) & 0xFF);
		}
		
		private function extractGreen(c:uint):uint {
			return ( (c >> 8) & 0xFF );
		}
		
		private function extractBlue(c:uint):uint {
			return ( c & 0xFF );
		}
	}
	
}
