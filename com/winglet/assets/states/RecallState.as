package com.winglet.assets.states {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.winglet.*;
	import com.winglet.events.ElementPressedEvent;
	
	public class RecallState {
		private var parentObj:MovieClip;
		private var currRecallObj:Object;
		public static const PROCESS_DELAY_TIME:Number = 500;
		private var processDelayTimer:Timer;
		private var ecamPanel:*;
		private var elementHolder:*;
		private var rclElement:*;
		private var _ecamInop:Boolean = false;
		
		public function RecallState(param1) {
			// Recall State
			parentObj = param1;
			processDelayTimer = new Timer(PROCESS_DELAY_TIME);
			processDelayTimer.addEventListener(TimerEvent.TIMER, delayTimerHandler);
		}
		
		public function recallObj(rObj:Object):void {
			currRecallObj = rObj;
			
			ecamPanel = parentObj.panel_ECAM_SWITCHING;
			elementHolder = ecamPanel.getChildByName("elementHolder");
			rclElement = elementHolder.getChildByName("rcl");
//			rclElement.active = true;
//			rclElement.addEventListener(ElementPressedEvent.PRESSED, onElementPressed);
			enable();
		}
		
		public function enable():void {
			rclElement.active = true;
			rclElement.addEventListener(ElementPressedEvent.PRESSED, onElementPressed);
		}
		
		public function set ecamSwitching(b:Boolean):void {
			_ecamInop = b
		}
		
		private function onElementPressed(e:ElementPressedEvent):void {
			if(e.eventID=="not_timeout") { 
				parentObj.helpBox.timeout_warn.visible = true; 
				parentObj.helpBox.visible = true;
				parentObj.btnHelp.gotoAndStop(3);
			}  else {
				var targetElement = e.target;
	
				parentObj.helpBox.timeout_warn.visible = false;
				parentObj.btnHelp.gotoAndStop(2);
				
				trace("parentObj.recallStateSet: " + parentObj.recallStateSet);
				
				if(parentObj.recallStateSet) {
					targetElement.active = false;
					targetElement.removeEventListener(ElementPressedEvent.PRESSED, onElementPressed);
					
					parentObj._mainStatesDone = false;
					processDelayTimer.start();
					
					var clr1 = elementHolder.getChildByName("clr1");
					var clr2 = elementHolder.getChildByName("clr2");
					var sts = elementHolder.getChildByName("sts");
					if(!_ecamInop) clr1.switchState("on") else clr1.switchState("off");
					if(!_ecamInop) clr2.switchState("on") else clr2.switchState("off");
					sts.switchState("off");
					parentObj.recallStepBack();
				} else {
					parentObj.recallNormal();
				}
			}
		}
		
		private function completeProcess():void {
			if(currRecallObj.screenID!="") parentObj.completeCurrentScreenAnimation(currRecallObj.screenID);
		}
		
		private function delayTimerHandler(e:TimerEvent):void {
			processDelayTimer.reset();
			completeProcess();
		}
		
	}
}
