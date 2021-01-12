package com.winglet.assets.screens {
	
	import com.greensock.TweenLite;
	import com.winglet.utils.ProjectUtils;
	import com.winglet.Colors;
	import com.winglet.assets.screens.VerticalGaugeBase;
	import flash.display.MovieClip;
	
	public class LDU_eng1_oil_qty extends VerticalGaugeBase {
		private var m1:Number;
		private var pointer0:MovieClip = new MovieClip();
		private var pointer:MovieClip = new MovieClip();
		
		public function LDU_eng1_oil_qty() {
			// constructor code
		init();
		}
		
		private function init():void {
			lo.visible = false;
			limit1 = 0;
			limit2 = 35;
			number1 = 0;
			number2 = 99;
			m1 = (0 - limit1 + limit2) / (number2 - number1);
			super.initBase(pointer, pointer0);
		}
		
		public function setPointerPosition(n:Number):void {
			var m:Number = (limit2 - limit1) / (number2 - number1);
			var newPosition:Number = limit1 + (n - number1) * m;
			super.setBasePointerPosition(newPosition);
			showNumber(n);
			oldPPosition = n;
		}

		public function updatePointerPosition(objXML:XML):void {
			var m:Number = (limit2 - limit1) / (number2 - number1);
			var newPosition:Number = limit1 + (Number(objXML.@value) - number1) * m;
			super.updateBasePointerPosition(objXML, newPosition);
		}
		
		override protected function startTweening():void {
			var newPosition:Number = limit1 + (pointerPosition - number1) * m1;
			super.startTweening0(newPosition);
		}

		override protected function uFunction(obj:Object):void {
			var n1:Number = (obj.rotationZ - limit1) / m1 + number1;
			showNumber(n1);
			super.uFunction0(n1);
		}
		
		
		private function showNumber(n:Number):void {
			txt.text = n.toFixed(1);
			
			if(n<=3 && systemColor!=Colors.BLACK) {
				systemColor = Colors.BLACK;
				ProjectUtils.getInstance().tintClip(txt, systemColor);
				numBorder.gotoAndStop(2);
				lo.visible = true;
			}
			if(n>3 && systemColor!=Colors.WHITE) {
				systemColor = Colors.WHITE;
				ProjectUtils.getInstance().tintClip(txt, systemColor);
				numBorder.gotoAndStop(1);
				lo.visible = false;
			}
		}
		
	}
}