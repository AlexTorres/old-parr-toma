package co.oldparr.toma.view.friendsView.friendView 
{
	
	import co.oldparr.toma.event.ViewsEvent;
	import co.oldparr.toma.view.imageView.ImageView;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class FriendViewMediator extends Mediator 
	{
		[Inject]
		public var view:FriendView;
		private var userPhoto:ImageView;
		public function FriendViewMediator() 
		{
			super();
		}
		override public function onRegister():void
		{
			addViewListener(Event.ADDED_TO_STAGE, init, Event);
		}
		
		private function init(e:Event):void 
		{
			removeViewListener(Event.ADDED_TO_STAGE, init);
			addViewListener(ViewsEvent.ON_FRIEND_USER_URL, onLoadFriendPhoto, ViewsEvent);
			
		}
		
		private function onLoadFriendPhoto(e:ViewsEvent):void 
		{
			userPhoto = new ImageView();
			view.addChild(userPhoto);
			
			userPhoto.imageURL =view.urlImageFriend;
			userPhoto.onLoad();
			eventMap.mapListener(eventDispatcher, ViewsEvent.ON_IMAGE_FINISH_LOAD, onFinishUserPhoto);
		}
		
		
		private function onFinishUserPhoto(e:ViewsEvent):void 
		{
			
			e.stopImmediatePropagation();
			e.stopPropagation();
			//dispatch(new ViewsEvent(ViewsEvent.ON_FRIEND_USER_LOAD));
			
		}
		
	}

}