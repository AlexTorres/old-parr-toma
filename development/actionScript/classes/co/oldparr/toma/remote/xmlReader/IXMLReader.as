package co.oldparr.toma.remote.xmlReader 
{
	import flash.display.DisplayObjectContainer;
	import org.casalib.load.DataLoad;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public interface IXMLReader 
	{
		function onLoad(contextView:DisplayObjectContainer):void;
		function get dataLoad():DataLoad;
	}
	
}