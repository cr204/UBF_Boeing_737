package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	import com.winglet.events.ElementPressedEvent;
	
	public class Element32a extends ThrustLever {
		private var locY:Number = 0;
		public var isActiveElement:Boolean = false;		
		public var conf:MovieClip;
		public var elementSSwitch:String;
		public var n1_gauge:*;
		private var mainTL:*;
		private var parentObj:*;
		
		public function Element32a() {
			// constructor code
			lever.mouseChildren = false;
			lever.buttonMode = true;
			lever.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			lever.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			disconnect.visible = false;
		}
		
		public function init(obj:*):void {
			moveLever(50);
			
			mainTL = obj;
//			n1_gauge = mainTL.screen_EWD_SD.screenEWD.eng1_n1_gauge;
//			n1_gauge.setDonutPosition(CLB);
			correctPos();
		}
		
		public function resetElement():void {
			this.active = false;
			curState = STATE_NOTHING;
			moveLever(0);
		}
		
		public function set active(b:Boolean):void {
			if(b) {
//				lever.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
//				lever.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			} else {
				lever.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				lever.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				lever.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
//				lever.btn.alpha = 1;
				if(conf!=null) conf.hideTooltip();
			}
			isActiveElement = b;
		}
		
		public function set activateDisconnect(b:Boolean):void {
			if(b) {
				disconnect.visible = true;
				disconnect.buttonMode = true;
				disconnect.y = lever.y;
				disconnect.addEventListener(MouseEvent.MOUSE_UP, mouseUpDisconnect);
				disconnect.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownDisconnect);
			} else {
				disconnect.visible = false;
				disconnect.removeEventListener(MouseEvent.MOUSE_UP, mouseUpDisconnect);
				disconnect.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownDisconnect);
			}
		}
		
		private function mouseDownDisconnect(e:MouseEvent):void {
			lever.gotoAndStop(2);
		}
		
		private function mouseUpDisconnect(e:MouseEvent):void {
			lever.gotoAndStop(1);
			this.dispatchEvent(new ElementPressedEvent("1"));
		}
		
		public function leverConfirmation(con:MovieClip):void {
			conf = con;
			lever.conf = con;
			conf.y = lever.y * .77 + 200;
		}
		
		public function sSwitch(s:String):void {
			elementSSwitch = s;
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			if (curState == STATE_NOTHING) {
				curState = STATE_CONFIRMING;
				if(conf!=null) {
					conf.y = lever.y + 530;
					if(isActiveElement) {
						conf.confValue=true;
						TweenLite.to(this, 0, {delay:1, onComplete:onConfirmTweenFinished});
					} else conf.confValue=false;
					conf.displayTooltip();
				}				
			}
		}
		
		private function onConfirmTweenFinished() {
			if (curState != STATE_NOTHING) { 
				curState = STATE_CONFIRMED;
//				lever.btn.alpha = .85;
				lever.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				lever.active = true;			
			}
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			
			if (curState != STATE_MOVING_LEVER) {
				curState = STATE_NOTHING;
				//lever.btn.alpha = 1;
				if (conf != null) { conf.hideTooltip(); }
			}
			
			lever.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			lever.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			if (curState == STATE_CONFIRMED) {
				curState = STATE_MOVING_LEVER;
			}
			
			lever.active = false;
//			lever.btn.alpha = 1;
			if(conf!=null) conf.hideTooltip();
			lever.active = true;
//			lever.btn.alpha = .75;
			locY = e.localY;
			
			lever.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler); // remove mouse out listener as we are now dragging the lever
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			
			if (curState == STATE_MOVING_LEVER) {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler); // stop tracking mouse.y
				stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				lever.active = false;
//				lever.btn.alpha = .85;
				lever.removeEventListener(MouseEvent.MOUSE_OUT, mouseUpHandler);
				lever.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		
				var lvp:Number = (lever.y + 180) / -2.68;
				checkPosition(String(Math.floor(lvp)));
				correctPos();
			}
		}	

		private function mouseMoveHandler(e:MouseEvent):void {
			if((mouseY - locY)<-180 && (mouseY - locY) > -450) {  // -52
				lever.y = mouseY - locY;
				correctPos();

				var lvp:Number = (lever.y + 180) / -2.68;
				checkPosition(String(Math.floor(lvp)));
			}
		}
		
		public function moveLever(n:Number):void {
			updatePosition(String(n));
		}
		
		private function correctPos():void {
			tl_reverser.y = -220 + lever.y - lever.y * .4;
			tl_connector.y = -202 + lever.y - lever.y * .4;
			tl_connector.scaleY = 1 + lever.y * .0015;
			tl_connector0.y = -100 + lever.y - lever.y * .22;
			conf.y = lever.y + 530;
		}
		
		public function updatePosition(s:String):void {
			var pos:Number = -55 - Number(s) * 3.92;
			lever.y = pos;
			correctPos();
//			updateDonutPosition(lever.y);
		}
		
/*		private function updateDonutPosition(n:Number):void {
			if(n<-85) {
				n1_gauge.setDonutPosition(TOGA);
			} else if(n>=-85 && n<-25) {
				n1_gauge.setDonutPosition(FLXMCT);
			} else if(n>=-25 && n<20) {
				n1_gauge.setDonutPosition(CLB);
			} else if(n>=20) {
				n1_gauge.setDonutPosition(String(n));
			}
		}*/
		
		
		private function checkPosition(s:String):void {
			if(Number(elementSSwitch)>(Number(s)-3) && Number(elementSSwitch)<(Number(s)+3)) {
				this.dispatchEvent(new ElementPressedEvent(s));
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			}
		}
	}
}