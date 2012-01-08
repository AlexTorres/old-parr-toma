package co.oldparr.toma 
{
	import co.oldparr.toma.controller.AddMainWindowCommand;
	import co.oldparr.toma.controller.StarUpCommand;
	import co.oldparr.toma.event.RemoteEvent;
	import co.oldparr.toma.model.TomaModel;
	import co.oldparr.toma.remote.facebook.FacebookConnection;
	import co.oldparr.toma.remote.facebook.IFacebookConnection;
	import co.oldparr.toma.remote.xmlReader.IXMLReader;
	import co.oldparr.toma.remote.xmlReader.XMLReader;
	import co.oldparr.toma.view.friendsView.FriendsView;
	import co.oldparr.toma.view.friendsView.FriendsViewMediator;
	import co.oldparr.toma.view.friendsView.friendView.FriendView;
	import co.oldparr.toma.view.friendsView.friendView.FriendViewMediator;
	import co.oldparr.toma.view.imageView.ImageView;
	import co.oldparr.toma.view.imageView.ImageViewMediator;
	import co.oldparr.toma.view.mainWindow.MainWindowMediator;
	import co.oldparr.toma.view.mainWindow.MainWindowView;
	import co.oldparr.toma.view.photosView.PhotosView;
	import co.oldparr.toma.view.photosView.PhotosViewMediator;
	import co.oldparr.toma.view.userInfoView.UserInfoView;
	import co.oldparr.toma.view.userInfoView.UserInfoViewMediator;
	import co.oldparr.toma.view.userWallView.UserWallView;
	import co.oldparr.toma.view.userWallView.UserWallViewMediator;
	import co.oldparr.toma.view.userWallView.WallLink.WallLinkView;
	import co.oldparr.toma.view.userWallView.WallLink.WallLinkViewMediator;
	import co.oldparr.toma.view.userWallView.WallStatus.WallStatusView;
	import co.oldparr.toma.view.userWallView.WallStatus.WallStatusViewMediator;
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	import co.oldparr.toma.view.photosView.photoView.PhotoView;
	import co.oldparr.toma.view.photosView.photoView.PhotoViewMediator;

	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class TomaContext extends Context 
	{
		
		public function TomaContext(contextView:DisplayObjectContainer=null) 
		{
			super(contextView);
		}
		override public function startup():void
		{
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StarUpCommand, ContextEvent, true);
			commandMap.mapEvent(RemoteEvent.ON_XML_READED,AddMainWindowCommand, RemoteEvent);
			injector.mapSingleton(TomaModel);
			injector.mapSingletonOf( IXMLReader, XMLReader );
			injector.mapSingletonOf( IFacebookConnection, FacebookConnection);
			mediatorMap.mapView(MainWindowView, MainWindowMediator);
			mediatorMap.mapView(UserInfoView, UserInfoViewMediator);
			mediatorMap.mapView(ImageView, ImageViewMediator);
			mediatorMap.mapView(FriendsView, FriendsViewMediator);
			mediatorMap.mapView(FriendView, FriendViewMediator);
			mediatorMap.mapView(PhotosView, PhotosViewMediator);
			mediatorMap.mapView(PhotoView, PhotoViewMediator);
			mediatorMap.mapView(UserWallView, UserWallViewMediator);
			mediatorMap.mapView(WallStatusView, WallStatusViewMediator);
			mediatorMap.mapView(WallLinkView, WallLinkViewMediator);
			super.startup();	
			
		}
	}

}