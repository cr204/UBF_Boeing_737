package com.winglet.events {
	
	import flash.events.*;
	
	public class ConditionalKeyEvent extends Event {
		public static const COMPLETED = "completed";
//		public var panelID:String;

		public function ConditionalKeyEvent(id:String):void {
			// constructor code
				super(COMPLETED);
//				panelID = id;
		}

	}
	
}
