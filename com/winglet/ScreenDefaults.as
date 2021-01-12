// ScreenStates.as
package com.winglet {
	import flash.xml.XMLDocument;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class ScreenDefaults extends XMLDocument {
		private var fileName:String;
		private var XMLValue:XMLList;
		private var screenAnimationsArray:Array = [];
		private var _defaultsXMLLoaded:Boolean = false;

		public function ScreenDefaults(s:String) {
			fileName = s;
			init();
		}

		private function init():void {
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, onXMLLoaded);
			xmlLoader.load(new URLRequest(fileName));
		}
		
		private function onXMLLoaded(e:Event):void {
			try {
				trace("Screen defaults XML loaded!");
				var mainData:XML = new XML( e.target.data );

				if(mainData.default_values) {
					
					for each(var element:XML in mainData.default_values.elements()) {
						var parsedScreenObject:Object = {
												screenName: element.@name.toString(),
												screenSystem: element.@system.toString(),
												gotoFrame: Number(element.@gotoFrame)
												}
						var parsedElements:Array = [];
						for each(var element2:XML in element.elements()) {
							parsedElements.push(element2);
							//trace("localName: " + element2.name().localName);
						}
						parsedScreenObject.elementsXML = parsedElements;
						screenAnimationsArray.push(parsedScreenObject);
					}  
				}
//				trace("screenName: " + screenAnimationsArray[0].screenName); 
//				trace("elementsXML: " + screenAnimationsArray[0].elementsXML[0].@name);
//				trace("ElementName: " + screenAnimationsArray[0].screens[0].elementsXML[0].@name);
				_defaultsXMLLoaded = true;
				
			} catch (err:Error) {
				trace(fileName + " - Loading error: " + err.message);
				_defaultsXMLLoaded = true;
				return;
			}
		}
		
		public function get loaded():Boolean {
			return _defaultsXMLLoaded;
		}
		public function getScreenDefaults():Array {
			var retArr:Array = screenAnimationsArray;
			return retArr;
		}
		
	}
}