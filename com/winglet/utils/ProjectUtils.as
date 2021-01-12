package com.winglet.utils {

	import flash.geom.ColorTransform;
	import fl.motion.easing.*;
	
	public class ProjectUtils {
		private static var instance:ProjectUtils;
		private static var allowInstance:Boolean;

		
		public function ProjectUtils() {
			//throw new Error("Class airbus.flightdeck.utils.ProjectUtils is not designed to be instantiated!"); 
			if(!allowInstance) {
				throw new Error("Error: use Settings.getInstance() instead of new keyword");
			}
		}
		
		public static function getInstance():ProjectUtils {
			if(instance == null) {
				allowInstance = true;
				instance = new ProjectUtils();
				allowInstance = false;
				return instance;
			} else {
				//trace("Settings instance already exists");
			}
			return instance;
		}
		
		public function covertToXMLObject(xml:XML):Object {
			var retObject:Object = new Object();
				var attNamesList:XMLList = xml.@*;
				for (var i:int=0; i<attNamesList.length(); i++) {
					retObject[String(attNamesList[i].name())] = attNamesList[i].toString();
				}
			return retObject;
		}
		
		
		public function tintClip(obj:*, c:uint):void {
			var color:uint=c; //picker.selectedColor;
			var mul:Number=1; //slider.value/100;
			var ctMul:Number=(1-mul);
			var ctRedOff:Number=Math.round(mul*extractRed(color));
			var ctGreenOff:Number=Math.round(mul*extractGreen(color));
			var ctBlueOff:Number=Math.round(mul*extractBlue(color));
			var ct:ColorTransform=new ColorTransform(ctMul,ctMul,ctMul,1,ctRedOff,ctGreenOff,ctBlueOff,0);
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
		
		
		
		public function getEaseType(s:String):Object {
			var ret:Object;
			// To select easing types!
			switch(s) {
				case "Linear.easeIn":
					ret = Linear.easeIn;
					break;
				case "Linear.easeOut":
					ret = Linear.easeOut;
					break;
				case "Linear.easeInOut":
					ret = Linear.easeInOut;
					break;
				case "Linear.easeNone":
					ret = Linear.easeNone;
					break;
				case "Back.easeIn":
					ret = Back.easeIn;
					break;
				case "Back.easeOut":
					ret = Back.easeOut;
					break;
				case "Back.easeInOut":
					ret = Back.easeInOut;
					break;
				case "Bounce.easeIn":
					ret = Bounce.easeIn;
					break;
				case "Bounce.easeOut":
					ret = Bounce.easeOut;
					break;
				case "Bounce.easeInOut":
					ret = Bounce.easeInOut;
					break;
				case "Circular.easeIn":
					ret = Circular.easeIn;
					break;
				case "Circular.easeOut":
					ret = Circular.easeOut;
					break;
				case "Circular.easeInOut":
					ret = Circular.easeInOut;
					break;
				case "Elastic.easeIn":
					ret = Elastic.easeIn;
					break;
				case "Elastic.easeOut":
					ret = Elastic.easeOut;
					break;
				case "Elastic.easeInOut":
					ret = Elastic.easeInOut;
					break;
				case "Quadratic.easeIn":
					ret = Quadratic.easeIn;
					break;
				case "Quadratic.easeOut":
					ret = Quadratic.easeOut;
					break;
				case "Quadratic.easeInOut":
					ret = Quadratic.easeInOut;
					break;
				case "Quartic.easeIn":
					ret = Quartic.easeIn;
					break;
				case "Quartic.easeOut":
					ret = Quartic.easeOut;
					break;
				case "Quartic.easeInOut":
					ret = Quartic.easeInOut;
					break;
				case "Quintic.easeIn":
					ret = Quintic.easeIn;
					break;
				case "Quintic.easeOut":
					ret = Quintic.easeOut;
					break;
				case "Quintic.easeInOut":
					ret = Quintic.easeInOut;
					break;
				case "Sine.easeIn":
					ret = Sine.easeIn;
					break;
				case "Sine.easeOut":
					ret = Sine.easeOut;
					break;
				case "Sine.easeInOut":
					ret = Sine.easeInOut;
					break;
				case "null":
					ret = Linear.easeNone;
					break;
				case "":
					//
					break;

				default:
					trace("Error! Unknown ease type: '" + s + "' in ProjectUtils.as");
					break;
			}
			return ret;
		}
	
	
	
	}
}