package com.winglet {
	import flash.xml.XMLDocument;
	
	public class XMLSettings extends XMLDocument {
		private var XMLValue:XMLList;
		
		
		public function XMLSettings(xmlValue:XMLList) {
			XMLValue = xmlValue;
			
//			for each(var element:XML in xmlValue.elements()) {
//				trace("name: " + element.name().localName);
//			}
		}

		public function get xmlLength():int {
			return XMLValue.elements().length();
		}

		public function get parallelStatesFN():String {
			var ret:String = XMLValue.training.@parallel_states.toString();
			return ret;
		}
		
		public function get screenFN():String {
			var ret:String = XMLValue.screen_animation.@file.toString();
			return ret;
		}
		
		public function get screenDFN():String {
			var ret:String = XMLValue.screen_animation.@defaults.toString();
			return ret;
		}

		public function get soundStatus():String {
			var ret:String = XMLValue.sound.@status.toString();
			return ret;
		}

		public function get trainingName():String {
			var ret:String = XMLValue.training.@name.toString();
			return ret;
		}
		
		public function get quickReference():String {
			var ret:String = XMLValue.quick_reference.@file.toString();
			return ret;
		}


	}
	
}