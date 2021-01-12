package com.winglet.assets.screens {
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class EngineFlags extends Sprite {
		private var myTimer:Timer;
		private var tc:Boolean = false;
		
		public function EngineFlags() {
			// constructor code
			myTimer = new Timer(500, 9);
			myTimer.addEventListener('timer', timerHandler);
		}
		
		
		public function showState(b:Boolean):void {
			trace("EngineFlags.showState: " + b);
			if(b) {
				myTimer.start();
			} else {
				this.visible = false;
				myTimer.stop();
			}
		}

		
		
		
		
		
		
		private function timerHandler(e:TimerEvent):void {
			if(tc) this.visible=false else this.visible=true;
			tc = !tc;
		}
		
	}
}