package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import com.winglet.utils.ProjectUtils;
	import flash.geom.Point;
	
	public class Element45 extends Sprite {
		private var time:Number = 0;
		private var ease1:Object;
		private var loopID:String;
		private var waitTime:Number;
		private var nextPosition:Number;
		private var oldPPosition:Number = 0;
		private var pointer0:Point = new Point();
		
		public function Element45() {
			// constructor code
			//pointer.rotationZ = 127;
		}
		
		public function setXMLObject(eObj:Object):void {
			time = Number(eObj.time);
			ease1 = ProjectUtils.getInstance().getEaseType(eObj.ease);
			waitTime = Number(eObj.wait);
			nextPosition = Number(eObj.value);
			
			if(time) {
				TweenLite.to(pointer0, time, {x:nextPosition, delay:waitTime, ease:ease1, onUpdate:uFunction});
			} else {
				setValue(Number(eObj.value));
				pointer0.x = nextPosition;
			}
		}
		
		private function uFunction():void {
			setValue(pointer0.x);
		}
		
		private function setValue(n:Number):void {
			if(n<-56) n=-56;
			if(n>56) n=56;
			var valueZ:Number = n * 2.26;
			pointer.rotationZ = valueZ;
		}
		
		public function resetElement():void {
			pointer.rotationZ = 0;
		}
		
	}
}