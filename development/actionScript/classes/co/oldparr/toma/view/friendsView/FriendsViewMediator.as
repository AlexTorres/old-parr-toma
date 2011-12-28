package co.oldparr.toma.view.friendsView 
{
	import co.oldparr.toma.event.ViewsEvent;
	import co.oldparr.toma.remote.facebook.IFacebookConnection;
	import co.oldparr.toma.view.friendsView.friendView.FriendView;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	import com.demonsters.debugger.MonsterDebugger;
	import co.oldparr.toma.remote.facebook.FacebookConnection;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class FriendsViewMediator extends Mediator 
	{
		[Inject]
		public var view:FriendsView;
		[Inject]
		public var fbservice:IFacebookConnection;
		
		public function FriendsViewMediator() 
		{
			MonsterDebugger.initialize(this);
			super();
		}
		override public function onRegister():void
		{
			addViewListener(Event.ADDED_TO_STAGE, init, Event);
		}
		
		private function init(e:Event):void 
		{
			removeViewListener(Event.ADDED_TO_STAGE, init);
			populateFriendList();
			
		}
		
		private function populateFriendList():void 
		{
		

			for (var i:int = 0; i < fbservice.friendsArray.length; i++ )
			{
				MonsterDebugger.trace(this, fbservice.friendsArray[i].id);
				var friendview:FriendView = new FriendView();
				view.addChild(friendview);
				friendview.y = 10 + ((friendview.height+10) * i);
				friendview.urlImageFriend = FacebookConnection.FRIEND_PICTURE.replace("{0}",fbservice.friendsArray[i].id)+fbservice.accessToken;
				friendview.friendName = fbservice.friendsArray[i].name;
				
			}
			

		}
		
	}

}