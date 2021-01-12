// ScreenStates.as
package com.winglet {
	import flash.xml.XMLDocument;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class ScreenStates extends XMLDocument {
		private var fileName:String;
		private var XMLValue:XMLList;
		private var screenAnimationsArray:Array = [];
		private var velocityArray:Array = [];
		private var _screenXMLLoaded:Boolean = false;

		public function ScreenStates(s:String) {
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
				trace("Screen XML loaded!");
				var mainData:XML = new XML( e.target.data );

				if(mainData.animations) {
					
					for each(var element:XML in mainData.animations.elements()) {
						var parsedScreenAnimationObject:Object = {
												screenAnimationID: element.@id,
												screenAnimationType: "main"
												}
						var parsedScreens:Array = [];
						for each(var element1:XML in element.elements()) {
							// There are also other attributes like "system" and etc... CHECK IT LATER!
							var parsedScreenObject:Object = {
												screenName: element1.@name.toString(),
												defaultSystem: element1.@defaultSystem.toString(),
												screenSystem: element1.@currentSystem.toString(),
												updateSystem: element1.@updateSystem.toString(),
												gotoFrame: Number(element1.@gotoFrame)
												}
								var parsedElements:Array = [];
								for each(var element2:XML in element1.elements()) {
									parsedElements.push(element2);
//									trace("localName: " + element2.name().localName);
								}
								parsedScreenObject.elementsXML = parsedElements;
							parsedScreens.push(parsedScreenObject);
						}
						parsedScreenAnimationObject.screens = parsedScreens;
						screenAnimationsArray.push(parsedScreenAnimationObject);
					}  
				}
//				trace("screenAnimationID: " + screenAnimationsArray[0].screenAnimationID); 
//				trace("screenName: " + screenAnimationsArray[0].screens[0].screenName);
//				trace("ElementName: " + screenAnimationsArray[0].screens[0].elementsXML[0].@name);
				
				// SETTINGS
				if(mainData.settings) {
					var pasFilename:String = mainData.settings.parallel_animations.@file.toString();
					if(pasFilename!="") {
						loadPAS(pasFilename);
					} else {
						trace("Alert! There is no parallel states screen animations XML file!")
					}
				}
				
				// GAUGE VELOCITY PARAMETERS
				if(mainData.gauge_velocity) {
					for each(var element3:XML in mainData.gauge_velocity) {
						
						for each(var element4:XML in element3.elements()) {
							var velArr:Array = [];
							for each(var element5:XML in element4.elements()) {
								velArr.push(element5);
							}
							var velocitiesObject:Object = {
												velocitiesID: element4.@id.toString(),
												velocitiesXML: velArr
											}
							trace("-------------------------------");
							trace("velocitiesID: " + velocitiesObject.velocitiesID);
							trace("velocitiesXML: " + velocitiesObject.velocitiesXML);
							
						velocityArray.push(velocitiesObject);
						}
					}

//					trace("velocitiesID: " + velocityArray[0].velocitiesID);
//					trace(velocityArray[0].velocitiesXML[0].@nextPoint);
				}
				
				_screenXMLLoaded = true;
				
			} catch (err:Error) {
				trace(fileName + " - Loading error: " + err.message);
				_screenXMLLoaded = true;
				return;
			}
		}
		
		public function get loaded():Boolean {
			return _screenXMLLoaded;
		}
		public function getScreenByID(s:String):Object {
			var retObj:Object;
			for(var i:int=0; i<screenAnimationsArray.length; i++) {
				if(screenAnimationsArray[i].screenAnimationID==s) {
					retObj = screenAnimationsArray[i];
				}
			}
			
//			trace("%%%%%%%%%%%%%%%%%%%%%%%%");
//			trace("getScreenByID: " + s);
			for (var j:int=0; j<retObj.screens.length; j++) {
//				trace("retObj.screenSystem[" + j + "]: " + retObj.screens[j].screenSystem);
				if(j==0 && retObj.screens[j].screenSystem!="") {
//					trace("YEAP! worked.");
					retObj.screens[j].screenSystem = 0;
				}
			}
//			trace("%%%%%%%%%%%%%%%%%%%%%%%%");
			
			return retObj;
		}
		
		public function getVelocitiesByID(s:String):Object {
			var retObj:Object;
			for(var i:int=0; i<velocityArray.length; i++) {
				if(velocityArray[i].velocitiesID==s) {
					retObj = velocityArray[i];
				}
			}
			return retObj;
		}
		
		
		
		private function loadPAS(fn:String):void {
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, onXMLLoaded1);
			xmlLoader.load(new URLRequest(fn));
		}
		
		private function onXMLLoaded1(e:Event):void {
			try {
				trace("Parallel Screen XML loaded!");
				var mainData:XML = new XML( e.target.data );

				if(mainData.parallel_states) {
					
					for each(var element:XML in mainData.parallel_states.elements()) {
						var parsedScreenAnimationObject:Object = {
												screenAnimationID: element.@id,
												screenAnimationType: "parallel"
												}
						var parsedScreens:Array = [];
						for each(var element1:XML in element.elements()) {
							// There are also other attributes like "system" and etc... CHECK IT LATER!
							var parsedScreenObject:Object = {
												screenName: element1.@name.toString(),
												defaultSystem: element1.@defaultSystem.toString(),
												screenSystem: element1.@currentSystem.toString(),  // no currentSystem in parallelStates!
												updateSystem: element1.@updateSystem.toString(),
												gotoFrame: Number(element1.@gotoFrame)
												}
								var parsedElements:Array = [];
								for each(var element2:XML in element1.elements()) {
									parsedElements.push(element2);
								}
								parsedScreenObject.elementsXML = parsedElements;
							parsedScreens.push(parsedScreenObject);
						}
						parsedScreenAnimationObject.screens = parsedScreens;
						screenAnimationsArray.push(parsedScreenAnimationObject);
					}  
				}
//				trace("screenAnimationID: " + screenAnimationsArray[0].screenAnimationID); 
//				trace("screenName: " + screenAnimationsArray[0].screens[0].screenName);
//				trace("ElementName: " + screenAnimationsArray[0].screens[0].elementsXML[0].@name);
				
				// GAUGE VELOCITY PARAMETERS
				if(mainData.gauge_velocity) {
					for each(var element3:XML in mainData.gauge_velocity) {
						
						for each(var element4:XML in element3.elements()) {
							var velArr:Array = [];
							for each(var element5:XML in element4.elements()) {
								velArr.push(element5);
							}
							var velocitiesObject:Object = {
												velocitiesID: element4.@id.toString(),
												velocitiesXML: velArr
											}
							
						velocityArray.push(velocitiesObject);
						}
					}
				}
				
			} catch (err:Error) {
				trace("Parallel states screen animation XML file loading error: " + err.message);
				return;
			}
		}
		

	}
}