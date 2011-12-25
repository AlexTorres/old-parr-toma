package co.oldparr.toma.view.mainWindow
{
	import co.oldparr.toma.model.TomaModel;
	import co.oldparr.toma.remote.xmlReader.IXMLReader;
	import co.oldparr.toma.view.interfaces.IStandardWindow;
	import flash.events.Event;
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
		
			removeViewListener(Event.ADDED_TO_STAGE, init);
		}
	
	}

}