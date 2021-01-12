package com.winglet.events {
	
	import flash.events.*;
	
	public class Element12Event extends Event {
		public static const SELECTED = "selected";
		public var frame:int;

		public function Element12Event(id:int):void {
			// constructor code
				super(SELECTED);
				frame = id;
		}

	}
	
}
