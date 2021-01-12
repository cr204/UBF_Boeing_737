package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.winglet.events.ElementPressedEvent;
	
	public class Element33 extends Sprite {
		private var _timeOut:Boolean = false;
		private var _enabled:Boolean = true;
		private var myTimer:Timer; // = new Timer(300);
		private var myTimer1:Timer = new Timer(425);
		public var isActiveElement:Boolean = false;
		private var _masterCaution:Element29;
		
		public function Element33() {
			// constructor code
			capt_recall.mouseChildren = false;
			fo_recall.mouseChildren = false;
			this.buttonMode = true;
			
		}
		
		public function masterCautionButton(mb:Element29):void {
			_masterCaution = mb;
		}
		
		public function sSwitch(s:String):void {
			//
		}
		
		public function switchState(n:int):void {
			//
		}
		
		public function pressTimeOut(n:int):void {
			var tm:int = 300;
			
			switch(n) {
				case 0:
					tm = 300;
					break;
				case 1:
					tm = 150;
					break;
				case 2:
					tm = 1;
					break;
			}
			
			myTimer = new Timer(tm);
			myTimer.addEventListener("timer", timerHandler);
			myTimer1.addEventListener("timer", timerHandler1);
		}
		
		public function resetElement():void {
			//		
		}
		
		public function set active(b:Boolean):void {
			if(_enabled) {
				if(b) {
					this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
					this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				} else {
					this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
					this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				}
				isActiveElement = b;
			} else {
				trace("Error! Disabled Element29 is activated!");
			}
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			e.target.addEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
			e.target.scaleX = e.target.scaleY = .95;
			turnLights(1); //ON
			myTimer.start();
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			e.target.removeEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
			myTimer.reset();
			e.target.scaleX = e.target.scaleY = 1;
			if(_timeOut) {
				myTimer1.stop();
				// This is where some elements stay ON via XML!
				turnLights(0); //OFF
				this.dispatchEvent(new ElementPressedEvent("off"));
			} else {
				this.dispatchEvent(new ElementPressedEvent("not_timeout"));
			}
			


			_timeOut = false;
		}
		
		public function turnLights(n:int):void {
			for(var i:int=1; i<7; ++i) {
				var tmp:Element30 = capt_recall.getChildByName("txt" + i.toString()) as Element30;
				 tmp.showState(n);
			}
			for(var i=1; i<7; ++i) {
				var tmp:Element30 = fo_recall.getChildByName("txt" + i.toString()) as Element30;
				 tmp.showState(n);
			}
			_masterCaution.showState(n);
		}
		
		private function timerHandler(event:TimerEvent):void {
			_timeOut = true;
			myTimer.stop();	
		}
		
		private function timerHandler1(event:TimerEvent):void {
//			if(btn1.currentFrame==1 || btn2.currentFrame==1) {
////				btn1.gotoAndStop(2);
////				btn2.gotoAndStop(2);
//			} else {
////				btn1.gotoAndStop(1);
////				btn2.gotoAndStop(1);
//			}
		}
		
		

		
	}
}