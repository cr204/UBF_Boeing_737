package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import com.winglet.utils.ProjectUtils;
	
	public class AltimeterTape extends Sprite {
		private var limit1:int = -1020;
		private var limit2:int = 40;
		
		private var altPosition:Number = 0;
		private var time:Number = 0;
		private var ease1:Object;
		private var xPoint:Number = 0;
		private var xElement:String;
		private var waitTime:Number = 0;
		private var loopID:String;
		private var velocitiesArr:Array = [];
		private var currVel:int = -1;
		private var newPPosition:Number = 0;
		private var oldPPosition:Number = 0;
		private var parentObj:*;
		private var altitudeMaker:Number;
		
		public function AltimeterTape() {
			// constructor code
			this.mouseChildren = false;
			parentObj = parent;
//			altitude_marker.visible = false;
//			altNumbers.altitude_marker.y = -5.5
			altNumbers.cacheAsBitmap = true;
		}
		
		public function setAltPosition(n:Number):void {
			TweenLite.killTweensOf(altNumbers);
			TweenLite.killTweensOf(this);
			var newPosY:Number = 100 - (27.5 * (430 - n/100));
			altNumbers.y = newPosY;
			parentObj.altGreenNumbers.setNumbers(n);
			oldPPosition = n;
			currVel = -1;
			
			TweenLite.to(this, 0, {delay:.5, overwrite:false, onComplete:function(){ parentObj.altGreenNumbers.setNumbers(n) }});
//			setAltitudeMarker(n);
		}
		
		
		public function updateAltPosition(objXML:XML):void {
			// This time altPosition takes @value tag from XML!!!
			altPosition = Number(objXML.@value.toString()) / 100;
			time = Number(objXML.@time.toString());
			ease1 = ProjectUtils.getInstance().getEaseType(objXML.@ease.toString());
			xPoint = Number(objXML.@xpoint.toString());
			xElement = objXML.@xelement.toString();
			waitTime = Number(objXML.@wait.toString());
			
//			var newPosY:Number = 0 - (425 - altPosition) * 18.89;
			var newPosY:Number = 100 - (27.5 * (430 - altPosition));
			TweenLite.to(altNumbers, time, {y:newPosY, delay:waitTime, overwrite:false, ease:ease1, onUpdate:uFunction, onUpdateParams:[altNumbers]});
		}
		
		// setVelocitiesArr
		public function setVelocitiesArr(arr:Array):void {
			velocitiesArr = arr;
			completeNextVelocity();
		}
		
		public function get getALT():Number {
			var ret:Number = 0;
			ret = Number((altNumbers.y / 18.89 + 425).toFixed(2)) * 100;
			return ret;
		}
		
		public function setAltitudeMarker(n:Number):void {
			altitudeMaker = n;
//			altNumbers.altitude_marker.txt1.text = String(Math.round(n / 100));
//			altNumbers.altitude_marker.y = -5.5 + Math.round((43000 - n) / 100) * 18.89;
//			parentObj.altitude_marker_number.txt1.text = "FL" + String(Math.floor(n / 100));
			parentObj.altitude_marker_number.setNumber(n);
//			checkAltMarkerNumber(Math.round(altNumbers.y));
		}
		
		private function completeNextVelocity():void {
			++currVel;
			if(currVel<velocitiesArr.length){
				updatePointerPosition1(velocitiesArr[currVel]);
			} else {
				trace("stop");
			}
		}

		private function completeNextVelocityID(sID:String):void {
			var n:int = getVelocityIndexByID(sID);
			if(n<0) {
				trace("Error! Velocity ID: " + sID + " was not found in loop!");
			} else {
				currVel = n-1;
				completeNextVelocity();
			}
		}
		
		private function updatePointerPosition1(objXML:XML):void {
			altPosition = Number(objXML.@altPosition.toString()) / 100;
			time = Number(objXML.@time.toString());
			ease1 = ProjectUtils.getInstance().getEaseType(objXML.@ease.toString());
			xPoint = Number(objXML.@xpoint.toString()) / 100;
			xElement = objXML.@xelement.toString();
			loopID = objXML.@loop.toString();
			waitTime = Number(objXML.@wait.toString());
			
//			trace(currVel + ".  Pos: " + altPosition + "  - Time: " + time);
			
			newPPosition = altPosition;
			if(waitTime>0) {
				trace("waiting!");
				TweenLite.to(this, waitTime, {onComplete:startTweening});
			} else if(waitTime==0) {
				startTweening();
			}
		}
		
		private function startTweening():void {
			var newPosY:Number = 0 - (425 - altPosition) * 18.89;
//			trace("newPosY: " + newPosY + "  - time: " + time + "  ease1: " + ease1);
			TweenLite.to(altNumbers, time, {y:newPosY, delay:waitTime, overwrite:false, ease:ease1, onUpdate:uFunction, onUpdateParams:[altNumbers], onComplete:nextPoint});
		}

		private function nextPoint():void {
			oldPPosition = newPPosition;
			if(loopID!="") {
				completeNextVelocityID(loopID);
			} else completeNextVelocity();
		}
		
		private function getVelocityIndexByID(sID:String):int {
			var ret:int = -1;
			for(var i:int=0; i<velocitiesArr.length; ++i) {
				var tID:String = velocitiesArr[i].@id.toString();
				if(tID==sID) ret=i;
			}
			return ret;
		}
		
		private function uFunction(obj:Object):void {
			var newPos:Number = Math.floor((430 - (100 - obj.y)/27.5) * 100);
//			checkAltMarkerNumber(Math.round(obj.y));
			
			parentObj.altGreenNumbers.updateNumbers(newPos);
			var mainTL = root;
//			mainTL.screenOperations.completeScreenMathCalculations();

			var n1:Number = Math.round(altNumbers.y / 18.89 + 425);
			if((n1>=xPoint) && (oldPPosition<newPPosition) && xPoint!=0) {
				parentObj.completeXElementByID(xElement);
				xPoint = 0;
			}
			if((n1<=xPoint) && (oldPPosition>newPPosition) && xPoint!=0) {
				parentObj.completeXElementByID(xElement);
				xPoint = 0;
			}
		}
		
/*		private function checkAltMarkerNumber(n:Number):void {
//			var n0:Number = -1 * altNumbers.altitude_marker.y;
			var tempS:String = parentObj.altitude_marker_number.txt1.text;
			
//			var newPosY:Number = 0 - (425 - altPosition) * 18.89;
			var n1:Number = Math.round((n / 18.89  + 425) * 100);
			
//			trace("n1: " + n1);
//			trace("altitudeMaker: " + altitudeMaker);
			if(n1<altitudeMaker) {
				parentObj.altitude_marker_number.gotoAndStop(2);
				parentObj.altitude_marker_number.txt1.text = tempS;
			} else {
				parentObj.altitude_marker_number.gotoAndStop(1);
				parentObj.altitude_marker_number.txt1.text = tempS;
			}
			
		}*/
		
		
	}
}