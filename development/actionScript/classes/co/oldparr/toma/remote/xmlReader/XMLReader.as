package co.oldparr.toma.remote.xmlReader 
{
	import co.oldparr.toma.event.RemoteEvent;
	import co.oldparr.toma.model.TomaModel;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import org.robotlegs.mvcs.Actor;
	import org.casalib.load.DataLoad;
	import org.casalib.events.LoadEvent;
	import org.casalib.util.LocationUtil;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class XMLReader extends Actor  implements IXMLReader
	{
		[Inject]
		public var model:TomaModel;
		
		protected var _dataLoad:DataLoad;
		
		public function XMLReader() 
		{
			super();
		}
		public function onLoad(contextView:DisplayObjectContainer):void
		{
			
			var urlXML:String;
			if (LocationUtil.isWeb(contextView))
				urlXML = "/xml/config.xml";
			else
				urlXML = "../../xml/config.xml";
		
			this._dataLoad = new DataLoad(urlXML);
			eventMap.mapListener(_dataLoad, LoadEvent.COMPLETE, onComplete);
           
			this._dataLoad.start();
		
		}
		
		private function onComplete(e:LoadEvent):void 
		{
			eventMap.unmapListener(_dataLoad, LoadEvent.COMPLETE, onComplete);
			dispatch(new RemoteEvent(RemoteEvent.ON_XML_READED));
		}
		
		public function get dataLoad():DataLoad 
		{
			return _dataLoad;
		}
		
		
	
	}

}