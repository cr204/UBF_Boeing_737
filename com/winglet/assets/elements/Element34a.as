package com.winglet.assets.elements {
	import flash.display.Sprite;
	
	public class Element34a extends Sprite {
		public var maxNumber:Number = 0;
		public var range:Number = 10;
		private var lastNumber:Number = 0;
		
		public function Element34a() {
			// constructor code
		}
		
		public function incNumber():Number {
			lastNumber += range;
			if(lastNumber>maxNumber) lastNumber=maxNumber;
			setNumber(lastNumber);
			return lastNumber;
		}
		
		public function decNumber():Number {
			lastNumber -= range;
			if(lastNumber<0) lastNumber=0;
			setNumber(lastNumber);
			return lastNumber;
		}

		
		public function setNumber(n:Number):void {
			var str:String = n.toString();
			var arr:Array = str.split("");
			switch(arr.length) {
				case 5:
					showNumbers(arr);
					break;
				case 4:
					arr.unshift("0");
					showNumbers(arr);
					break;
				case 3:
					arr.unshift("0");
					arr.unshift("0");
					showNumbers(arr);
					break;
				case 2:
					arr.unshift("0");
					arr.unshift("0");
					arr.unshift("0");
					showNumbers(arr);
					break;
				case 1:
					arr.unshift("0");
					arr.unshift("0");
					arr.unshift("0");
					arr.unshift("0");
					showNumbers(arr);
					break;
				default:
					trace("Eleemnt34.Error! LCD number length: " + arr.length);
					break;
			}
			lastNumber = n;
		}
		
		
		private function showNumbers(arr:Array):void {
			d1.gotoAndStop(int(arr[0]) + 1);
			d2.gotoAndStop(int(arr[1]) + 1);
			d3.gotoAndStop(int(arr[2]) + 1);
			d4.gotoAndStop(int(arr[3]) + 1);
			d5.gotoAndStop(int(arr[4]) + 1);
		}
		
		public function resetLCD():void {
			lastNumber = 0;
			d1.gotoAndStop(1);
			d2.gotoAndStop(1);
			d3.gotoAndStop(1);
			d4.gotoAndStop(1);
			d5.gotoAndStop(1);
		}
		
	}
	
}