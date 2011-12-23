package co.oldparr.toma 
{
	import co.oldparr.toma.remote.IXMLReader;
	import co.oldparr.toma.remote.XMLReader;
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
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE,StarUpCommand, ContextEvent, true);
			injector.mapSingleton(TomaModel);
			injector.mapSingletonOf( IXMLReader, XMLReader );
			super.startup();	
			
		}
	}

}