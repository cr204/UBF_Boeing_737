package com.winglet.events {
	
	import flash.events.Event;
	
	public class PanelEvent extends Event {
		public static const CLOSED = "closed";
		public static const INCORRECT = "incorrect";

		public function PanelEvent(s:String):void {
			// constructor code
				trace("PanelClosedEvent()");
				super(s);
		}

	}
	
}
