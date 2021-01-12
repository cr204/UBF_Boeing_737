package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import com.winglet.utils.ProjectUtils;
	
	public class Compass extends Sprite {
		private var pointerPosition:Number = 0;
		private var time:Number = 0;
		private var ease1:Object;
//		private var xPoint:Number = 0;
//		private var xElement:String;
		private var waitTime:Number = 0;
		private var loopID:String;
		private var velocitiesArr:Array = [];
		
		public function Compass() {
			// constructor code
			roller.cacheAsBitmap = true;
		}
		
		public function setPointerPosition(n:Number):void {
			TweenLite.killTweensOf(roller);
			TweenLite.killTweensOf(this);
			
			var newPos:Number = n * -16;
			roller.rotationZ = newPos;
			trace("roller.rotationZ: " + roller.rotationZ);
		}
		
		public function updatePointerPosition(objXML:XML):void {
			// This time altPosition takes @value tag from XML!!!
			pointerPosition = Number(objXML.@value.toString());
			time = Number(objXML.@time.toString());
			ease1 = ProjectUtils.getInstance().getEaseType(objXML.@ease.toString());
//			xPoint = Number(objXML.@xpoint.toString());
//			xElement = objXML.@xelement.toString();
			waitTime = Number(objXML.@wait.toString());
			
			
			var newPos:Number = pointerPosition * -16;
			TweenLite.to(roller, time, {rotationZ:newPos, delay:waitTime, overwrite:false, ease:ease1});
		}
		
		
		
	}
}