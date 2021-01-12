package com.winglet.assets.states {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.winglet.*;
	import com.winglet.events.ElementPressedEvent;

	public class AdditionalState {
		private var parentObj:MovieClip;
		private static const STS_INTERVAL_TIME:Number = 1000;
		private static const ALL_SD_INTERVAL_TIME:Number = 1000;
		private var stsIntevalTimer:Timer;
		private var sdAllScreenTimer:Timer;
		private var _stsTimer:Boolean = false;
		private var currActiveElement:*;
		private var prevElement:*;
		private var _ecamSwitchingDisable:Boolean = false;
//										 "eng, bleed, c_press, elec_ac, elec_dc, hyd, cb, apu, cond, door, wheel, f_ctl, fuel, sts";
		private var bc:Array = new Array("default", "engine", "bleed", "cabinpress", "elec", "elecDC", "hyd", "cb", "apu", "cond", "door", "wheel", "fctl",  "fuel");
		private var curr_bc:int = 0;
		
		public function AdditionalState(param1) {
			// AdditionalState State
			parentObj = param1;
			stsIntevalTimer = new Timer(STS_INTERVAL_TIME);
			stsIntevalTimer.addEventListener(TimerEvent.TIMER, stsTimerHandler);
			
			sdAllScreenTimer = new Timer(ALL_SD_INTERVAL_TIME);
			sdAllScreenTimer.addEventListener(TimerEvent.TIMER, sdAllTimerHandler);
		}
		
		public function enableElements(s:String, hasInop:Boolean=false):void {

//			trace("enableElements()._ecamSwitchingDisable: " + _ecamSwitchingDisable);
	
			if(!hasInop) disableElements1();
			if(s=="none") { 
				disableElements();
			} else {
				if(s=="all") s="eng, bleed, c_press, elec_ac, elec_dc, hyd, cb, apu, cond, door, wheel, f_ctl, fuel, sts";
				
				var ecamPanel = parentObj.panel_ECAM_SWITCHING;
				var elementHolder = ecamPanel.getChildByName("elementHolder");
				
				var arr:Array = s.split(", ");
				for(var i:int=0; i<arr.length; ++i) {
					var currElement = elementHolder.getChildByName(arr[i]);
					if(hasInop) currElement.active1=true else currElement.active=true;
					if(!_ecamSwitchingDisable || arr[i]=="sts") currElement.addEventListener(ElementPressedEvent.PRESSED, onElementPressed);
				}
/*				if(!_ecamSwitchingDisable) {
					trace("1");
					elementHolder.all.addEventListener(MouseEvent.MOUSE_DOWN, allMouseDownHandler);
					elementHolder.all.addEventListener(MouseEvent.MOUSE_UP, allMouseUpHandler);
				} else {
					trace("2");
					elementHolder.all.removeEventListener(MouseEvent.MOUSE_DOWN, allMouseDownHandler);
					elementHolder.all.removeEventListener(MouseEvent.MOUSE_UP, allMouseUpHandler);
				}
				elementHolder.all.active = _ecamSwitchingDisable;*/
			}
		}
		
		private function allMouseDownHandler(e:MouseEvent):void {
			trace("allMouseDownHandler()");
			sdAllScreenTimer.start();
		}
		
		private function allMouseUpHandler(e:MouseEvent):void {
			sdAllScreenTimer.stop();
		}
		
		public function resetElements():void {
			var s:String = "eng, bleed, c_press, elec_ac, elec_dc, hyd, cb, apu, cond, door, wheel, f_ctl, fuel, sts";
			
			var ecamPanel = parentObj.panel_ECAM_SWITCHING;
			var elementHolder = ecamPanel.getChildByName("elementHolder");
			
			var arr:Array = s.split(", ");
			for(var i:int=0; i<arr.length; ++i) {
				var currElement = elementHolder.getChildByName(arr[i]);
				currElement.active1=false;
				currElement.active=false;
				currElement.removeEventListener(ElementPressedEvent.PRESSED, onElementPressed);
			}
			curr_bc = 0;
			elementHolder.all.active = false;
			elementHolder.all.removeEventListener(MouseEvent.MOUSE_DOWN, allMouseDownHandler);
			elementHolder.all.removeEventListener(MouseEvent.MOUSE_UP, allMouseUpHandler);
		}
		
		public function set ecamSwitching(s:String):void {
			if(s=="inop") _ecamSwitchingDisable = true
						else _ecamSwitchingDisable = false;


			var ecamPanel = parentObj.panel_ECAM_SWITCHING;
			var elementHolder = ecamPanel.getChildByName("elementHolder");
			if(_ecamSwitchingDisable) {
					elementHolder.all.addEventListener(MouseEvent.MOUSE_DOWN, allMouseDownHandler);
					elementHolder.all.addEventListener(MouseEvent.MOUSE_UP, allMouseUpHandler);
				} else {
					elementHolder.all.removeEventListener(MouseEvent.MOUSE_DOWN, allMouseDownHandler);
					elementHolder.all.removeEventListener(MouseEvent.MOUSE_UP, allMouseUpHandler);
				}
				elementHolder.all.active = _ecamSwitchingDisable;
		}
		
		private function disableElements():void {
			var ecamPanel = parentObj.panel_ECAM_SWITCHING;
			var elementHolder = ecamPanel.getChildByName("elementHolder");
			var s:String = "eng, bleed, c_press, elec_ac, elec_dc, hyd, cb, apu, cond, door, wheel, f_ctl, fuel, sts";
			
						   
			
			var arr:Array = s.split(", ");
			for(var i:int=0; i<arr.length; ++i) {
				var currElement = elementHolder.getChildByName(arr[i]);
				currElement.active=false;
				currElement.active1=false;
				currElement.removeEventListener(ElementPressedEvent.PRESSED, onElementPressed);
			}
		}

		private function disableElements1():void {
			var ecamPanel = parentObj.panel_ECAM_SWITCHING;
			var elementHolder = ecamPanel.getChildByName("elementHolder");
			var s:String = "eng, bleed, c_press, elec_ac, elec_dc, hyd, cb, apu, cond, door, wheel, f_ctl, fuel, sts";
			
			var arr:Array = s.split(", ");
			for(var i:int=0; i<arr.length; ++i) {
				var currElement = elementHolder.getChildByName(arr[i]);
				//if(b) currElement.active1=false else currElement.active=false;
				currElement.active1=false;
				currElement.removeEventListener(ElementPressedEvent.PRESSED, onElementPressed);
			}
		}

		
		
		private function onElementPressed(e:ElementPressedEvent):void {
			
//			trace(" ## onElementPressed():" + e.eventID);
			var targetElement = e.target;
			
			if(e.eventID=="not_timeout" && targetElement.name!="sts") { 
				parentObj.helpBox.timeout_warn.visible = true; 
				parentObj.helpBox.visible = true; 
				parentObj.btnHelp.gotoAndStop(3);
			}  else {
				if(parentObj.helpBox.timeout_warn.visible) {
					parentObj.helpBox.timeout_warn.visible = false;
					parentObj.helpBox.visible = false; 
					parentObj.btnHelp.gotoAndStop(1);
				}
				
				if(targetElement!=currActiveElement) {
					if(currActiveElement!=undefined) currActiveElement.switchState("off");
				}

				if(parentObj.inopScreenName=="none") {
						if(targetElement.currentState) {
							if(targetElement.name=="sts" && _ecamSwitchingDisable) {
								targetElement.switchState("on", true);
							} else targetElement.switchState("on");
							currActiveElement = targetElement;
						} else {
							targetElement.switchState("off");
							currActiveElement = undefined;
						}
				}

				var so:* = parentObj.screenOperations;
				if((prevElement!=undefined) && (so._hasStatus2 && targetElement.name=="sts" && !targetElement.currentState && prevElement.name=="sts")) {
//					trace("* prevElement.name: " + prevElement.name + " - .currentState: " + targetElement.currentState);
					if(parentObj.inopScreenName=="none") {
						if(targetElement.name=="sts" && _ecamSwitchingDisable) {
							targetElement.switchState("on", true);
						} else targetElement.switchState("on");
						currActiveElement = targetElement;
					} else {
						if(_stsTimer) {
						} else {
							stsIntevalTimer.start();
							_stsTimer = true;
						}
					}
					
					targetElement = new Object();
					targetElement.name = "sts2";
					targetElement.currentState = true;
				}
				
//				if(targetElement.name=="sts") trace("sts.eventID: " + e.eventID);
				
				if(targetElement.name=="sts" && e.eventID=="on" && so._hasStatus2 && _stsTimer) {
					targetElement = new Object();
					targetElement.name = "sts2";
					targetElement.currentState = true;
					_stsTimer = false;
				}
				parentObj.completeAdditionalScreenAnimation(targetElement);
				prevElement = targetElement;
			}
		}
		
		private function stsTimerHandler(e:TimerEvent):void {
			stsIntevalTimer.reset();
			_stsTimer = false;
		}
		
		private function sdAllTimerHandler(e:TimerEvent):void {
			++curr_bc;
			if(curr_bc>=bc.length) curr_bc=0;
			
			trace("sdAllTimerHandler: " + curr_bc);
			showSD(bc[curr_bc]);
		}
		
		private function showSD(s:String):void {
			parentObj.setSDScreenSeries(s);
		}
		
	}
}