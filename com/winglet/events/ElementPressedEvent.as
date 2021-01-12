package com.winglet.events {
	
	import flash.events.*;
	
	public class ElementPressedEvent extends Event {
		public static const PRESSED = "pressed";
		public var eventID:String;

		public function ElementPressedEvent(id:String):void {
			// constructor code
				super(PRESSED);
				eventID = id;
		}

	}
	
}
