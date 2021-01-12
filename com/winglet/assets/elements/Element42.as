﻿package com.winglet.assets.elements {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.winglet.events.ElementPressedEvent;
	
	
	public class Element42 extends MovieClip {
		private var rotDeg:int = 1;
		public var isActiveElement:Boolean = false;
		private var elementSSwitch:Number;
		private var lcd:Element34a;
		private var dl:int = 0;
		
		public function Element42() {
			// constructor code
			stop();
			this.mouseChildren = false;
			this.buttonMode = true;
			active = true;
		}
		
		public function set active(b:Boolean):void {
			if(b) {
				this.addEventListener(MouseEvent.MOUSE_DOWN, onStartRotating);
				this.addEventListener(MouseEvent.MOUSE_UP, onStopRotating);
				this.mouseChildren = true;
			} else {
				this.removeEventListener(MouseEvent.MOUSE_DOWN, onStartRotating);
			    this.removeEventListener(MouseEvent.MOUSE_UP, onStopRotating);
				this.mouseChildren = false;
			}
			isActiveElement = b;
		}
		
		public function sSwitch(s:String):void {
			elementSSwitch = Number(s);
		}
		
		public function appyLCD(_lcd:Element34a):void {
			lcd = _lcd;
		}
		
		public function setXMLObject(eObj:Object):void {
			lcd.setNumber(Number(eObj.value));
		}
		
		private function onStartRotating(e:MouseEvent):void {
			var target = e.target;
			switch(target.name) {
				case "state1":
						rotDeg = 1;
					break;
				case "state2":
						rotDeg = -1;
					break;
			}
			startRotation();
		}

		private function startRotation():void {
			this.addEventListener(Event.ENTER_FRAME, rotateIt);
		}

		private function onStopRotating(e:MouseEvent=null):void {
			this.removeEventListener(Event.ENTER_FRAME, rotateIt);
		}
		
		private function rotateIt(e:Event):void {
			var nextFm:int = this.currentFrame + rotDeg;
			if(nextFm<1) nextFm=6;
			if(nextFm>6) nextFm=1;
			gotoAndStop(nextFm);
			++dl;
			
			if(dl>2) {
				if(lcd) {
					if(rotDeg<0) {
						checkNumber(lcd.incNumber());
					} else {
						checkNumber(lcd.decNumber());
					}
				}
				dl=0;
			}
			
		}
		
		private function checkNumber(n:Number):void {
			if(n==elementSSwitch) {
				onStopRotating();
				this.dispatchEvent(new ElementPressedEvent(String(n)));
			}
		}
		
		public function resetElement():void {
			active = false;
			gotoAndStop(1);
			if(lcd) lcd.resetLCD();
		}
		
	}
}