package co.oldparr.toma.remote 
{
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
		
		
		protected var dataLoad:DataLoad;
		
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
			trace(urlXML);
			this.dataLoad = new DataLoad(urlXML);
            this.dataLoad.addEventListener(LoadEvent.COMPLETE, onComplete);
			this.dataLoad.start();
		}
		
		private function onComplete(e:LoadEvent):void 
		{
			trace(this.dataLoad.dataAsXml);
		
		}
		
	
	}

}