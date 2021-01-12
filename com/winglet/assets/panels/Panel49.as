package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Panel49 extends Sprite {
		public var mainTL:*;
		
		public function Panel49() {
			// constructor code
			initAssets();
		}
		
		public function init(tl:*):void {
			mainTL = tl;
			closeBtn.addEventListener(MouseEvent.CLICK, onClosePanel);
		}

		public function resetPanel():void {
			resetAssets();
		}

		public function set enableHolder(b:Boolean):void {
/*			if(b) {
				elementHolder.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownElements);
			} else {
				elementHolder.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownElements);
			}*/
		}
		
		private function mouseDownElements(e:MouseEvent):void {
			if(e.target.buttonMode) {
				if(!e.target.isActiveElement) {
					mainTL.showITooltip();
				}
			}
		}
		
		private function initAssets():void {
			/*
			elementHolder.data1.rotationDegrees(290, 320, 340, 15, 40, 65);
			elementHolder.data1.defaultPosition = 1;
			*/
		}
		
		private function resetAssets():void {
			/*
			elementHolder.data1.defaultPosition = 1;
			*/
		}
		
		private function onClosePanel(e:MouseEvent):void {
			mainTL.closePanel();
		}
	}
	
}
