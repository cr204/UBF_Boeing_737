package com.winglet {
	import flash.xml.XMLDocument;
	
	public class StateObject extends XMLDocument {
		private var XMLValue:XML;
	
		public function StateObject(xmlValue:XML) {
			XMLValue = xmlValue;
		}
		
		public function get stateID():String {
			var ret:String = XMLValue.@id;
			return ret;
		}
		
		public function get hasParallelState():Boolean {
			var ret:Boolean = false;
			var s:String = XMLValue.@parallel.toString();
			if(s!="") ret = true;
			return ret;
		}
		
		public function get parallelStates():Array {
			var retArr:Array = [];
			var s:String = XMLValue.@parallel.toString();
			retArr = s.split(",")
			return retArr;
		}
		
		public function get keyObject():Object {
			var retObj:Object = {
							panel: XMLValue.key.attribute("panel").toString(),
							element: XMLValue.key.attribute("element").toString(),
							sswitch: XMLValue.key.attribute("switch").toString(),
							wait: XMLValue.key.attribute("wait").toString()
			}
			var hasCondition:Boolean = false;
			var c_s:String = XMLValue.key.attribute("c_screen").toString();
			var c_e:String = XMLValue.key.attribute("c_element").toString();
			var c_v:String = XMLValue.key.attribute("c_value").toString();
			
			if(c_s!="" && c_e!="" && c_v!="") hasCondition=true;
			
			retObj.hasCondition = hasCondition;
			if(hasCondition) {
				retObj.c_screen = c_s;
				retObj.c_element = c_e;
				retObj.c_value = c_v;
			}
			
			var hasOption:Boolean = false;
			var o_s:String = XMLValue.key.attribute("o_screen").toString();
			var o_e:String = XMLValue.key.attribute("o_element").toString();
			var o_v:String = XMLValue.key.attribute("o_value").toString();
			
			if(o_s!="" && o_e!="" && o_v!="" && !hasCondition) hasOption=true;
			
			retObj.hasOption = hasOption;
			if(hasOption) {
				retObj.o_screen = o_s;
				retObj.o_element = o_e;
				retObj.o_value = o_v;
			}
			
			return retObj;
		}
		
		public function get helpBoxObject():Object {
			var retObj:Object = {
							source: XMLValue.help_box.attribute("source").toString(),
							note: XMLValue.help_box.attribute("note").toString(),
							completed: XMLValue.help_box.attribute("completed").toString(),
							htext: XMLValue.help_box
			}
			return retObj;
		}
		
		public function get hasInfoBox1():Boolean {
			var ret:Boolean = false;
			var st:String = String(XMLValue.info_box1);
			if(st.length>0) ret = true;
			return ret;
		}
		
		public function get hasInfoBox2():Boolean {
			var ret:Boolean = false;
			var st:String = String(XMLValue.info_box2);
			if(st.length>0) ret = true;
			return ret;
		}
		
		public function get infoBox1():Object {
			var retObj:Object = {
							boxFrame: XMLValue.info_box1.attribute("gotoFrame").toString(),
							infoText: XMLValue.info_box1
			}
			return retObj;
		}
		
		public function get infoBox2():Object {
			var retObj:Object = {
							boxFrame: XMLValue.info_box2.attribute("gotoFrame").toString(),
							infoText: XMLValue.info_box2
			}
			return retObj;
		}
		
		public function get hasHighlighting():Boolean {
			var ret:Boolean = false;
			var st:String = XMLValue.highlight.@panel.toString(); //String(XMLValue.highlight);
			if(st.length>0) ret = true;
			return ret;
		}
		
		public function get highlightedPanels():String {
			return XMLValue.highlight.@panel.toString();
		}
		
		public function get screenObjectID():String {
			var ret:String = XMLValue.screen.attribute("screenID").toString();
			return ret;
		}
		
		public function get hasInopObject():Boolean {
			var ret:Boolean = false;
			var inop:String = XMLValue.screen.attribute("inop").toString();
			if(inop!="") ret=true;
			return ret;
		}
		
		public function get inopScreenName():String {
			var ret:String = XMLValue.screen.attribute("inop").toString();
			return ret;
		}
		
		public function get hasInopWhiteLine():Boolean {
			var ret:Boolean = false;
			var line:String = XMLValue.screen.attribute("line").toString();
			if(line=="true") ret=true;
			return ret;
		}
		
		public function get hasElements():Boolean {
			var ret:Boolean = false;
			for each(var element:XML in XMLValue.elements()) {
				if(element.name().localName=="element") ret=true;
			}
			return ret;
		}
		
		public function get hasAdditional():Boolean {
			var ret:Boolean = false;
			for each(var element:XML in XMLValue.elements()) {
				if(element.name().localName=="additional") ret=true;
			}
			return ret;
		}
		
		public function get additionalScreenObject():Object {
			var retObj:Object = {
							screen: XMLValue.additional.attribute("screen").toString()
			}
			return retObj;
		}
		
		public function get elementObjectArray():Array {
			var retArr:Array = [];
			
			for each(var element:XML in XMLValue.elements()) {
				if(element.name().localName=="element") {
/*					var parsedElement:Object = {
									panel: element.@panel.toString(),
									name: element.@name.toString(),
									status: element.@status.toString()
					}
					*/
				
					var parsedElement:Object = new Object();
					var attNamesList:XMLList = element.@*;
					
					for (var i:int=0; i<attNamesList.length(); i++) {
							//trace(attNamesList[i].name() + ": " + attNamesList[i].toString());
							parsedElement[String(attNamesList[i].name())] = attNamesList[i].toString();
					}
					retArr.push(parsedElement);
				}
			}
			return retArr;
		}
		
	}
}