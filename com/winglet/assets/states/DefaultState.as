package com.winglet.assets.states {
	import flash.display.MovieClip;
	import com.winglet.*;
	
	public class DefaultState {
		private var parentObj:MovieClip;
		
		public function DefaultState(param1) {
			// Default State
			parentObj = param1;
		}
		
		public function stateObj(currStateObj:StateObject):void {
			parentObj.helpBox.setBoxData(currStateObj.helpBoxObject);
			if(currStateObj.hasElements) {
				for (var i:Object in currStateObj.elementObjectArray) {
					parentObj.panelOperations.updateElementState(currStateObj.elementObjectArray[i]);
				}
			}
			
			if(currStateObj.hasHighlighting) {
				parentObj.hightlightFlightdeckPanel(currStateObj.highlightedPanels);
			} else {
				parentObj.hightlightFlightdeckPanel("none");
			}
			
			// Coplete some screen animations
			parentObj.completeCurrentScreenAnimation(currStateObj.screenObjectID);
			
			parentObj.completeNextState();
		}
		
	}
	
}