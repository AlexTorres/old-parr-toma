package co.oldparr.toma.view.friendsView.friendView 
{
	
	import co.oldparr.toma.event.RemoteEvent;
	import co.oldparr.toma.event.ViewsEvent;
	import co.oldparr.toma.view.imageView.ImageView;
	import com.greensock.easing.Back;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	import com.greensock.easing.Bounce;
	import co.oldparr.toma.event.RemoteEvent;
	
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
			eventMap.mapListener(eventDispatcher, RemoteEvent.ON_ANIMATE_UP, onScale);
			
			
			
			view.sombrero.scaleX = 0;
			view.sombrero.scaleY = 0;
			//eventMap.mapListener(eventDispatcher, RemoteEvent.ON_SHOW_HATS, onShowHats);
		}
		
		private function onShowHats(e:RemoteEvent):void 
		{
			view.setChildIndex(view.sombrero, view.numChildren - 1);
			 TweenMax.to(view.sombrero,0.8,{scaleX:1,scaleY:1,ease:Bounce.easeOut,delay:Math.random()*0.8})
		}
		
		private function onScale(e:RemoteEvent):void 
		{
			TweenMax.to(view, 0.3, { y:view.y + 10, ease:Back.easeIn } );
		
		}
		
		private function onLoadFriendPhoto(e:ViewsEvent):void 
		{
			userPhoto = new ImageView();
			view.addChild(userPhoto);
			
			userPhoto.imageURL =view.urlImageFriend;
			userPhoto.onLoad();
		
		}
		
		
	
	}

}