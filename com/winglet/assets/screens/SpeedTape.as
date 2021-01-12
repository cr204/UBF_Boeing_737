package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import fl.motion.easing.*;
	import com.winglet.utils.ProjectUtils;
	
	public class SpeedTape extends Sprite {
		private var prevSB_posY:Number;
		private var parentObj:*;
		private var speedPosition:Number = 0;
		private var time:Number = 0;
		private var ease1:Object;
		private var waitTime:Number = 0;
		
		public function SpeedTape() {
			// constructor code
			this.mouseChildren = false;
			this.cacheAsBitmap = true;
			parentObj = parent;
			prevSB_posY = speed_bug.y;
		}
		
		public function setSpeedPosition(n:Number):void {
			var nextYPos:Number = getIAS_Y(n);
			this.y = nextYPos;
			parentObj.speedGreenNumbers.setNumbers(n);
		}
		
		public function updateSpeedPosition(objXML:XML):void {
			// This time altPosition takes @value tag from XML!!!
			speedPosition = Number(objXML.@value.toString());
			time = Number(objXML.@time.toString());
			ease1 = ProjectUtils.getInstance().getEaseType(objXML.@ease.toString());
			waitTime = Number(objXML.@wait.toString());
			
			var newPosY:Number = getIAS_Y(speedPosition);
			TweenLite.to(this, time, {y:newPosY, delay:waitTime, overwrite:false, ease:ease1, onUpdate:uFunction, onUpdateParams:[this]});
		}
		
		public function setBugPosition(xml:XML):void {
			var next_posY:Number = Number(xml.@value);
			var time:Number = Number(xml.@time);
			var ease1:String = xml.@ease.toString();
			
			var posY:Number = 836 - next_posY * 1.78;
			TweenLite.to(speed_bug, time, {y:posY, overwrite:false, ease:ease1});
		}
		
		private function uFunction(obj:Object):void {
			//var newPos:Number = Math.floor((obj.y + 661) / 1.79);
			var newPos:Number = (obj.y + 661) / 1.79;
			newPos = Number(newPos.toFixed(1));
			parentObj.speedGreenNumbers.updateNumbers(newPos);
		}
		
		
		public function setRedBarbersPolePosition(n:Number):void {
//			var newYPos:Number = 359 + (300 - n) * 2;
//			high_speed_barbers_pole.y = newYPos;
			//trace("newYPos: " + newYPos);
		}
		
		public function reset():void {
			speed_bug.y = 544.4;
			TweenLite.killTweensOf(speed_bug);
		}
		
		private function getIAS_Y(n:Number):Number {
			if(n<20) n=20;
			var ret:Number = -661;
			ret = n * 1.79 + ret;
			return ret;
		}
		
		
	}
}