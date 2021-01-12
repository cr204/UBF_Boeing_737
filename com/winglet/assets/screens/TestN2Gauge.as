package com.winglet.assets.screens {
	
	import com.greensock.TweenLite;
	import com.winglet.assets.screens.GaugeBase;
	
	import com.terrypaton.graphics.DrawPieChart;
	import com.winglet.utils.ProjectUtils;
	import flash.display.Shape;
	import com.winglet.Colors;
	
	public class TestN2Gauge extends GaugeBase {
		private var m1:Number;
		private var segment:Shape;
		
		public function TestN2Gauge() {
			// constructor code
			init();
			segment = new Shape();
			segment.x = 29;
			segment.y = 16.5;
			addChildAt(segment, 0);
		}
		
		private function init():void {
			limit1 = 0;
			limit2 = 210;
			number1 = 0;
			number2 = 105;
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
		
		override protected function startTweening():void {
			var newPosition:Number = limit1 + (pointerPosition - number1) * m1;
			super.startTweening0(newPosition);
		}
		
		override protected function uFunction(obj:Object):void {
			var n1:Number = (obj.rotationZ - limit1) / m1 + number1;
			showNumber(n1);
			drawBGChart(n1)
			super.uFunction0(n1);
		}
		
		
		
		private function showNumber(n:Number):void {
			txt1.text = n.toString();
			if(n>=105 && systemColor!=Colors.GAUGE_RED) {
				systemColor = Colors.GAUGE_RED;
				ProjectUtils.getInstance().tintClip(pointer, Colors.GAUGE_RED);
				ProjectUtils.getInstance().tintClip(txt1, Colors.GAUGE_RED);
				ProjectUtils.getInstance().tintClip(numBorder, Colors.GAUGE_RED);
				ProjectUtils.getInstance().tintClip(segment, Colors.GAUGE_RED);
			}
			if(n<105 && systemColor!=Colors.WHITE) {
				systemColor = Colors.WHITE;
				ProjectUtils.getInstance().tintClip(pointer, Colors.WHITE);
				ProjectUtils.getInstance().tintClip(txt1, Colors.WHITE);
				ProjectUtils.getInstance().tintClip(numBorder, Colors.WHITE);
				ProjectUtils.getInstance().tintClip(segment, Colors.WHITE);
			}
		}
		
		private function drawBGChart(n:Number):void {
			if(n<number1) n=number1;
			if(n>number2) n=number2;
			var percent:Number = n / number2 * .58;
			DrawPieChart.drawChart(segment, 28.5, percent, 0xFFFFFF, 0);
		}
		
	}
}