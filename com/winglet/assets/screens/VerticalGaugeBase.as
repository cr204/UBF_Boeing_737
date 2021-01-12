package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import fl.motion.easing.*;
	import flash.geom.ColorTransform;
	import com.greensock.TweenLite;
	import com.winglet.datatype.VelocityObject;
	import com.winglet.Colors;
	import com.winglet.utils.ProjectUtils;
	
	public class VerticalGaugeBase extends Sprite {
		private var ct:ColorTransform=new ColorTransform();
		protected var systemColor:uint = Colors.WHITE; 
		protected var limit1:int = -78;
		protected var limit2:int = 90;
		protected var number1:Number = 0;
		protected var number2:Number = 100;
		
		protected var pointerPosition:Number = 0;
		private var time:Number = 0;
		private var ease1:Object;
		private var xPoint:Number = 0;
		private var xElement:String;
		private var loopID:String;
		private var newPPosition:Number = 0;
		protected var oldPPosition:Number = 0;
		private var waitTime:Number = 0;
		private var velocitiesArr:Array = [];
		private var currVel:int = -1;
		
		private var pointer:MovieClip;
		private var pointer0:MovieClip;

		public function VerticalGaugeBase() {
			// constructor code
		}
		
		protected function initBase(pointer:MovieClip, pointer0:MovieClip):void {
			this.pointer = pointer;
			this.pointer0 = pointer0;
			pointer0.visible = false;
		}
		
		protected function setBasePointerPosition(newPosition:Number):void {
			pointer0.y = limit2 - newPosition;
			correctPointerPosition();
			currVel = -1;
			TweenLite.killTweensOf(pointer);
			TweenLite.killTweensOf(pointer0);
			TweenLite.killTweensOf(this);
		}
		
		protected function updateBasePointerPosition(objXML:XML, newPosition:Number):void {
			pointerPosition = Number(objXML.@value.toString());
			time = Number(objXML.@time.toString());
			ease1 = ProjectUtils.getInstance().getEaseType(objXML.@ease.toString());
			xPoint = Number(objXML.@xpoint.toString());
			xElement = objXML.@xelement.toString();
			waitTime = Number(objXML.@wait.toString());
			
			newPPosition = pointerPosition;
			
			TweenLite.to(pointer0, time, {y:limit2 - newPosition, delay:waitTime, ease:ease1, onUpdate:uFunction, onUpdateParams:[pointer0]});
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
			}
		}

		private function completeNextVelocityID(sID:String):void {
			var n:int = getVelocityIndexByID(sID);
			if(n<0) {
				trace("Error! Velocity ID: " + sID + " was not found in GaugeBase.as loop!");
			} else {
				currVel = n-1;
				completeNextVelocity();
			}
		}

		private function updatePointerPosition1(velObj:VelocityObject):void {
			pointerPosition = velObj.pointerPosition;
			time = velObj.time;
			//ease1 = getEaseType(velObj.ease);
			ease1 = ProjectUtils.getInstance().getEaseType(velObj.ease);
			xPoint = velObj.xpoint;
			xElement = velObj.xelement;
			loopID = velObj.loopID;
			waitTime = velObj.wait;
			
			newPPosition = pointerPosition;
			if(waitTime>0) {
				TweenLite.to(this, waitTime, {onComplete:startTweening});
			} else if(waitTime==0) {
				startTweening();
			}
		}

		protected function startTweening():void {
			// Must be overriden by sub class
		}
		
		protected function startTweening0(newPosition:Number):void {
			TweenLite.to(pointer0, time, {y:limit2 - newPosition, ease:ease1, onUpdate:uFunction, onUpdateParams:[pointer0], onComplete:nextPoint});
		}

		private function nextPoint():void {
			oldPPosition = newPPosition;
			if(loopID!="") {
				completeNextVelocityID(loopID);
			} else completeNextVelocity();
		}



		protected function uFunction(obj:Object):void {
			// Must be overriden by sub class
		}
			
		protected function uFunction0(n1:Number):void {
			
			var parentObj = parent;
			if((n1>=xPoint) && (oldPPosition<newPPosition) && xPoint!=0) {
				parentObj.completeXElementByID(xElement);
				xPoint = 0;
			}
			if((n1<=xPoint) && (oldPPosition>newPPosition) && xPoint!=0) {
				parentObj.completeXElementByID(xElement);
				xPoint = 0;
			}
			correctPointerPosition();
		}


		protected function correctPointerPosition():void {
			var rZ:Number = pointer0.y;
			if(rZ<limit1) rZ=limit1;
			if(rZ>limit2) rZ=limit2;
			pointer.y = rZ;
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