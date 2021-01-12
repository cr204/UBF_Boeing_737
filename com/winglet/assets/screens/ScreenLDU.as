package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import com.winglet.operations.ScreenElementOperations;
	import com.greensock.TweenLite;
	
	public class ScreenLDU extends Sprite {
		private var ct:ColorTransform=new ColorTransform();
		private var currStateID:String;
		private var t1:String = "";
		private var sEOperations:ScreenElementOperations = new ScreenElementOperations();
		private var mainTL:*;
		
		public function ScreenLDU() {
			// constructor code
		}
		
		public function init(pObj:*):void {
			mainTL = pObj;
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
					case "eng1_n2_gauge":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng1_n2_gauge.setPointerPosition(Number(xmlObj.@value)) else eng1_n2_gauge.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng1_n2_gauge.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng2_n2_gauge":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng2_n2_gauge.setPointerPosition(Number(xmlObj.@value)) else eng2_n2_gauge.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng2_n2_gauge.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng1_oil_press":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng1_oil_press.setPointerPosition(Number(xmlObj.@value)) else eng1_oil_press.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng1_oil_press.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng2_oil_press":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng2_oil_press.setPointerPosition(Number(xmlObj.@value)) else eng2_oil_press.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng2_oil_press.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng1_oil_temp":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng1_oil_temp.setPointerPosition(Number(xmlObj.@value)) else eng1_oil_temp.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng1_oil_temp.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng2_oil_temp":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng2_oil_temp.setPointerPosition(Number(xmlObj.@value)) else eng2_oil_temp.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng1_oil_temp.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng1_vib":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng1_vib.setPointerPosition(Number(xmlObj.@value)) else eng1_vib.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng1_vib.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng2_vib":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng2_vib.setPointerPosition(Number(xmlObj.@value)) else eng2_vib.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng2_vib.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng1_oil_qty":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng1_oil_qty.setPointerPosition(Number(xmlObj.@value)) else eng1_oil_qty.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng1_oil_qty.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					case "eng2_oil_qty":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") eng2_oil_qty.setPointerPosition(Number(xmlObj.@value)) else eng2_oil_qty.updatePointerPosition(xmlObj);
						} 
						if(xmlObj.@property.toString()=="gaugeVelocityID") {
							if(currStateID!="default") {
								velocitiesObj1 = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								eng2_oil_qty.setVelocitiesArr(velocitiesObj1.velocitiesXML);
							}
						}
						break;
					
					case "blank_screen":
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
			//
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
