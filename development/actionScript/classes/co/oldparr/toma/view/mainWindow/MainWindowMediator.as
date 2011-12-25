package co.oldparr.toma.view.mainWindow
{
	import co.oldparr.toma.model.TomaModel;
	import co.oldparr.toma.remote.xmlReader.IXMLReader;
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	import org.robotlegs.mvcs.Mediator;
	
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class MainWindowMediator extends Mediator
	{
		[Inject]
		public var view:MainWindowView
		[Inject]
		public var model:TomaModel;
		[Inject]
		public var service:IXMLReader;
		
		private var faceBookColor:int = 0x465A99;
		private var spacer:CasaSprite;
		
		public function MainWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
		
			model.urlBack = service.dataLoad.dataAsXml.backURL.toString();
			model.audioPath = service.dataLoad.dataAsXml.audioPath.toString();
			model.imagePath = service.dataLoad.dataAsXml.imagePath.toString();
			model.swfPath = service.dataLoad.dataAsXml.swfPath.toString();
			model.swfPath = service.dataLoad.dataAsXml.videoPath.toString();
			addViewListener(Event.ADDED_TO_STAGE, init, Event);
			
		
		
		}
		private function init(e:Event):void 
		{
			spacer = new CasaSprite();
			spacer.graphics.beginFill(faceBookColor);
			spacer.graphics.drawRect(0, 0, 1, 41);
			spacer.graphics.endFill();
			removeViewListener(Event.ADDED_TO_STAGE, init);
		
			view.addChild(spacer);
			spacer.x = view.facebookBase.width-1;
			eventMap.mapListener(contextView.stage, Event.RESIZE, onResize);
			contextView.stage.dispatchEvent(new Event(Event.RESIZE));
		}
		
		private function onResize(e:Event):void 
		{
			
			if (contextView.stage.stageWidth > view.facebookBase.width)
			{
				trace("fuck yea", contextView.stage.stageWidth, view.facebookBase.width);
				spacer.width = (contextView.stage.stageWidth -view.facebookBase.width);
				
			}
			
		}
	
	}

}