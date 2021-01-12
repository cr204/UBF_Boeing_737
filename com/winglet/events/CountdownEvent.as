package com.winglet.events {
	
	import flash.events.*;
	
	public class CountdownEvent extends Event {
		public static const DONE = "done";
		public var eventID:String;

		public function CountdownEvent(id:String):void {
			// constructor code
				super(DONE);
				eventID = id;
		}

	}
	
}
