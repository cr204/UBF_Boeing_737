﻿package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import com.winglet.utils.ProjectUtils;
	import flash.geom.Point;
	
	public class BrakePressureGauge extends Sprite {
		private var time:Number = 0;
		private var ease1:Object;
		private var loopID:String;
		private var waitTime:Number;
		private var nextPosition:Number;
		private var oldPPosition:Number = 0;
		private var pointer0:Point = new Point();
		
		public function BrakePressureGauge() {
			// constructor code
			//pointer.rotationZ = 160;
			//pointer.rotationZ = 425;
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
			if(n<0) n=0;
			if(n>4) n=4;
			var valueZ:Number = 160 + n * 66.25;
			pointer.rotationZ = valueZ;
		}
		
		public function resetElement():void {
			pointer.rotationZ = 0;
		}
		
		
	}
}