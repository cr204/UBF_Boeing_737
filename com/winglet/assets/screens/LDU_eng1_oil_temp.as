﻿package com.winglet.assets.screens {
	
	import com.greensock.TweenLite;
	import com.winglet.utils.ProjectUtils;
	import com.winglet.Colors;
	import com.winglet.assets.screens.VerticalGaugeBase;
	
	public class LDU_eng1_oil_temp extends VerticalGaugeBase {
		private var m1:Number;
		
		public function LDU_eng1_oil_temp() {
			// constructor code
			init();
		}
		
		private function init():void {
			limit1 = 0;
			limit2 = 35;
			number1 = 0;
			number2 = 165;
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
			
			if(n<160 && systemColor!=Colors.WHITE) {
				systemColor = Colors.WHITE;
				ProjectUtils.getInstance().tintClip(pointer, systemColor);
				ProjectUtils.getInstance().tintClip(txt, systemColor);
				ProjectUtils.getInstance().tintClip(numBorder, systemColor);
			}
			if(n>=160 && n<165 && systemColor!=Colors.YELLOW) {
				systemColor = Colors.YELLOW;
				ProjectUtils.getInstance().tintClip(pointer, systemColor);
				ProjectUtils.getInstance().tintClip(txt, systemColor);
				ProjectUtils.getInstance().tintClip(numBorder, systemColor);
			}
			if(n>=165 && systemColor!=Colors.RED) {
				systemColor = Colors.RED;
				ProjectUtils.getInstance().tintClip(pointer, systemColor);
				ProjectUtils.getInstance().tintClip(txt, systemColor);
				ProjectUtils.getInstance().tintClip(numBorder, systemColor);
			}
		}
		
	}
}