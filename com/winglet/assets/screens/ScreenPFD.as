package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import fl.motion.easing.*
	import com.winglet.operations.ScreenElementOperations;
	
	public class ScreenPFD extends Sprite {
		private var currStateID:String;
		private var t1:String = "";
		private var sEOperations:ScreenElementOperations = new ScreenElementOperations();
		private var mainTL:*;
		
		public function ScreenPFD() {
			// constructor code
		}
		
		public function init(pObj:*):void {
			mainTL = pObj;
			alt.visible = false;
			dspl_source.visible = false;
			spd_lim.visible = false;
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
				var velocitiesObj:Object;
				var nextYPos:Number

				switch(eName) {
					case "altimeter_tape":
						if(xmlObj.@property.toString()=="altPosition") {
							if(currStateID=="default") altimeter_tape.setAltPosition(Number(xmlObj.@value.toString())) else altimeter_tape.updateAltPosition(xmlObj);
						}
						if(xmlObj.@property.toString()=="altVelocityID") {
							if(currStateID!="default") {
								velocitiesObj = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								altimeter_tape.setVelocitiesArr(velocitiesObj.velocitiesXML);
							}
						}
						break;
					case "vsi":
						if(xmlObj.@property.toString()=="pointerPosition") {
							vsi.setPointerPosition(xmlObj);
						}
						if(xmlObj.@property.toString()=="altVelocityID") {
							if(currStateID!="default") {
								velocitiesObj = mainTL.getVelocitiesByID(xmlObj.@value.toString());
								vsi.setVelocitiesArr(velocitiesObj.velocitiesXML);
							}
						}
						break;
						
					case "speed_bug":
						innerMC = speed_tape.speed_bug;
						if(xmlObj.@property.toString()=="gotoFrame") {
							innerMC.gotoAndStop(int(xmlObj.@value));
						}
						if(xmlObj.@property.toString()=="iasPosition") {
							speed_tape.setBugPosition(xmlObj);
						}
						if(xmlObj.@property.toString()=="visible") {
							if(String(xmlObj.@value)=="false") innerMC.visible=false else innerMC.visible=true;
						}
						break;
					
					case "speed_tape":
						if(xmlObj.@property.toString()=="iasPosition") {
							if(currStateID=="default") speed_tape.setSpeedPosition(Number(xmlObj.@value.toString())) else speed_tape.updateSpeedPosition(xmlObj);
						}
						
						// for COMPLEX animation! We don't need COMPLEX animation type for speed_tape.
						if(xmlObj.@property.toString()=="iasVelocityID") {
							if(currStateID!="default") {
//								var velocitiesObj:Object;
//								velocitiesObj = mainTL.getVelocitiesByID(xmlObj.@value.toString());
//								N1_gauge.setVelocitiesArr(velocitiesObj.velocitiesXML);
							}
						}
						break;
					
					case "ah":
						if(xmlObj.@property.toString()=="visible") {
							if(String(xmlObj.@value)=="false") ah.visible=false else ah.visible=true;
						}
						if(xmlObj.@property.toString()=="position") {
							ah.setAHPositionY(Number(xmlObj.@value), Number(xmlObj.@time));
						}
						break;
					case "fd_pitch_bar":
						if(xmlObj.@property.toString()=="visible") {
							if(String(xmlObj.@value)=="false") fd_bar.fd_pitch_bar.visible=false else fd_bar.fd_pitch_bar.visible=true;
						}
						if(xmlObj.@property.toString()=="position") {
							fd_bar.setPitchPosition(Number(xmlObj.@value), Number(xmlObj.@time));
						}
						break;
					case "fd_roll_bar":
						if(xmlObj.@property.toString()=="visible") {
							if(String(xmlObj.@value)=="false") fd_bar.fd_roll_bar.visible=false else fd_bar.fd_roll_bar.visible=true;
						}
						if(xmlObj.@property.toString()=="position") {
							fd_bar.setRollPosition(Number(xmlObj.@value), Number(xmlObj.@time));
						}
						break;
					case "compass":
						if(xmlObj.@property.toString()=="pointerPosition") {
							if(currStateID=="default") compass.setPointerPosition(Number(xmlObj.@value)) else compass.updatePointerPosition(xmlObj)
						}
						break;
						
/*					case "alpha_max":
						innerMC = speed_tape.alpha_max;
						if(xmlObj.@property.toString()=="visible") {
							if(String(xmlObj.@value)=="false") innerMC.visible=false else innerMC.visible=true;
						}
						if(xmlObj.@property.toString()=="iasPosition") {
							nextYPos = getPosY(Number(xmlObj.@value));
							if(currStateID=="default") innerMC.y = nextYPos else {
								TweenLite.to(innerMC, Number(xmlObj.@time), {y:nextYPos, delay:Number(xmlObj.@wait), overwrite:false, ease:String(xmlObj.@ease)});
							}
						}
						break;
						
					case "blank_screen":
						if(xmlObj.@property.toString()=="visible") {
							if(String(xmlObj.@value)=="false") blankScreen.visible=false else blankScreen.visible=true;
						}
						if(xmlObj.@gotoFrame.toString()=="2") blankScreen.gotoAndStop(2) else blankScreen.gotoAndStop(1);
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
							trace("Error! Unknown element name: " + eName + " in ScreenPFD.as")
						} 
						break;
				}
			}
		}
		
		private function resetScreenElements():void {
			alt.visible = false;
			dspl_source.visible = false;
			spd_lim.visible = false;
		}
		
		
		
		private function getIAS_Y(n:Number):Number {
			if(n<20) n=20;
			var ret:Number = -661;
			ret = n * 1.79 + ret;
			return ret;
		}
		
		
		
		
		
		

	}
}