package com.winglet.qrh {
	
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.events.TouchEvent;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	public class Slider extends MovieClip {
		
		private var boundsRect:Rectangle;
		private var knobWidth:Number;
		private var trackWidth:Number;
		private var trackX:Number;
		private var boundWidth;
		private var pointPos:Array;
		private var halfmargin:Number = 19.5;
		
		public function Slider() {
			// constructor code
			pointPos = new Array(0,point5.x,point10.x,point15.x,point20.x,point25.x,point30.x,point35.x);
			//trace(pointPos[0]);
			knobWidth = knob.width;
			trackWidth = track.width;
			trackX = track.x;
			fillArea.scaleX=0;
			boundWidth = trackWidth + knobWidth/2;
			boundsRect = new Rectangle(trackX, (knob.hitMc.height/2-8), boundWidth - knobWidth/2, 0);
			knob.buttonMode = true;
			track.buttonMode = true;
			
			/*Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			knob.addEventListener(TouchEvent.TOUCH_BEGIN,startDragging);
			knob.addEventListener(TouchEvent.TOUCH_END,stopDragging);*/
			
			knob.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
			this.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			//knob.addEventListener(MouseEvent.MOUSE_OUT, releaseOutsideHandler);
			//track.addEventListener(MouseEvent.CLICK, snapTo);
			}
	
	
	private function startDragging(event:MouseEvent) {
		knob.startDrag(false, boundsRect);
		//addEventListener(Event.ENTER_FRAME , test)
		
		//trace(this.mouseX)
	}
	// Stop drag
	
	private function stopDragging(event:MouseEvent) {
		knob.stopDrag();
		//removeEventListener(Event.ENTER_FRAME , test)
		test();
		}
		
		private function test():void{
			if(knob.x < pointPos[0]+20){
				knob.x =  pointPos[0]
			}
			if(knob.x > pointPos[0]+20 && knob.x <pointPos[1]){
				knob.x =  pointPos[1]
			}
			if(knob.x < pointPos[1]+20 && knob.x > pointPos[1]){
				knob.x =  pointPos[1]
			}
			
			if(knob.x > pointPos[1]+20 && knob.x < pointPos[2]){
				knob.x =  pointPos[2]
			}
			
			
			if(knob.x < pointPos[2]+20 && knob.x > pointPos[2]){
				knob.x =  pointPos[2]
			}
			
			if(knob.x > pointPos[2]+20 && knob.x < pointPos[3]){
				knob.x =  pointPos[3]
			}
			
			if(knob.x < pointPos[3]+20 && knob.x > pointPos[3]){
				knob.x =  pointPos[3]
			}
			
			if(knob.x > pointPos[3]+20 && knob.x < pointPos[4]){
				knob.x =  pointPos[4]
			}
			
			if(knob.x < pointPos[4]+20 && knob.x > pointPos[4]){
				knob.x =  pointPos[4]
			}
			
			if(knob.x > pointPos[4]+20 && knob.x < pointPos[5]){
				knob.x =  pointPos[5]
			}
			
			
			if(knob.x < pointPos[5]+20 && knob.x > pointPos[5]){
				knob.x =  pointPos[5]
			}
			
			if(knob.x > pointPos[5]+20 && knob.x < pointPos[6]){
				knob.x =  pointPos[6]
			}
			
			if(knob.x < pointPos[6]+20 && knob.x > pointPos[6]){
				knob.x =  pointPos[6]
			}
			
			if(knob.x > pointPos[6]+20 && knob.x < pointPos[7]){
				knob.x =  pointPos[7]
			}
			
			if(knob.x < pointPos[7]+20 && knob.x > pointPos[7]){
				knob.x =  pointPos[7]
			}
			
			if(knob.x > pointPos[7]+20 && knob.x < pointPos[8]){
				knob.x =  pointPos[8]
			}
			
			
		fillLine();
		}
		
		private function fillLine():void{
//			Tweener.addTween(fillArea,{scaleX:Number(knob.x/trackWidth),time:0.5, transition:"linear"});
			TweenLite.to(fillArea, .5, {scaleX:Number(knob.x/trackWidth),  ease:Linear.easeNone});
		}
	
	
	private function snapTo(event:MouseEvent) {
		//MovieClip(parent).mouse_txt.text = "Mouse X on slider is: "+ mouseX;
		if (mouseX < boundWidth && mouseX > knobWidth) {
			knob.x = mouseX;
		}
	}
	}
	
}
