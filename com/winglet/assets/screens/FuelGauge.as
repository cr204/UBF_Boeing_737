package com.winglet.assets.screens {
	
	import com.greensock.TweenLite;
	import com.winglet.assets.screens.GaugeBase;
	
	import com.terrypaton.graphics.DrawPieChart;
	import com.winglet.utils.ProjectUtils;
	import flash.display.Shape;
	import flash.display.MovieClip;
	
	public class FuelGauge extends GaugeBase {
		private var m1:Number;
		private var segment:Shape;
		private var pointer:MovieClip = new MovieClip();
		private var pointer0:MovieClip = new MovieClip();
		
		public function FuelGauge() {
			// constructor code
			init();
			segment = new Shape();
			segment.x = 22.5;
			segment.y = 22.5;
			addChildAt(segment, 0);
		}
		
		private function init():void {
			limit1 = 0;
			limit2 = 300;
			number1 = 0;
			number2 = 4000;
			m1 = (0 - limit1 + limit2) / (number2 - number1);
			super.initBase(pointer, pointer0);
		}
		
		
		public function setPointerPosition(n:Number):void {
			var m:Number = (limit2 - limit1) / (number2 - number1);
			var newPosition:Number = limit1 + (n - number1) * m;
			super.setBasePointerPosition(newPosition);
			drawBGChart(n);
			
			showNumber(n);
			oldPPosition = n;
		}
		
		public function updatePointerPosition(objXML:XML):void {
			var m:Number = (limit2 - limit1) / (number2 - number1);
			var newPosition:Number = limit1 + (Number(objXML.@value) - number1) * m;
			super.updateBasePointerPosition(objXML, newPosition);
		}
		
		public function updateColor(s:String):void {
			var col:uint = 0xFFFFFF;
			if(s=="amber") col = 0xFF9900;
			ProjectUtils.getInstance().tintClip(segment, col);
			ProjectUtils.getInstance().tintClip(txt1, col);
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
		
		public function resetAsset():void {
			setPointerPosition(0);
			ProjectUtils.getInstance().tintClip(segment, 0xFFFFFF);
			ProjectUtils.getInstance().tintClip(txt1, 0xFFFFFF);
		}		
		
		private function showNumber(n:Number):void {
			txt1.text = n.toString();
		}
		
		private function drawBGChart(n:Number):void {
			if(n<number1) n=number1;
			if(n>number2) n=number2;
			var percent:Number = n / number2 * .68;
			DrawPieChart.drawChart(segment, 23, percent, 0xFFFFFF, 147, 1);
		}		
		
		
	}
}