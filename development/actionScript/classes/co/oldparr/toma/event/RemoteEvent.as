package co.oldparr.toma.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class RemoteEvent extends Event 
	{
		
		public static const ON_XML_READED:String = "onXMLReaded";
		public static const ON__FACEBOOK_READY:String = "onFacebookReady";
		public function RemoteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new RemoteEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("RemoteEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}