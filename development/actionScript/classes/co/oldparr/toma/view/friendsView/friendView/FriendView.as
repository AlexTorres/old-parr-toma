package co.oldparr.toma.view.friendsView.friendView 
{
	
	import co.oldparr.view.friendsView.Friend;
	import co.oldparr.toma.event.ViewsEvent;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class FriendView extends Friend 
	{
		
		private var _friendName:String
		private var _urlImageFriend:String;
	
		public function FriendView() 
		{
			
		}
		
		public function get friendName():String 
		{
			return _friendName;
		}
		
		public function set friendName(value:String):void 
		{
			_friendName = value;
			this.friendName_txt.text = value;
		}
		
		public function get urlImageFriend():String 
		{
			return _urlImageFriend;
		}
		
		public function set urlImageFriend(value:String):void 
		{
			_urlImageFriend = value;
			dispatchEvent(new ViewsEvent(ViewsEvent.ON_FRIEND_USER_URL));
		}
		
		
	}

}








