package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import com.winglet.utils.ProjectUtils;
	import flash.geom.Point;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.winglet.datatype.VelocityObject;
	
	
	public class APUGauge1 extends Sprite {
		private var time:Number = 0;
		private var ease1:Object;
		private var loopID:String;
		private var waitTime:Number;
		private var nextPosition:Number;
		private var oldPPosition:Number = 0;
		private var velocitiesArr:Array = [];
		private var currVel:int = -1;
		
		private var pointer0:Point = new Point();
		
		public function APUGauge1() {
			// constructor code
			//pointer.rotationZ = 247;
			pointer0.x = 0;
		}
		
		public function setXMLObject(eObj:Object):void {
			//setValue(Number(eObj.value));
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
			setValue(Math.round(pointer0.x));
		}
		
		
		
		public function setVelocitiesArr(arr:Array):void {
			currVel = -1;
			velocitiesArr = [];
			velocitiesArr = arr;
			completeNextVelocity();
		}
		
		private function completeNextVelocity():void {
			++currVel;
			if(currVel<velocitiesArr.length){
//				trace("velocitiesArr[" + currVel + "]: " + velocitiesArr[currVel].toXMLString());
				//updatePointerPosition1(velocitiesArr[currVel]);
				updatePointerPosition1(ProjectUtils.getInstance().covertToXMLObject(velocitiesArr[currVel] as XML));
			}
		}
		
		private function updatePointerPosition1(velObj:Object):void {
			nextPosition = Number(velObj.pointerPosition);
			time = Number(velObj.time);
			ease1 = ProjectUtils.getInstance().getEaseType(velObj.ease);
			waitTime = Number(velObj.wait);
			loopID = velObj.loopID;
			startTweening();
		}
		
		private function startTweening():void {
//			trace("startTweening - time:" + time + "  - nextPosition:" + nextPosition);
			TweenLite.to(pointer0, time, {x:nextPosition, ease:ease1, delay:waitTime, onUpdate:uFunction, onComplete:nextPoint});
		}
		
		private function nextPoint():void {
			oldPPosition = nextPosition;
			if(loopID) {
				completeNextVelocityID(loopID);
			} else completeNextVelocity();
		}
		
		private function completeNextVelocityID(sID:String):void {
			var n:int = getVelocityIndexByID(sID);
			if(n<0) {
				trace("Error! Velocity ID: " + sID + " was not found in APUGauge.as loop!");
			} else {
				currVel = n-1;
				completeNextVelocity();
			}
		}
		
		private function getVelocityIndexByID(sID:String):int {
			var ret:int = -1;
			for(var i:int=0; i<velocitiesArr.length; ++i) {
				var tID:String = velocitiesArr[i].@id.toString();
				if(tID==sID) ret=i;
			}
			return ret;
		}
		
		
		
		
		private function setValue(n:Number):void {
			var m:Number = 247 / 1100;
			rotatePointer(n * m)
		}
		
		private function rotatePointer(deg:Number):void {
			if(deg>247) {
				pointer.rotationZ = 247;
			} else if(deg<0) {
				pointer.rotationZ = 0;
			} else {
				pointer.rotationZ = deg;
			}
		}
		
		public function resetElement():void {
			TweenLite.killTweensOf(pointer);
			TweenLite.killTweensOf(pointer0);
			TweenLite.killTweensOf(this);

			pointer0.x = 0;
			pointer.rotationZ = 0;
			nextPosition = 0;
			oldPPosition = 0;
		}
		
	}
}