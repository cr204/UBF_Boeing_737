package com.winglet {
	import flash.xml.XMLDocument;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class ParallelStates extends XMLDocument {
		private var siteLink:String = ""; //"http://www.winglet.co.uk/usebeforeflight/training3.0/";
		private var fileName:String;
		private var XMLValue:XMLList;
		private var parallelStatesArr:Array = [];
		private var doneParallelStatesArr:Array = [];
		private var _parallelXMLLoaded:Boolean = false;
		
		public function ParallelStates(s:String) {
			fileName = siteLink + s;
			init();
		}
		
		private function init():void {
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, onXMLLoaded);
			xmlLoader.load(new URLRequest(fileName));
			
		}
		
		private function onXMLLoaded(e:Event):void {
			try {
				trace("Parallel states loaded!");
				var mainData:XML = new XML( e.target.data );

				if(mainData.parallel_states) {
					
					for each(var element:XML in mainData.parallel_states.elements()) {
						var parsedParallelState:Object = {
										id: element.@id.toString(),
										note: element.@note.toString(),
										waitTime: Number(element.@wait),
										paramXML: element,
										done: false
										}
						parallelStatesArr.push(parsedParallelState);
						
//						var done:Boolean = false;
//						doneParallelStatesArr.push(done);
					}
				}
				//trace(parallelStatesArr[1].paramXML);
				_parallelXMLLoaded = true;
				
			} catch (err:Error) {
				trace(fileName + " - Loading error: " + err.message);
				_parallelXMLLoaded = true;
				return;
			}
		}
		
		public function get loaded():Boolean {
			return _parallelXMLLoaded;
		}
		
		public function resetStates():void {
			trace("ParallelStates.resetStates()");
			for(var i:int=0; i<parallelStatesArr.length; ++i) {
				parallelStatesArr[i].done = false;
			}
		}
		
		public function get totalStates():int {
			return parallelStatesArr.length;
		}
		
		public function getState(n:int):Object {
			var xmlObj:Object = parallelStatesArr[n];
//			trace(xmlObj.paramXML);
			var keyObject:Object = {
							panel: xmlObj.paramXML.key.attribute("panel").toString(),
							element: xmlObj.paramXML.key.attribute("element").toString(),
							sswitch: xmlObj.paramXML.key.attribute("switch").toString()
						}
			var screenObject:Object = {
							screenID: xmlObj.paramXML.screen.attribute("screenID").toString()
						}
						
			var hasCondition:Boolean = false;
			var c_s:String = xmlObj.paramXML.key.attribute("c_screen").toString();
			var c_e:String = xmlObj.paramXML.key.attribute("c_element").toString();
			var c_v:String = xmlObj.paramXML.key.attribute("c_value").toString();
			if(c_s!="" && c_e!="" && c_v!="") hasCondition=true;

			var hasOption:Boolean = false;
			var o_s:String = xmlObj.paramXML.key.attribute("o_screen").toString();
			var o_e:String = xmlObj.paramXML.key.attribute("o_element").toString();
			var o_v:String = xmlObj.paramXML.key.attribute("o_value").toString();
			if(o_s!="" && o_e!="" && o_v!="" && !hasCondition) hasOption=true;
						
			var retObj:Object = {
							id: xmlObj.id,
							done: xmlObj.done,
							note: xmlObj.note,
							waitTime: xmlObj.waitTime,
							keyObject: keyObject,
							screenObject: screenObject,
							hasCondition: hasCondition,
							hasOption: hasOption
						}
			
			if(hasCondition) {
				retObj.c_screen = c_s;
				retObj.c_element = c_e;
				retObj.c_value = c_v;
			}

			if(hasOption) {
				retObj.o_screen = o_s;
				retObj.o_element = o_e;
				retObj.o_value = o_v;
			}
						
						
			return retObj;
			
		}
		
		public function getStateByID(s:String):Object {
			var retObj:Object;
			for(var i:int=0; i<parallelStatesArr.length; ++i) {
				if(parallelStatesArr[i].id == s) {
					retObj = getState(i);
				}
			}
			return retObj;
		}
		
		public function stateDone(s:String):void {
//			var doneState:Object = getStateByID(s);
//			doneState.done = true;
			var n:int = getStateOrderByID(s);
			parallelStatesArr[n].done = true;
//			trace("n: " + n + "  -->  " + parallelStatesArr[n].done);
		}
		
		private function getStateOrderByID(s:String):int {
			var ret:int;
			for(var i:int=0; i<parallelStatesArr.length; ++i) {
				if(parallelStatesArr[i].id == s) {
					ret = i;
				}
			}
			return ret;
		}
		
	}
}