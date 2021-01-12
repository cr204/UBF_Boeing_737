package com.winglet.assets.screens {
	
	import flash.display.MovieClip;
	import com.winglet.operations.ScreenElementOperations;
	
	public class ScreenND extends MovieClip {
		private var currStateID:String;
		private var sEOperations:ScreenElementOperations = new ScreenElementOperations();
		private var mainTL:*;
		
		public function ScreenND() {
			// constructor code
			stop();
		}
		
		public function init(pObj:*):void {
			mainTL = pObj;
		}
		
		public function resetScreen():void {
			resetElements();
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
		
		private function setElementParameter(xmlObj:XML, isX:Boolean=false):void {
			
			if(String(xmlObj.localName())=="panel_element") {
				mainTL.completePanelOperationFromScreenXML(xmlObj);
			}
			
			if((String(xmlObj.localName())=="element" && !isX) || isX) {
			
				var eName = xmlObj.@name.toString();
				var velocitiesObj1:Object;
/*				switch(eName) {
					
					
					case "blank_screen":
						if(xmlObj.@property.toString()=="visible") {
							if(String(xmlObj.@value)=="false") blankScreen.visible=false else blankScreen.visible=true;
							if(xmlObj.@gotoFrame.toString()=="2") blankScreen.gotoAndStop(2) else blankScreen.gotoAndStop(1);
						}
						break;
					
					
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
				}*/
			}
		}
		
		private function resetElements():void {
			//
			this.gotoAndStop(1);
		}
		
	}
	
}