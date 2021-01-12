package com.winglet.assets.elements {
	
	import flash.display.Sprite;
	
	public class ThrustLever extends Sprite {

		public static var IDLE:String = "IDLE";
		public static var CLB:String = "CLB";
		public static var FLXMCT:String = "FLX/MCT";
		public static var TOGA:String = "TOGA";
		
		protected static var STATE_NOTHING:String = "STATE_NOTHING";
		protected static var STATE_CONFIRMING:String = "STATE_CONFIRMING";
		protected static var STATE_CONFIRMED:String = "STATE_CONFIRMED";
		protected static var STATE_MOVING_LEVER:String = "STATE_MOVING_LEVER";
		protected static var STATE_COMPLETE:String = "STATE_COMPLETE";
		
		protected var curState = STATE_NOTHING;

	}
	
}
