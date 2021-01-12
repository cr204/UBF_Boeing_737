package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import fl.motion.easing.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.winglet.utils.ProjectUtils;
	
	public class pfdcomponenets_VSI extends Sprite {
		private var limit1:int = -95;
		private var limit2:int = 110;
		private var number1:Number = -20;
		private var number2:Number = 20;
		private var m1:Number = new Number();
		
		private var pointerPosition:Number = 0;
		private var time:Number = 0;
		private var ease1:Object;
		private var val:Number = 0;
		private var wait:Number = 0;
		private var newPPosition:Number = 0;
		private var oldPPosition:Number = 0;
		private var waitTime:Number = 0;
		private var sNumb:Number = 0;
		private var inc:Number = 0;
		private var velocitiesArr:Array = [];
		private var currVel:int = -1;
		private var loopID:String;
		
		private var myTimer:Timer;
		
		public function pfdcomponenets_VSI() {
			// constructor code
			pointer.cacheAsBitmap = true;
			pointer.rotationZ = 0;
			pointer0.visible = false;
		}
		
		
		public function setNumbers(n1:Number, n2:Number):void {
			number1 = n1;
			number2 = n2;
		}
		
		public function setPointerPosition(xml:XML):void {
			
			val = Number(xml.@value);
			time = Number(xml.@time);
			wait = Number(xml.@wait);

			TweenLite.to(pointer0, time, {y:val, onComplete:tweenCompleted, delay:wait, overwrite:false, ease:Linear.easeNone, onUpdate:uFunction, onUpdateParams:[pointer0]})
			if(time==0) oldPPosition = val;
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
				updatePointerPosition1(velocitiesArr[currVel]);
			} else {
//				trace("stop");
			}
		}
		
		private function completeNextVelocityID(sID:String):void {
			var n:int = getVelocityIndexByID(sID);
			if(n<0) {
				trace("Error! Velocity ID: " + sID + " was not found in pfdcomponents_VSI.as loop!");
			} else {
				currVel = n-1;
				completeNextVelocity();
			}
		}
		
		private function updatePointerPosition1(objXML:XML):void {
			
			val = Number(objXML.@pointerPosition) * -1;
			time = Number(objXML.@time);
			wait = Number(objXML.@wait);
			ease1 = ProjectUtils.getInstance().getEaseType(objXML.@ease.toString());
			loopID = objXML.@loop.toString();
			
			newPPosition = pointerPosition;
			if(wait>0) {
				TweenLite.to(this, 0, {delay:wait, onComplete:startTweening});
			} else if(wait==0) {
				startTweening();
			}
		}
		
		private function startTweening():void {
			TweenLite.to(pointer0, time, {y:val, onComplete:nextPoint, overwrite:false, ease:ease1, onUpdate:uFunction, onUpdateParams:[pointer0]});
		}
		
		private function nextPoint():void {
			oldPPosition = newPPosition;
			
			if(loopID!="") {
				completeNextVelocityID(loopID);
			} else completeNextVelocity();
		}
		
		public function reset():void {
			TweenLite.killTweensOf(pointer0);
			pointer0.y = 0;
			pointer.rotationZ = 180;
		}
		
		private function tweenCompleted():void {
			oldPPosition = val;
		}

		private function uFunction(obj:Object):void {
			correctPointer(obj.y);
		}
		
		private function correctPointer(n:Number):void {
//			trace("correctPointer: " + n);
			
			if(n<0 && n>=-5) {
				pointer.rotationZ = 5.6 * n;
			}
			if(n<-5 && n>=-10) {
				pointer.rotationZ = - 28 + 3.6 * (n+5);
			}
			
			if(n<-10 && n>=-15) {
				pointer.rotationZ = - 46 + 1.6 * (n+10);
			}
			if(n<-15 && n>=-20) {
				pointer.rotationZ = -54 + 1.3 * (n+15);
			}
			if(n<-20 && n>-60) {
				pointer.rotationZ = -60.5 + 0.137 * (n+20);
			}
			if(n<=-60) {
				pointer.rotationZ = -66;
			}
			
			
			if(n>=0 && n<=5) {
				pointer.rotationZ = 5.6 * n;
			}
			if(n>5 && n<=10) {
				pointer.rotationZ = 28 + 3.6 * (n-5);
			}
			if(n>10 && n<=15) {
				pointer.rotationZ = 46 + 1.6 * (n-10);
			}
			if(n>15 && n<=20) {
				pointer.rotationZ = 54 + 1.3 * (n-15);
			}
			if(n>20 && n<60) {
				pointer.rotationZ = 60.5 + 0.137 * (n-20);
			}
			
			if(n>=60) {
				pointer.rotationZ = 66;
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
		
		
		
	}
}