package com.winglet.operations {
	
	import com.greensock.TweenLite;
	
	public class ScreenElementOperations {
		private var currElement:*;
		
		public function ScreenElementOperations() {
			
		}
		
		public function completeOperation(elm:*, xml:XML):void {
			
			var waitTime:Number = Number(xml.@wait.toString());
			
			if(waitTime>0) {
				TweenLite.to(this, waitTime, {onComplete:doOperation, overwrite:false, onCompleteParams:[elm, xml]});
			} else {
				doOperation(elm, xml)
			}

		}
		
		private function doOperation(elm:*, xml:XML) {
			
			switch(xml.@property.toString()) {
				case "visible":
					if(xml.@value.toString()=="false") elm.visible = false else elm.visible = true;
					break;
				case "gotoFrame":
					if(int(xml.@value)>0) elm.gotoAndStop(int(xml.@value));
					break;
				case "gotoAndPlay":
					if(int(xml.@value)>0) elm.gotoAndPlay(int(xml.@value));
					break;
				case "text":
					elm.text = xml.@value.toString();
					break;
					
				default:
					//
					break;
			}
		}
		
	}
}