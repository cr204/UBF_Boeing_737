package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	
	public class AltimeterGreenNumbers extends Sprite {
		private var currN1:int = 0;
		private var currN2:int = 0;
		private var currN3:int = 0;
		
		public function AltimeterGreenNumbers() {
			// constructor code
			n1.cacheAsBitmap = true;
			n2.cacheAsBitmap = true;
			n3.cacheAsBitmap = true;
			n4.cacheAsBitmap = true;
		}
		
		public function setNumbers(n:Number):void {
			var t1:String = Number(n/100).toFixed(2);

			var tn1:String = t1.substr(0, t1.indexOf(".", 0));   //t1.substr(0, 1) + ".";
			var tn2:String = t1.substr(t1.indexOf(".", 0) + 1, 2);  //t1.substr(2, 2);

			var m:int = 0;
			m = int(tn1.substr(tn1.length-1, 1));
			jumpNumberSetTo(n3, m);
			
			if(tn1.length>1) {
				if(!n2.visible) n2.visible = true;
				m = int(tn1.substr(tn1.length-2, 1));
				jumpNumberSetTo(n2, m);
			} else n2.visible = false;
			if(tn1.length>2) {
				if(!n1.visible) n1.visible = true;
				m = int(tn1.substr(tn1.length-3, 1));
				jumpNumberSetTo(n1, m);
			} else n1.visible = false;
			if(tn2 != "00") {
				m = Number(tn2) * 56.5 / 100; 
				n4.y = m;
			}
			
		}
		
		public function updateNumbers(n:Number):void {
			var t1:String = Number(n/100).toFixed(2);

			var tn1:String = t1.substr(0, t1.indexOf(".", 0));
			var tn2:String = t1.substr(t1.indexOf(".", 0) + 1, 2);
		
			var m:int = 0;
			m = int(tn1.substr(tn1.length-1, 1));
			if(m!=currN3) {
				if(currN3==0 && m==9) n3.y=226;
				if(currN3==9 && m==0) n3.y=6.2;
				slideNumberSetTo(n3, m);
				currN3 = m;
			}
			
			if(tn1.length>1) {
				m = int(tn1.substr(tn1.length-2, 1));
				if(m!=currN2) {
					if(!n2.visible) n2.visible = true;
					if(currN2==0 && m==9) n2.y=226;
					if(currN2==9 && m==0) n2.y=6.2;
					slideNumberSetTo(n2, m);
					currN2 = m;
				}
			}
			if(tn1.length>2) {
				m = int(tn1.substr(tn1.length-3, 1));
				if(m!=currN1) {
					if(!n1.visible) n1.visible = true;
					if(currN1==0 && m==9) n1.y=226;
					if(currN1==9 && m==0) n1.y=6.2;
					slideNumberSetTo(n1, m);
					currN1 = m;
				}
			}
		
			if(tn2 != "00") {
				m = Number(tn2) * 1.1; 
				n4.y = m;
			}
		
		}



		private function jumpNumberSetTo(ns:Sprite, num:int):void {
			var newPosY:Number = 6 + 22 * num;
			ns.y = newPosY;
		}
		
		private function slideNumberSetTo(ns:Sprite, num:int):void {
			var newPosY:Number = 6 + 22 * num;
			//ns.y = newPosY;
			TweenLite.to(ns, .5, {y:newPosY, overwrite:true});
			//TweenLite.to(pointer0, time, {rotationZ:newPosition, delay:waitTime, ease:ease1, onUpdate:uFunction, onUpdateParams:[pointer0]});
		}
		
		
		
		
	}
}