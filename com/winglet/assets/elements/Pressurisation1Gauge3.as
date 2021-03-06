﻿package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import com.winglet.utils.ProjectUtils;
	import flash.geom.Point;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.winglet.datatype.VelocityObject;
	
	public class Pressurisation1Gauge3 extends Sprite {
		private var time:Number = 0;
		private var ease1:Object;
		private var loopID:String;
		private var waitTime:Number;
		private var nextPosition:Number;
		private var oldPPosition:Number = 0;
		private var velocitiesArr:Array = [];
		private var currVel:int = -1;
		private var pointer0:Point = new Point();
		
		public function Pressurisation1Gauge3() {
			// constructor code
			pointer1.rotationZ = 0;
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
			setValue(pointer0.x);
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
			if(n<-4000) n=-4000;
			if(n>4000) n=4000;
			
			var pos:Number = 0;
			if(n>0 && n<=500) pos = 0 + n * .104;
			if(n>500 && n<=1000) pos = 52 + (n-500) * .056;
			if(n>1000 && n<=2000) pos = 80 + (n-1000) * .04;
			if(n>2000 && n<=3000) pos = 120 + (n-2000) * .025;
			if(n>3000 && n<=4000) pos = 145 + (n-3000) * .023;
			
			if(n<0 && n>=-500) pos = n * .096;
			if(n<-500 && n>=-1000) pos = -48 + (n+500) * .056;
			if(n<-1000 && n>=-2000) pos = -78 + (n+1000) * .04;
			if(n<-2000 && n>=-3000) pos = -118 + (n+2000) * .025;
			if(n<-3000 && n>=-4000) pos = -143 + (n+3000) * .023;
			
//			if(n>25 && n<=30) pos = 236 + (n-25) * 5.2;
//			if(n>30 && n<=35) pos = 262 + (n-30) * 4;
//			if(n>35 && n<=40) pos = 282 + (n-35) * 3.6;
//			if(n>40 && n<=50) pos = 300 + (n-40) * 2.5;
			
			pointer1.rotationZ = pos;
		}
		
		public function resetElement():void {
			TweenLite.killTweensOf(pointer1);
			TweenLite.killTweensOf(pointer0);
			TweenLite.killTweensOf(this);
			
			nextPosition = 0;
			oldPPosition = 0;
			currVel = -1;
			pointer0.x = 0;
			pointer1.rotationZ = 0;
		}
	}
}