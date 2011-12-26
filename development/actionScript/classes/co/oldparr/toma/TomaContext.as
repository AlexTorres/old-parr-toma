package co.oldparr.toma 
{
	import co.oldparr.toma.controller.AddMainWindowCommand;
	import co.oldparr.toma.event.RemoteEvent;
	import co.oldparr.toma.remote.facebook.FacebookConnection;
	import co.oldparr.toma.remote.facebook.IFacebookConnection;
	import co.oldparr.toma.remote.xmlReader.IXMLReader;
	import co.oldparr.toma.remote.xmlReader.XMLReader;
	import co.oldparr.toma.view.mainWindow.MainWindowView;
	import co.oldparr.toma.view.mainWindow.MainWindowMediator;
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.mvcs.Context;
	import co.oldparr.toma.model.TomaModel;
	import org.robotlegs.base.ContextEvent;
	import co.oldparr.toma.controller.StarUpCommand;
	
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class TomaContext extends Context 
	{
		
		public function TomaContext(contextView:DisplayObjectContainer=null) 
		{
			super(contextView);
		}
		override public function startup():void
		{
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StarUpCommand, ContextEvent, true);
			commandMap.mapEvent(RemoteEvent.ON_XML_READED,AddMainWindowCommand, RemoteEvent);
			injector.mapSingleton(TomaModel);
			injector.mapSingletonOf( IXMLReader, XMLReader );
			injector.mapSingletonOf( IFacebookConnection, FacebookConnection);
			mediatorMap.mapView(MainWindowView, MainWindowMediator);
			super.startup();	
			
		}
	}

}