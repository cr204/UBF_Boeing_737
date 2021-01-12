// ScreenOperations.as 
package com.winglet.operations {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class ScreenOperations {
		private var parentObj:MovieClip;
		
		private var defaultScreenSystem:* = null;
		private var defaultScreenSystemName:String = "";
		private var currScreenSystem:* = null;
		private var currScreenSystemName:String = "";
		private var hasHiddenParallelOperation:Boolean = false;
		private var hasAdditionalState:Boolean = false;
		private var hiddenParallelScreenSystem:* = null;
		private var hiddenScreenSystemName:String = "";
		private var lastMainScreenSystem:* = null;
		private var lastMainScreenSystemName:String = "";
		private var objScreensArr:Array = [];
		public var inopScreenName:String = "";
		private var resXElementArr:Array = [];
		private var _xelementFound:Boolean = false;
		public var _hasStatus2:Boolean = false;
		private var myOTimer:Timer;
		
		private var mathIAS:Number;
		private var mathALT:Number;
		private var mathWIND:Number;
		private var mathTAS:Number;
		private var mathSAT:Number;
		private var mathMACH:Number;
		private var mathSOS:Number;
		public var mathSOSIAS:Number;
		private var mathGS:Number;
		private var mathB_POLE_IAS:Number;
		private var mathTAT:Number;
		private var myTween:TweenLite;
		private var ce:*;  // Conditional element
		private var cv:String; // Conditional element value
		private var hasConditionalParallel:Boolean;
		private var inopSS:int = 1;
		
		public function ScreenOperations() {
			//
		}
		
		public function init(param1):void {
			parentObj = param1;
		}
		
		public function screenObject(sObj:Object):void {
			trace("SO.screenObject: " + sObj.screenAnimationID);
			objScreensArr = sObj.screens;
			for (var i:int=0; i<objScreensArr.length; i++) {
				setScreenParameters(objScreensArr[i], sObj.screenAnimationID, sObj.screenAnimationType)
				reserverXElements(objScreensArr[i]);
			}
		}

		private function setScreenParameters(obj:Object, sID:String, sType:String):void {
			switch(obj.screenName) {
				case "UDU":
					parentObj.screen_UDU_LDU.screenUDU.setParameters(obj.elementsXML, sID);
					break;
				case "LDU":
					parentObj.screen_UDU_LDU.screenLDU.setParameters(obj.elementsXML, sID);
					break;
				case "CAPT_PFD":
					parentObj.screen_PFD_ND.screenHolder1.capt_PFD.setParameters(obj.elementsXML, sID);
					break;
				case "CAPT_ND":
					if(obj.gotoFrame!="") parentObj.screen_PFD_ND.screenHolder1.capt_ND.gotoAndStop(int(obj.gotoFrame));
					parentObj.screen_PFD_ND.screenHolder1.capt_ND.setParameters(obj.elementsXML, sID);
					break;
				case "FO_PFD":
					parentObj.screen_PFD_ND.screenHolder1.fo_PFD.setParameters(obj.elementsXML, sID);
					break;
				case "FO_ND":
					if(obj.gotoFrame!="") parentObj.screen_PFD_ND.screenHolder1.fo_ND.gotoAndStop(int(obj.gotoFrame));
					parentObj.screen_PFD_ND.screenHolder1.fo_ND.setParameters(obj.elementsXML, sID);
					break;
					
				default:
					trace("Error! Unkown screenName: " + obj.screenName + " in ScreenOperations.");
					break;
			}
		}
		
		public function completeXElementByID(s:String):void {
			var xeArr:Array = s.split(", ");
			_xelementFound = false;
			for(var j:int=0; j<xeArr.length; ++j) {
				trace("SO - completeXElementByID: " + xeArr[j]);

				for(var i:int=0; i<objScreensArr.length; i++) {
//					if(objScreensArr[i].screenSystem!="") {  // Removed jul 31, 2011. This allows to filter SD screens for xelement
//						trace("SO.elementsXML: " + objScreensArr[i].screenName + " - system: " + objScreensArr[i].screenSystem);
						var elXMLArr:Array = objScreensArr[i].elementsXML;
						for(var i1:int=0; i1<elXMLArr.length; ++i1) {
//							trace("elXMLArr[" + i1 + "].localName: " + elXMLArr[i1].localName());
							if(elXMLArr[i1].localName() == "xelement") {
//								trace("xeArr[" + j + "]: " + xeArr[j] + "       - elXMLArr[" + i1 + "].id: " + elXMLArr[i1].@id.toString());
								if(xeArr[j]==elXMLArr[i1].@id.toString()) {
//									trace("### element: " + elXMLArr[i1].@name.toString() + "  - prop: " + elXMLArr[i1].@property.toString());
									if(objScreensArr[i].screenSystem=="") objScreensArr[i].screenSystem=defaultScreenSystemName;
									setScreenXParameter(objScreensArr[i].screenName, objScreensArr[i].screenSystem, elXMLArr[i1]);
									_xelementFound = true;
								}
							}
						}
						// Searching xelement by ID from reserverXElement Array, if it is not found.
						if(!_xelementFound) checkXElementReserve(xeArr[j]);
//					}
				}
			}
			
		}
		
		private function setScreenXParameter(sName:String, sSystem:String, xElmXML:XML):void {
//			trace("setScreenXParameter(): sName:" + sName + "  sSystem: " + sSystem + "  xElmXML: " + xElmXML);
			switch(sName) {
				case "UDU":
					parentObj.screen_UDU_LDU.screenUDU.setXParameters(xElmXML);
					break;
				case "LDU":
					parentObj.screen_UDU_LDU.screenUDU.setXParameters(xElmXML);
					break;
				case "CAPT_PFD":
					parentObj.screen_PFD_ND.screenHolder1.capt_PFD.setXParameters(xElmXML);
					break;
				case "CAPT_ND":
					parentObj.screen_PFD_ND.screenHolder1.capt_ND.setXParameters(xElmXML);
					break;
				case "FO_PFD":
					parentObj.screen_PFD_ND.screenHolder1.fo_PFD.setXParameters(xElmXML);
					break;
				case "FO_ND":
					parentObj.screen_PFD_ND.screenHolder1.fo_ND.setXParameters(xElmXML);
					break;
					
				default:
					trace("Error! Unkown screenName: " + sName + " in ScreenOperations.");
					break;
			}
		}

		// **********************************************
		// ***  Operations on Screen defaults         ***
		
		public function setScreenDefaults():void {
			var objScreens:Array = parentObj.screenDefaults.getScreenDefaults();
			for (var i:int=0; i<objScreens.length; i++) {
				setScreenDefaultParameters(objScreens[i]);
			}
		}
		
		private function setScreenDefaultParameters(obj:Object):void {
			switch(obj.screenName) {
				case "UDU":
					parentObj.screen_UDU_LDU.screenUDU.setParameters(obj.elementsXML, "default");
					break;
				case "LDU":
					parentObj.screen_UDU_LDU.screenLDU.setParameters(obj.elementsXML, "default");
					break;
				case "CAPT_PFD":
					parentObj.screen_PFD_ND.screenHolder1.capt_PFD.setParameters(obj.elementsXML, "default");
					break;
				case "CAPT_ND":
					if(obj.gotoFrame!=undefined) {
						parentObj.screen_PFD_ND.screenHolder1.capt_ND.gotoAndStop(int(obj.gotoFrame)); 
					}
					parentObj.screen_PFD_ND.screenHolder1.capt_ND.setParameters(obj.elementsXML, "default");
					break;
				case "FO_PFD":
					parentObj.screen_PFD_ND.screenHolder1.fo_PFD.setParameters(obj.elementsXML, "default");
					break;
				case "FO_ND":
					if(obj.gotoFrame!=undefined) {
						parentObj.screen_PFD_ND.screenHolder1.fo_ND.gotoAndStop(int(obj.gotoFrame));
					}
					parentObj.screen_PFD_ND.screenHolder1.fo_ND.setParameters(obj.elementsXML, "default");
					break;
					
				default:
					trace("Error! Unkown screenName: " + obj.screenName + " in ScreenOperations - setScreenDefaultParameters() function!");
					break;
			}
		}
		
		public function configureInopScreen(sName:String, whiteLine:Boolean):void {
			//
			inopScreenName = sName;
		}
		
		public function checkIfParallelAnimations():void {
//			trace("## checkIfPA().hasHiddenParallelOperation: " + hasHiddenParallelOperation);
			if(hasHiddenParallelOperation) {
//				trace("hasHiddenParallelOperation: " + hasHiddenParallelOperation);
				parentObj.screen_UDU_LDU.sdBlankScreen.visible = true;
				parentObj.screen_UDU_LDU.sdBlankScreen.play();
				if(parentObj.screen_UDU_LDU.screenHolder.numChildren>0) parentObj.screen_UDU_LDU.screenHolder.removeChildAt(0);
				currScreenSystem = hiddenParallelScreenSystem;
				currScreenSystemName = hiddenScreenSystemName;
//				trace("currScreenSystem: " + currScreenSystem + " is added!");
				parentObj.screen_UDU_LDU.screenHolder.addChild(currScreenSystem);
			}
		}
		
		public function resetSDScreens():void {
			resXElementArr = new Array();
			
			configureInopScreen("none", false);
			
			defaultScreenSystem = null;
			defaultScreenSystemName = "";
			currScreenSystem = null;
			currScreenSystemName = "";
			hasHiddenParallelOperation = false;
			hasAdditionalState = false;
			hiddenParallelScreenSystem = null;
			hiddenScreenSystemName = "";
			lastMainScreenSystem = null;
			lastMainScreenSystemName = "";
			objScreensArr = new Array();
			inopScreenName = "";
			resXElementArr = new Array();
			_xelementFound = false;
			_hasStatus2 = false;
			
			inopSS = 1;
		}
		
		private function checkXElementReserve(xElmID:String):void {
			for(var i:int=0; i<resXElementArr.length; ++i) {
				var tempXEID:String = resXElementArr[i].xelementXML.@id.toString();
				if(xElmID==tempXEID) {
					
					setScreenXParameter(resXElementArr[i].screenName, resXElementArr[i].screenSystem, resXElementArr[i].xelementXML);
				}
			}
		}
		
		private function reserverXElements(obj:Object):void {
			var elmArr:Array = obj.elementsXML;
			for (var i:int=0; i<elmArr.length; ++i) {
				 if(elmArr[i].localName()=="xelement") {
					 var sSys:String = obj.screenSystem;
					 if(sSys=="") sSys=obj.defaultSystem;
					 if(sSys=="") sSys=defaultScreenSystemName;
					 var resXEObject:Object = {
						 				screenName: obj.screenName,
						 				screenSystem: sSys,
										xelementXML: elmArr[i]
									 }
					resXElementArr.push(resXEObject) ;
//					 trace("# xelement.id: " + elmArr[i].@id + "  - prop: " + elmArr[i].@property.toString());
				 }
			}
		}
		
	}
	
}