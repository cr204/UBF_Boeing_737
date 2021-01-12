package com.winglet.assets.panels {
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import com.winglet.events.PanelEvent;
	import com.winglet.assets.elements.Element30;
	
	public class PanelBase extends Sprite {
		public var mainTL:*;
		public var cBtn:Sprite;
		public var eHolder:Sprite;
		private var _posX:Number = 0;
		private var _posY:Number = 0;
		private var _id:String;

		public function PanelBase() {
			//
		}
		
		public function setRecallLight(s:String):void {
			//
		}
		
		public function getRecallLight(s:String):Element30 {
			return new Element30();
		}
		
		protected function initBase(tl:*, eHolder:Sprite, cBtn:Sprite):void {
			mainTL = tl;
			this.eHolder = eHolder;
			this.cBtn = cBtn;
			this.cBtn.addEventListener(MouseEvent.CLICK, onClosePanel);
			initAssets();
		}

		public function resetPanel():void {
			resetAssets();
		}

		public function set enableHolder(b:Boolean):void {
			if(b) {
				eHolder.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownElements);
			} else {
				eHolder.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownElements);
			}
		}
		
		private function mouseDownElements(e:MouseEvent):void {
			if(e.target.buttonMode) {
				if(!e.target.isActiveElement) {
					trace("e.target: " + e.target.name);
					if(e.target.conf!=null) {
						trace("Show Confiramtion!");
					} else {
						mainTL.showITooltip();
					}
				}
			}
		}
		
		protected function initAssets():void {
			//
		}
		
		protected function resetAssets():void {
			//
		}
		
		private function onClosePanel(e:MouseEvent):void {
			//this.dispatchEvent(new PanelEvent("closed"));
			mainTL.closePanel();
		}
		
		public function set id(s:String):void {
			_id = s;
		}
		
		public function get id():String {
			return _id;
		}
		
		public function set posX(n:Number):void {
			_posX = n;
		}
		
		public function get posX():Number {
			return _posX;
		}
		
		public function set posY(n:Number):void {
			_posY = n;
		}
		
		public function get posY():Number {
			return _posY;
		}
		
	}
}
