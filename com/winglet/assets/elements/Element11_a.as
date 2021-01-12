package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.events.ElementPressedEvent;
	
	public class Element11_a extends ElementSpriteBase {
		public var isActiveElement:Boolean = false;
		public var elementSSwitch:String = "none";
		private var initMouseX:Number = 643;
		private var leverPos:int=1;
		private var mouseMoved:Boolean = true;
		private var _hasEither:Boolean = false;
		private var _lastPosition:int = 1;
		
		public function Element11_a() {
			// constructor code
			this.mouseChildren = false;
			this.buttonMode = true;
		}
		
		public function set active(b:Boolean):void {
			if(b) {
				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			} else {
				this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				if(stage) {
					stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				}
			}
			isActiveElement = b;
		}
		
		public function showState(n:int):void {
			switch(n) {
				case 0:
					btn.gotoAndStop(1);
					break;
				case 1:
					btn.gotoAndStop(2);
					break;
			}
		}
		
		public function sSwitch(s:String):void {
			if(elementSSwitch!="none" && s=="either") _hasEither=true;
			elementSSwitch = s;
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			if(btn.scaleX==1) {
				btn.scaleX = 1.1;
				btn.scaleY = 1.1;
			}
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			if(leverPos==getLeverPosition()) {
				if(!mouseMoved) {
					btn.scaleX = 1;
					btn.scaleY = 1;
					mouseMoved = true;
				} else mouseMoved = false;
			} else {
				if(mouseMoved) mouseMoved = false;
			}
			leverPos = getLeverPosition();
			
			if(elementSSwitch=="both") {
				// Because leverPos=1 is center position of lever;
				if(leverPos!=1) this.dispatchEvent(new ElementPressedEvent(leverPos.toString()));
			} else if(elementSSwitch==leverPos.toString()) this.dispatchEvent(new ElementPressedEvent(leverPos.toString()));
			if(elementSSwitch=="either" && leverPos!=1) {
				if(_hasEither) {
					if(_lastPosition!=leverPos) this.dispatchEvent(new ElementPressedEvent(leverPos.toString()));
				} else {
					this.dispatchEvent(new ElementPressedEvent(leverPos.toString()));
				}
				_lastPosition = leverPos;
			}
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function mouseMoveHandler(e:MouseEvent):void {
			var diff:Number = initMouseX - stage.mouseX;
			if(diff>35) {
				this.rotationZ=-45;
				if(leverPos!=0) mouseMoved = true;
			}
			if(diff<35 && diff>-35) {
				this.rotationZ=0;
				 if(leverPos!=1) mouseMoved = true;
			}
			if(diff<-35) {
				this.rotationZ=45;
				if(leverPos!=2) mouseMoved = true;
			}
		}
		
		private function getLeverPosition():Number {
			var ret:Number = 0;
			var diff:Number = initMouseX - stage.mouseX;
			if(diff>35) ret = 0;
			if(diff<35 && diff>-35) ret = 1;
			if(diff<-35) ret = 2;
			return ret;
		}
		
		public function resetElement():void {
			//this.active = false;
			this.rotationZ=0;
			btn.scaleX = 1;
			btn.scaleY = 1;
			leverPos = 1;
			mouseMoved = true;
			btn.gotoAndStop(1);
		}
		
	}
}