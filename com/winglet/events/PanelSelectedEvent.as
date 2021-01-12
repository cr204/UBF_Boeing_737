package com.winglet.events {
	
	import flash.events.*;
	
	public class PanelSelectedEvent extends Event {
		public static const SELECTED = "selected";
		public var panelID:String;

		public function PanelSelectedEvent(id:String):void {
			// constructor code
				super(SELECTED);
				panelID = id;
		}

	}
	
}
