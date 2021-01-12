package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import com.winglet.events.ElementPressedEvent;
	import flash.display.MovieClip;
	
	public class MultipleButtons extends Sprite {
		private var _timeOut:Boolean = false;
		private var _enabled:Boolean = true;
		private var myTimer:Timer; // = new Timer(300);
		private var myTimer1:Timer = new Timer(425);
		private var channel:SoundChannel = new SoundChannel();
		private var sound1:Sound;
		public var isActiveElement:Boolean = false;
		private var _sSwitch:String = "";
		private var btn1:MovieClip;
		private var btn2:MovieClip;
		private var recallBtn1:Element33;
		private var _ignoreTurnOff:Boolean = false;

		public function MultipleButtons() {
			// constructor code
		}
		
		public function recallButtons(rc1:Element33):void {
			recallBtn1 = rc1;
		}
		
		public function init(b1:MovieClip, b2:MovieClip):void {
			this.buttonMode = true;
			btn1 = b1;
			btn2 = b2;
		}
		
		public function sSwitch(s:String):void {
			_sSwitch = s;
		}
		
		public function switchState(n:int):void {
			//
		}
		
		// This is for light button ON/OFF without alert sounds. Added - may 3, 2013.
		// XML usage: <element panel="recall" name="master_caut" status="on" />
		public function showState(n:int):void {
			if(n==1) {
				turnLight(1);
			} else {
				if(!_ignoreTurnOff) {
					turnLight(0);
				}
				_ignoreTurnOff = false;
			}
		}
		
		public function ignoreTurnOff():void {
			_ignoreTurnOff = true;
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
			myTimer1.stop();
			channel.stop();
			turnLight(0);
		}
		
		
		public function useAlert(n:int):void {
			switch(n) {
				case 1:
					//myTimer1.start();
					turnLight(1);
					sound1 = new asset04a_4(); //asset04a_1a();
					//channel = sound1.play(0,99);
					channel = sound1.play(80,99);
					break;
				case 2:
					btn1.gotoAndStop(2);
					btn2.gotoAndStop(2);
//					sound1 = new asset04a_2();
//					channel = sound1.play(0,1);
					break;
				case 3:
					//myTimer1.start();
					turnLight(1);
					sound1 = new asset04a_3();
					channel = sound1.play(0,99);
					break;
			}
		}
		
		public function set active(b:Boolean):void {
			if(_enabled) {
				if(b) {
					btn1.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
					btn1.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
					btn2.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
					btn2.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				} else {
					btn1.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
					btn1.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
					btn2.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
					btn2.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				}
				isActiveElement = b;
			} else {
				trace("Error! Disabled Element29 is activated!");
			}
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			e.target.addEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
			e.target.scaleX = e.target.scaleY = .95;
			myTimer.start();
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			e.target.removeEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
			myTimer.reset();
			e.target.scaleX = e.target.scaleY = 1;
			if(_timeOut) {
				channel.stop();
				myTimer1.stop();
				if(_sSwitch=="on") {
					turnLight(1);
				} else {
					turnLight(0);
				}
				turnRecallLightsOff();
				this.dispatchEvent(new ElementPressedEvent("off"));
			} else {
				this.dispatchEvent(new ElementPressedEvent("not_timeout"));
			}
			_timeOut = false;
		}
		
		private function turnRecallLightsOff():void {
			if(recallBtn1) recallBtn1.turnLights(0);
		}
		
		private function timerHandler(event:TimerEvent):void {
			_timeOut = true;
			myTimer.stop();	
		}
		
		private function timerHandler1(event:TimerEvent):void {
			if(btn1.currentFrame==1 || btn2.currentFrame==1) {
				turnLight(1);
			} else {
				turnLight(0);
			}
		}
		
		private function turnLight(n:int):void {
			if(n==1) {
				btn1.gotoAndStop(2);
				btn2.gotoAndStop(2);
			} else {
				btn1.gotoAndStop(1);
				btn2.gotoAndStop(1);
			}
		}
		
		
	}
}