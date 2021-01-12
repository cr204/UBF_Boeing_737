package com.winglet.datatype {
	
	public class VelocityObject	{
		public var pointerPosition:Number;
		public var time:Number;
		public var wait:Number;
		public var ease:String;
		public var xpoint:Number;
		public var xelement:String;
		public var loopID:String;
		
		public function VelocityObject(xml:XML) {
			pointerPosition = Number(xml.@pointerPosition);
			time = Number(xml.@time);
			wait = Number(xml.@wait);
			ease = xml.@ease.toString();
			xpoint = Number(xml.@xpoint);
			xelement = xml.@xelement.toString();
			loopID = xml.@loop.toString();
		}
	}
}