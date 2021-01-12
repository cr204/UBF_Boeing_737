package com.winglet.assets.panels {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.winglet.Colors;
	import com.winglet.assets.elements.TLDisconnect;
	
	public class Panel50_THRUST_LEVERS extends PanelBase {
		private var disconnect:TLDisconnect;
		
		public function Panel50_THRUST_LEVERS() {
			disconnect = new TLDisconnect();
			disconnect.name = "disconnect";
			elementHolder.addChild(disconnect);
		}
		
		public function init(tl:*):void {
			super.initBase(tl, elementHolder, closeBtn);
			elementHolder.tl1.init(tl);
			elementHolder.tl2.init(tl);
			elementHolder.tl_both.init(tl);
		}

		override protected function initAssets():void {
			elementHolder.tl1.leverConfirmation(elementHolder.confirmation1);
			elementHolder.tl2.leverConfirmation(elementHolder.confirmation2);
			elementHolder.tl_both.leverConfirmation(elementHolder.confirmation3);
			disconnect.thrustLevers(elementHolder.tl1, elementHolder.tl2);
			
			elementHolder.engine1_start_lever.leverConfirmation(elementHolder.confirmation4);
			elementHolder.engine2_start_lever.leverConfirmation(elementHolder.confirmation5);
			
		}
		
		override protected function resetAssets():void {
			elementHolder.tl1.resetElement();
			elementHolder.tl2.resetElement();
			elementHolder.engine1_start_lever.resetElement();
			elementHolder.engine2_start_lever.resetElement();
		}
		
	}
}