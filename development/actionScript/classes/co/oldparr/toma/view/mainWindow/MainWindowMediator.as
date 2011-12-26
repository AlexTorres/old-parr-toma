package co.oldparr.toma.view.mainWindow
{
	import co.oldparr.toma.event.RemoteEvent;
	import co.oldparr.toma.model.TomaModel;
	import co.oldparr.toma.remote.facebook.IFacebookConnection;
	import co.oldparr.toma.remote.xmlReader.IXMLReader;
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	import org.robotlegs.mvcs.Mediator;
	import com.demonsters.debugger.MonsterDebugger;
	
	
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
		[Inject]
		public var fbservice:IFacebookConnection;
		
		private var faceBookColor:int = 0x465A99;
		private var spacer:CasaSprite;
		
		public function MainWindowMediator()
		{
			MonsterDebugger.initialize(this);
			super();
		}
		
		override public function onRegister():void
		{
		
			model.urlBack = service.dataLoad.dataAsXml.backURL.toString();
			model.audioPath = service.dataLoad.dataAsXml.audioPath.toString();
			model.imagePath = service.dataLoad.dataAsXml.imagePath.toString();
			model.swfPath = service.dataLoad.dataAsXml.swfPath.toString();
			model.swfPath = service.dataLoad.dataAsXml.videoPath.toString();
			fbservice.appID = service.dataLoad.dataAsXml.facebookAppID.toString();
			
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
			fbservice.onLoadFacebookInfo();
			eventMap.mapListener(eventDispatcher, RemoteEvent.ON__FACEBOOK_READY, onFBDataReady);
			
		}
		
		private function onFBDataReady(e:RemoteEvent):void 
		{
			MonsterDebugger.trace(this,"hell yea");
		}
		
		private function onResize(e:Event):void 
		{
			
			if (contextView.stage.stageWidth > view.facebookBase.width)
			{
	
				spacer.width = (contextView.stage.stageWidth -view.facebookBase.width);
				
			}
			
		}
	
	}

}