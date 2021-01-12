﻿package com.winglet.assets.elements {
    import com.greensock.TweenLite;
    import com.winglet.events.ElementPressedEvent;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;

    public class Element32b extends ThrustLever {
        private var parentObj:Object;
        private var locY:Number = 0;
        public var isActiveElement:Boolean = false;
        public var conf:MovieClip;
        public var elementSSwitch:String;
        private var tl1:Object;
        private var tl2:Object;
        private var cnf2:Object;
        private var mainTL:Object;
//        private var erp1_gauge:Object;
//        private var erp2_gauge:Object;

        public function Element32b() {
            lever.buttonMode = true;
            lever.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            lever.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
            lever.visible = false;
        }

        public function init(obj:*):void {
            mainTL = obj;
			parentObj = parent;
            tl1 = parentObj.tl1;
            tl2 = parentObj.tl2;
//            erp1_gauge = mainTL.screen_EWD_SD.screenEWD.eng1_epr_gauge;
//            erp2_gauge = mainTL.screen_EWD_SD.screenEWD.eng2_epr_gauge;
			//active = true;
        }

        public function resetElement():void {
            curState = STATE_NOTHING;
        }

        public function set active(b:Boolean):void {
            if (b) {
                parentObj = parent;
                tl1 = parentObj.tl1;
                tl2 = parentObj.tl2;
                cnf2 = parentObj.confirmation2;
                lever.visible = true;
                cnf2.visible = false;
                tl1.active = true;
                tl2.active = true;
            } else {
                lever.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
                lever.visible = false;
                cnf2.visible = true;
                tl1.lever.alpha = 1;
                tl2.lever.alpha = 1;
                if(conf!=null) conf.hideTooltip();
                tl1.active = false;
                tl2.active = false;
            }
            isActiveElement = b;
        }

        public function leverConfirmation(con:MovieClip):void {
            conf = con;
			lever.conf = con;
            conf.y = 85 + lever.y;
        }

        public function sSwitch(s:String):void {
            elementSSwitch = s;
        }

        private function mouseOverHandler(e:MouseEvent):void {
            if (curState == STATE_NOTHING) {
                curState = STATE_CONFIRMING;
                if (conf!=null) {
                    conf.y = 85 + lever.y;
                    if (isActiveElement) {
                        conf.confValue = true;
                        TweenLite.to(this, 0, {delay:1.5, onComplete:onConfirmTweenFinished});
                    } else conf.confValue = false;
                    conf.displayTooltip();
                }
            }
        }

        private function onConfirmTweenFinished():void {
            if (curState != STATE_NOTHING) {
                curState = STATE_CONFIRMED;
                lever.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
                tl1.lever.alpha = 0.85;
                tl2.lever.alpha = 0.85;
            }
        }

        private function mouseOutHandler(e:MouseEvent):void {
            if (curState!=STATE_MOVING_LEVER) {
                curState = STATE_NOTHING;
                if (conf!=null) conf.hideTooltip();
            }
            lever.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            tl1.lever.alpha = 1;
            tl2.lever.alpha = 1;
            tl1.active = false;
            tl2.active = false;
        }

        private function mouseDownHandler(e:MouseEvent):void {
            if (curState==STATE_CONFIRMED) curState = STATE_MOVING_LEVER;
            locY = e.localY;
            lever.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
            stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
            tl1.lever.alpha = 0.75;
            tl2.lever.alpha = 0.75;
        }

        private function mouseUpHandler(e:MouseEvent):void {
            if(curState==STATE_MOVING_LEVER) {
                stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
                stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
                tl1.lever.alpha = 0.85;
                tl2.lever.alpha = 0.85;
            }
			
			var leverPos:Number = 100 - Math.floor(lever.y / 4);
			checkPosition(leverPos.toString());
			if(curState!=STATE_COMPLETE) curState=STATE_CONFIRMED;
            if(e.target==stage) lever.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
        }

        public function updatePosition(s:String, b:Boolean=false):void {
			var leverPos:Number = Number(s) * 3.95;
			lever.y = leverPos;
            conf.y = 85 + lever.y;
            if(!b) moveBothLevers();
		}

        private function mouseMoveHandler(e:MouseEvent):void {
            if (mouseY - locY > 0 && mouseY - locY < 395) {
                lever.y = mouseY - locY;
                conf.y = 85 + lever.y;
                moveBothLevers();
				
				var leverPos:Number = 100 - Math.floor(lever.y / 4);
				checkPosition(leverPos.toString());
            }
        }

        private function moveBothLevers():void {
            var leverPos:Number = 100 - Math.floor(lever.y / 4);
            tl1.moveLever(leverPos);
            tl2.moveLever(leverPos);
//            updateDonutsPosition(leverPos);
        }

/*        private function updateDonutsPosition(n:Number):void {
            if (n<-85) {
                erp1_gauge.setDonutPosition(TOGA);
                erp2_gauge.setDonutPosition(TOGA);
            } else if(n>=-85 && n<-25) {
                erp1_gauge.setDonutPosition(FLXMCT);
                erp2_gauge.setDonutPosition(FLXMCT);
            } else if(n>=-25 && n<15) {
                erp1_gauge.setDonutPosition(CLB);
                erp2_gauge.setDonutPosition(CLB);
            } else if(n>=15) {
                erp1_gauge.setDonutPosition(String(n));
                erp2_gauge.setDonutPosition(String(n));
            }
        }
*/
        private function checkPosition(s:String):void {
			if(Number(elementSSwitch)>(Number(s)-3) && Number(elementSSwitch)<(Number(s)+3)) {
				this.dispatchEvent(new ElementPressedEvent(s));
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			}
        }

    }
}
