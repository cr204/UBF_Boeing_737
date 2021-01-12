package com.winglet.assets.states {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.winglet.*;
	import com.winglet.events.ElementPressedEvent;
	
	public class STSState {
		private var parentObj:MovieClip;
//		private var currSTSObj:Object;
		public static const PROCESS_DELAY_TIME:Number = 500;
		private var processDelayTimer:Timer;
		private var ecamPanel:*;
		private var elementHolder:*;
		private var stsElement:*;
		
		public function STSState(param1) {
			// STS State
			parentObj = param1;
//			processDelayTimer = new Timer(PROCESS_DELAY_TIME);
//			processDelayTimer.addEventListener(TimerEvent.TIMER, delayTimerHandler);
		}
		
		public function init():void {
//			currSTSObj = sObj;
			
			ecamPanel = parentObj.panel_ECAM_SWITCHING;
			elementHolder = ecamPanel.getChildByName("elementHolder");
			stsElement = elementHolder.getChildByName("sts");

		}
		
		public function set enable(b:Boolean):void {
			if(b) {
				stsElement.active = true;
				stsElement.addEventListener(ElementPressedEvent.PRESSED, onElementPressed);
			} else {
				stsElement.active = false;
				stsElement.removeEventListener(ElementPressedEvent.PRESSED, onElementPressed);
			}
		}
		
		private function onElementPressed(e:ElementPressedEvent):void {
			var targetElement = e.target;
			var sts = elementHolder.getChildByName("sts");
			//sts.switchState("on");
			if(sts.currentState) {
				sts.switchState("on");
			} else {
				sts.switchState("off");
			}
			completeProcess();
			parentObj.completeAdditionalScreenAnimation(targetElement);
//				parentObj.recallStepBack();
		}
		
		private function completeProcess():void {
			// Hmmm...
			//if(currSTSObj.screenID!="") parentObj.completeCurrentScreenAnimation(currSTSObj.screenID);
			trace("STSState.completeProcess()");
		}
	}
	
	
}