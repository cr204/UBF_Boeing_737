package com.winglet.assets.buttons {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.utils.ProjectUtils;
	
	
	public class PanelButton extends Sprite {
		private var _highlighted:Boolean = false;
		
		public function PanelButton01() {
			// constructor code
		}
		
		public function init():void {
			this.alpha = 0;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		public function set highlighted(b:Boolean):void {
			_highlighted = b;
			if(_highlighted) {
				ProjectUtils.getInstance().tintClip(this, 0xEDC00C);
				this.alpha = 1;
			} else {
				ProjectUtils.getInstance().tintClip(this, 0x0066FF);
				this.alpha = 0;
			}
		}
		
		public function set isSelected(b:Boolean):void {
//			panelSelected = b;
//			if(!b) this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
		}
		
		private function onMouseOver(e:MouseEvent):void {
			if(_highlighted) ProjectUtils.getInstance().tintClip(this, 0x0066FF);
			this.alpha = 1;
		}
		
		private function onMouseOut(e:MouseEvent):void {
			if(_highlighted) {
				ProjectUtils.getInstance().tintClip(this, 0xEDC00C);
				this.alpha = 1;
			} else {
				this.alpha = 0;
			}
		}

	}
	
}
