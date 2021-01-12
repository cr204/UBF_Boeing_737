package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.display.Shape;
	import com.greensock.TweenLite;
	import fl.motion.easing.*;
	import com.terrypaton.graphics.DrawPieChart;
	import com.winglet.utils.ProjectUtils;
	
	public class N1_Gauge extends Sprite {
		private var limit1:int = 0;
		private var limit2:int = 210;
		private var number1:Number = 0;
		private var number2:Number = 104;
		private var m1:Number = new Number();
		
		private var pointerPosition:Number = 0;
		private var time:Number = 0;
		private var ease1:Object;
		private var xPoint:Number = 0;
		private var xElement:String;
		private var loopID:String;
		private var newPPosition:Number = 0;
		private var oldPPosition:Number = 0;
		private var waitTime:Number = 0;
		private var velocitiesArr:Array = [];
		private var currVel:int = -1;
		
		private var segment:Shape;
		
		public function N1_Gauge() {
			//pointer.rotationZ = limit2;
			pointer0.visible = false;
			segment = new Shape();
			segment.x = 35.5;
			segment.y = 19.5;
			addChildAt(segment, 0);
			var percent:Number = 0;
		}
		
		
		public function setPointerPosition(n:Number):void {
			var m:Number = (0 - limit1 + limit2) / (number2 - number1);
			var newPosition:Number = limit1 + (n - number1) * m;
			pointer0.rotationZ = newPosition;
			correctPointerPosition();
			txt1.text = n.toFixed(1);
			drawBGChart(n);
			oldPPosition = n;
			currVel = -1;
			TweenLite.killTweensOf(pointer);
			TweenLite.killTweensOf(pointer0);
		}
		

		
		public function updatePointerPosition(objXML:XML):void {
			// This time pointerPosition takes @value tag from XML!!!
			pointerPosition = Number(objXML.@value.toString());
			time = Number(objXML.@time.toString());
			//ease1 = getEaseType(objXML.@ease.toString());
			ease1 = ProjectUtils.getInstance().getEaseType(objXML.@ease.toString());
			xPoint = Number(objXML.@xpoint.toString());
			xElement = objXML.@xelement.toString();
			waitTime = Number(objXML.@wait.toString());
			
			newPPosition = pointerPosition;
			m1 = (0 - limit1 + limit2) / (number2 - number1);
			var newPosition:Number = limit1 + (pointerPosition - number1) * m1;
			TweenLite.to(pointer0, time, {rotationZ:newPosition, delay:waitTime, ease:ease1, onUpdate:uFunction, onUpdateParams:[pointer0]});
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
				trace("Error! Velocity ID: " + sID + " was not found in N1Gauge1.as loop!");
			} else {
				currVel = n-1;
				completeNextVelocity();
			}
		}
		
		private function updatePointerPosition1(objXML:XML):void {
			pointerPosition = Number(objXML.@pointerPosition.toString());
			time = Number(objXML.@time.toString());
			//ease1 = getEaseType(objXML.@ease.toString());
			ease1 = ProjectUtils.getInstance().getEaseType(objXML.@ease.toString());
			xPoint = Number(objXML.@xpoint.toString());
			xElement = objXML.@xelement.toString();
			loopID = objXML.@loop.toString();
			waitTime = Number(objXML.@wait.toString());
			
			newPPosition = pointerPosition;
			if(waitTime>0) {
//				trace("waiting!");
				TweenLite.to(this, waitTime, {onComplete:startTweening});
			} else if(waitTime==0) {
				startTweening();
			}
		}
		
		private function startTweening():void {
			m1 = (0 - limit1 + limit2) / (number2 - number1);
			var newPosition:Number = limit1 + (pointerPosition - number1) * m1 - 8;
			TweenLite.to(pointer0, time, {rotationZ:newPosition, ease:ease1, onUpdate:uFunction, onUpdateParams:[pointer0], onComplete:nextPoint});
		}

		private function nextPoint():void {
			oldPPosition = newPPosition;
			if(loopID!="") {
				completeNextVelocityID(loopID);
			} else completeNextVelocity();
		}
		
		private function uFunction(obj:Object):void {
			var n1:Number = (obj.rotationZ - limit1 + 8) / m1 + number1;
			showNumber(n1);
			
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

		
		private function showNumber(n:Number):void {
/*			var t1:String = n.toFixed(1);
			txt1.text = t1.substr(0, t1.indexOf(".", 0)) + "."; // t1.substr(0, 2) + ".";
			txt2.text = t1.substr(t1.indexOf(".", 0) + 1, 1); //t1.substr(3, 1);
			
			if(n>100 && systemColor!=0xFF0000) {
//				trace("turn red");
				systemColor = 0xFF0000;
				//tintClip(pointer, 0xFF0000);
				ProjectUtils.getInstance().tintClip(pointer, 0xFF0000);
				tintClip(txt1, 0xFF0000);
				tintClip(txt2, 0xFF0000);
			}
			if(n<=100 && systemColor!=0x18F360) {
//				trace("turn green");
				systemColor = 0x18F360;
				tintClip(pointer, 0x18F360);
				tintClip(txt1, 0x18F360);
				tintClip(txt2, 0x18F360);
			}*/
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		private function correctPointerPosition():void {
			var rZ:Number = pointer0.rotationZ;
			if(rZ<limit1) rZ=limit1;
			if(rZ>limit2) rZ=limit2;
			pointer.rotationZ = rZ;
		}
		
		private function drawBGChart(n:Number):void {
			if(n<number1) n=number1;
			if(n>number2) n=number2;
			var percent:Number = n / number2 * .58;
			DrawPieChart.drawChart(segment, 28.5, percent, 0x666666, 0);
		}
		
		private function getVelocityIndexByID(sID:String):int {
			var ret:int = -1;
			for(var i:int=0; i<velocitiesArr.length; ++i) {
				var tID:String = velocitiesArr[i].@id.toString();
				if(tID==sID) ret=i;
			}
			return ret;
		}

/*		private function getEaseType(s:String):Object {
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
				case "":
					break;

				default:
					trace("Error! Unknown ease type: '" + s + "' in APUEGTGauge.as");
					break;
			}
			return ret;
		}

		private function tintClip(obj:*, c:uint):void {
			var color:uint=c; //picker.selectedColor;
			var mul:Number=1; //slider.value/100;
			var ctMul:Number=(1-mul);
			var ctRedOff:Number=Math.round(mul*extractRed(color));
			var ctGreenOff:Number=Math.round(mul*extractGreen(color));
			var ctBlueOff:Number=Math.round(mul*extractBlue(color));
			ct=new ColorTransform(ctMul,ctMul,ctMul,1,ctRedOff,ctGreenOff,ctBlueOff,0);
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
		}*/
	
	}
}