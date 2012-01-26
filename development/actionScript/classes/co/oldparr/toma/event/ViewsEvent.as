package co.oldparr.toma.event 
{
	import co.oldparr.toma.event.ICustomEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class ViewsEvent extends Event implements ICustomEvent
	{
		
		public static const ON_IMAGE_FINISH_LOAD :String = "on_image_finish_Load";
		public static const ON_FRIEND_USER_URL :String = "on_friend_user_URL";
		public static const ON_FRIEND_USER_LOAD :String = "on_friend_user_load";
		public static const ON_LOAD_COMPLETE_ALL:String = "on_Complete_All";
		public static const ON_ANIMATION_FINSHED:String = "on_animation_finish";
		public static const ON_TRACK_INTERMEDIATE:String = "on_track_intermediate";
		
		
		private var _data:Object;
		public function ViewsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,data:Object=null) 
		{ 
			this.data=data;
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ViewsEvent(type, bubbles, cancelable,data);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ViewsEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/* INTERFACE co.oldparr.toma.controller.ICustomEvent */
		
		public function set data(value:Object):void 
		{
			_data = value;
		}
		
		public function get data():Object 
		{
			return _data;
		}
		
	}
	
}