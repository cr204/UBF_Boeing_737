package com.winglet.events {
	
	import flash.events.*;
	
	public class ElementStateEvent extends Event {
		public static const CHANGED:String = "changed";

		public function ElementStateEvent(id:String):void {
			// constructor code
				super(CHANGED);
		}

	}
	
}
