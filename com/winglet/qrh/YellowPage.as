package com.winglet.qrh {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import flash.events.Event;
	
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;

	import flash.net.URLLoader;

	import flash.net.URLRequest;
	import flash.text.TextFieldAutoSize;

	import com.winglet.qrh.IPhoneScroll;
	import flash.system.Capabilities;
	import com.winglet.qrh.Scrollbar;
	
	
	public class YellowPage extends MovieClip {
		private var _xmlPath:String = "";
		private var pageMargin:Number = 25;
		private var toggleBtn:Boolean = true;
		private var _panelBounds:Rectangle
		private var _chechHalfMove:Number
		private var _firstX:Number;
		private var _lastX:Number
		
		
		private var _mcContent:MovieClip;
		private var _scroller:IPhoneScroll;

		private var paraLength:Number;
		private var _dataObj:dataObj;
		private var _tableObj:table;
		private var xml:XML;
		private var mc:MovieClip = new MovieClip  ;
		private var storeObjPos:Object;
		public var _scrollStick:scrollStick = new scrollStick();
		private var contentHolder:MovieClip = new MovieClip;
		private var sBar:Scrollbar;
		private var onDown:Boolean = false;
		private var downMouseXpos:Number;
		public var loaded:Boolean = false;
		
		public function YellowPage(path:String) {
			// constructor code
			_xmlPath = path;
			init();
		}
		private function init():void{
			
			_panelBounds = new Rectangle(0, 0, this.width, this.height);
			yellow_ArrowBtn.buttonMode =true;
			yellow_ArrowBtn.addEventListener(MouseEvent.CLICK, arrowBtn)
			
		/*	
	if (Capabilities.manufacturer.toLowerCase().indexOf("ios") != -1)
			{
				main.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDownHandler, false, 0, true);
			}*/
	
			
		
		//main.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDownHandler, false, 0, true);
			_chechHalfMove = Number(this.x+(this.width/2)+pageMargin);
			_firstX = -411; //Number(this.x);
			_lastX = 0; //Number(this.x+this.width-pageMargin);
			loadXml();
		}
		
		private function loadXml():void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			var xmlLoader:URLLoader = new URLLoader  ;
			xmlLoader.addEventListener(Event.COMPLETE,showXML);
			//xmlLoader.load(new URLRequest("xml/yellowPage.xml"));
			xmlLoader.load(new URLRequest(_xmlPath));
		}
		
		private function showXML(e:Event):void {
			trace("YP.showXML: " + _xmlPath);
			loaded = true;
			xml = new XML(e.target.data);
			paraLength = xml.sub.para.length();
			main.mainTitle.htmlText = xml. @ title;
			main.subTitle.htmlText = xml.sub. @ title;
			createParaObj();
		}
		
		private function createParaObj():void {
			for (var i:Number=0; i<Number(paraLength); i++)
			{
				_dataObj = new dataObj();
				if (! storeObjPos)
				{
					storeObjPos = _dataObj;
					_dataObj.y = 0;
				}
				else
				{
					_dataObj.y = Number((storeObjPos.y+storeObjPos.height)+3);
				}
				_dataObj.txt.autoSize = TextFieldAutoSize.LEFT;
				_dataObj.txt.htmlText = xml.sub.para[i].displaydata;
				_dataObj.txt.autoSize = TextFieldAutoSize.LEFT;

				storeObjPos = _dataObj;
				if (xml.sub.para[i].@style == "table")
				{
					_tableObj = new table  ;
					_tableObj.x = 200;
					_tableObj.column1.autoSize = TextFieldAutoSize.LEFT;
					_tableObj.column2.autoSize = TextFieldAutoSize.LEFT;
					_tableObj.title.htmlText = xml.sub.para[i].tables.@title;
					_tableObj.column1.htmlText = xml.sub.para[i].tables.col1;
					_tableObj.column2.htmlText = xml.sub.para[i].tables.col2;
					_tableObj.tb.height = Number(_tableObj.column1.y + _tableObj.column1.textHeight) + 3;
					_tableObj.tb.height = Number(_tableObj.column2.y + _tableObj.column2.textHeight) + 3;
					_dataObj.addChild(_tableObj);
				}
				contentHolder.name = "contentHolder";
				contentHolder.addChild(_dataObj);
			}
			main.containerMc.addChild(contentHolder);
			if (Capabilities.manufacturer.toLowerCase().indexOf("ios") != -1)
			{
				main.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDownHandler);
				_scrollStick.name = "scrollSlider";
				_scrollStick.x = (main.containerMc.x +main.containerMc.width)-24;
				main.containerMc.addChild(contentHolder);
				main.containerMc.addChild(_scrollStick);
				
				_scroller = new IPhoneScroll(main.containerMc,main.maskMc,stage);
				_scroller.canvasHeight = main.maskMc.height;
				
			}
			else{
				sBar = new Scrollbar(main.containerMc,main.maskMc);// Create the instance for Scrollbar component class
				sBar.name = "ScrollBarMc";
				addChild(sBar);// add the instance in Stage
			}


		}
	
	private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, init);
			_scroller.release();
			_scroller = null;
		}
		
		
		private function _mouseDownHandler(event:MouseEvent):void {
			downMouseXpos = this.mouseX;
			TweenLite.killTweensOf(this);
			onDown = true;
			//this.startDrag(false, new Rectangle(_panelBounds.x - this.width, _panelBounds.y, this.width));
			this.stage.addEventListener(MouseEvent.MOUSE_UP, _mouseUpHandler, false, 0, true);
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, _mouseMoveHandler, false, 0, true);
			
		}
		
		private function _mouseMoveHandler(e:MouseEvent):void{
			if(onDown && downMouseXpos-70>this.mouseX){
				this.startDrag(false, new Rectangle(_panelBounds.x - this.width, _panelBounds.y, this.width));
			}
			else if(downMouseXpos<this.mouseX)
			{
				this.startDrag(false, new Rectangle(_panelBounds.x - this.width, _panelBounds.y, this.width));
			}
		}
		private function _mouseUpHandler(event:MouseEvent):void {
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, _mouseMoveHandler);
			onDown = false
			this.main.stopDrag();
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, _mouseUpHandler);
			//trace("this.x  "+this.x  +" ::::  _chechHalfMove  "+_chechHalfMove)
			
			if(this.x>_chechHalfMove){
				toggleBtn = false;
				yellow_ArrowBtn.rotation = 0;
				main.yellowTab.visible = false;
				TweenLite.to(this, 0.7, {x:_lastX, ease:Strong.easeOut});
				
			}
			else{
				toggleBtn = true;
				main.yellowTab.visible = true;
				yellow_ArrowBtn.rotation = 180;
				TweenLite.to(this, 0.7, {x:_firstX, ease:Strong.easeOut});
			}
		}
		
		
		private function arrowBtn(e:MouseEvent){
			if(toggleBtn){
				toggleBtn = false;
				main.yellowTab.visible = false;
				yellow_ArrowBtn.rotation = 0;
				TweenLite.to(this, 0.7, {x:_lastX, ease:Strong.easeOut});
				
				
			}
			else{
				toggleBtn = true;
				main.yellowTab.visible = true;
				yellow_ArrowBtn.rotation = 180;
				TweenLite.to(this, 0.7, {x:_firstX, ease:Strong.easeOut});
			}
		}
		
	}
	
}
