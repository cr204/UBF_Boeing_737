package com.winglet.assets.screens {
	
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	
	public class SpeedTapeNumbers extends Sprite {
		private var currN1:int = 0;
		private var currN2:int = 0;
		private var currN3:int = 0;
		
		public function SpeedTapeNumbers() {
			// constructor code
			n1.cacheAsBitmap = true;
			n2.cacheAsBitmap = true;
			n3.cacheAsBitmap = true;
		}
		
		public function setNumbers(n:Number):void {
			var t1:String = n.toString();

			var m:Number = 0;
			m = Number(t1.substr(t1.length-1, 1));
			jumpNumberSetTo0(n3, m);
			
			var num:Number = Number( String( n ).split( "." )[ 1 ] );
			if(Number(num)) num=Number("."+num) else num=0;
			
			if(t1.length>1) {
				if(!n2.visible) n2.visible = true;
				m = int(t1.substr(t1.length-2, 1));
//				m += num;
				jumpNumberSetTo(n2, m);
			} else n2.visible = false;
			if(t1.length>2) {
				if(!n1.visible) n1.visible = true;
				m = int(t1.substr(t1.length-3, 1));
				jumpNumberSetTo(n1, m);
			} else n1.visible = false;

		}
		
		public function updateNumbers(n:Number):void {
			var t1:String = String(Math.floor(n));

			var m:Number = 0;
			m = Number(t1.substr(t1.length-1, 1));
			
			var num:Number = Number( String( n ).split( "." )[ 1 ] );
			if(Number(num)) num=Number("."+num) else num=0;
			
			
//			if(m!=currN3) {
				if(currN3==0 && m==9) n3.y=147;
				if(currN3==9 && m==0) n3.y=7;
				m = m + num;
				slideNumberSetTo0(n3, m);
				currN3 = m;
//			}
			
			if(t1.length>1) {
				m = int(t1.substr(t1.length-2, 1));
				if(m!=currN2) {
					if(!n2.visible) n2.visible = true;
					if(currN2==0 && m==9) n2.y=226;
					if(currN2==9 && m==0) n2.y=7;
					slideNumberSetTo(n2, m);
					currN2 = m;
				}
			}
			if(t1.length>2) {
				m = int(t1.substr(t1.length-3, 1));
				if(m!=currN1) {
					if(!n1.visible) n1.visible = true;
					if(currN1==0 && m==9) n1.y=226;
					if(currN1==9 && m==0) n1.y=7;
					slideNumberSetTo(n1, m);
					currN1 = m;
				}
			}
			

			
		}


		private function jumpNumberSetTo0(ns:Sprite, num:Number):void {
			var newPosY:Number = 7 + 14 * num;
			ns.y = newPosY;
		}
		
		private function slideNumberSetTo0(ns:Sprite, num:Number):void {
			var newPosY:Number = 7 + 14 * num;
			ns.y = newPosY;
			//TweenLite.to(ns, .2, {y:newPosY});
		}

		private function jumpNumberSetTo(ns:Sprite, num:int):void {
			var newPosY:Number = 7 + 22 * num;
			ns.y = newPosY;
		}
		
		private function slideNumberSetTo(ns:Sprite, num:int):void {
			var newPosY:Number = 7 + 22 * num;
			//ns.y = newPosY;
			TweenLite.to(ns, .5, {y:newPosY, overwrite:true});
			//TweenLite.to(pointer0, time, {rotationZ:newPosition, delay:waitTime, ease:ease1, onUpdate:uFunction, onUpdateParams:[pointer0]});
		}
		
		
	}
}