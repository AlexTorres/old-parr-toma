package co.oldparr.toma.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class RemoteEvent extends Event 
	{
		
		public static const ON_XML_READED:String = "on_XML_Readed";
		public static const ON__FACEBOOK_READY:String = "on_Facebook_Ready";
		public static const ON_UI_FRIENDS:String = "facebook_ui_fiends";
		public static const ON_ANIMATE_PHOTOS:String = "on_animate_userPhotos";
		public static const ON_ANIMATE_UP:String = "on_animate_up";
		public static const ON_SHOW_HATS:String = "on_show_hats";
		public static const ON_RELOAD:String = "on_reload_Item";
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