package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.media.SoundChannel;
	import flash.media.Sound;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import com.winglet.events.ElementPressedEvent;
	
	
	public class Element27 extends ElementSpriteBase {
		private var ct:ColorTransform=new ColorTransform();
		private var colorArr:Array = [];
		private var channel:SoundChannel = new SoundChannel();
		private var sound1:Sound;
		private var myTimer:Timer;
		private var myTimer1:Timer = new Timer(425);
		private var _timeOut:Boolean = false;
		private var _currState:int = 0;
		public var isActiveElement:Boolean = false;
		private var _sSwitch:String = new String();
		private var _useSound:Boolean = false;
		
		public function Element27() {
			// constructor code
			this.mouseChildren = false;
			this.buttonMode = true;
		}
		
		public function sSwitch(s:String):void {
			_sSwitch = s;
		}
		
		public function set useNoise(b:Boolean):void {
			_useSound = b;
		}
		
		public function switchState(n:int):void {
			//trace("Element27.switchState: " + n);
		}
		
		public function showState(n:int):void {
			tintClip(txt, colorArr[n]);
			tintClip(bline, colorArr[n]);
			_currState = n;
		}
		
		public function set active(b:Boolean):void {
			if(b) {
				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			} else {
				this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
			isActiveElement = b;
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
			this.scaleX = this.scaleY = .92;
			myTimer.start();
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
			myTimer.reset();
			this.scaleX = this.scaleY = 1;
			if(_timeOut) {
				if(_sSwitch=="on") {
					//showState(1);
				} else {
					myTimer1.stop();
					showState(0);
				}
				if(_useSound) channel.stop();
				this.dispatchEvent(new ElementPressedEvent("off"));
			} else {
				this.dispatchEvent(new ElementPressedEvent("not_timeout"));
			}
			_timeOut = false;
		}
		
		public function setText(s:String):void {
			//var n:Array = s.split(" ");
			//if(n.length<2) txt.y = 7;
			
			txt.text = s;
			var n:int = txt.numLines;
			if(n<2) txt.y = 7;
			
		}
		
		public function useAlert(n:int):void {
			switch(n) {
				case 1:
					myTimer1.addEventListener("timer", timerHandler1);
					myTimer1.start();
					showState(1);
					if(_useSound) {
						sound1 = new asset04a_5(); //asset04a_1a();
						//channel = sound1.play(0,99);
						channel = sound1.play(40,99);
					}
					break;
/*				case 2:
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
					break;*/
			}
		}
		
		public function setColors(...args:Array):void {
//			var ts:String = args.toString();
			colorArr = args; //ts.split(",");
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
		}
		
		public function resetElement():void {
			myTimer1.stop();
			if(_useSound) channel.stop();
			showState(0);
		}
		
		private function timerHandler(event:TimerEvent):void {
			_timeOut = true;
			myTimer.stop();	
		}
		
		private function timerHandler1(event:TimerEvent):void {
			if(_currState==0) showState(1) else showState(0);
		}
		
		private function tintClip(obj:*, c:uint):void {
			
			var color:uint=c; //picker.selectedColor;
			var mul:Number=1; //slider.value/100;
			var ctMul:Number=(1-mul);
			var ctRedOff:Number=Math.round(mul*extractRed(color));
			var ctGreenOff:Number=Math.round(mul*extractGreen(color));
			var ctBlueOff:Number=Math.round(mul*extractBlue(color));
			ct=new ColorTransform(ctMul,ctMul,ctMul,1,ctRedOff,ctGreenOff,ctBlueOff,0);
			obj.transform.colorTransform=ct;
		}
		
		private function extractRed(c:uint):uint {
			return (( c >> 16 ) & 0xFF);
		}
		
		private function extractGreen(c:uint):uint {
			return ( (c >> 8) & 0xFF );
		}
		
		private function extractBlue(c:uint):uint {
			return ( c & 0xFF );
		}
		
	}
}