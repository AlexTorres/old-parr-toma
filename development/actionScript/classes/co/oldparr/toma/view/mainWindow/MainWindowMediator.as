package co.oldparr.toma.view.mainWindow
{
	import co.oldparr.toma.event.RemoteEvent;
	import co.oldparr.toma.event.ViewsEvent;
	import co.oldparr.toma.model.TomaModel;
	import co.oldparr.toma.remote.facebook.IFacebookConnection;
	import co.oldparr.toma.remote.xmlReader.IXMLReader;
	import co.oldparr.toma.view.friendsView.FriendsView;
	import co.oldparr.toma.view.photosView.PhotosView;
	import co.oldparr.toma.view.userInfoView.UserInfoView;
	import co.oldparr.toma.view.userWallView.UserWallView;
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	import org.robotlegs.mvcs.Mediator;
	
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class MainWindowMediator extends Mediator
	{
		[Inject]
		public var view:MainWindowView
		[Inject]
		public var model:TomaModel;
		[Inject]
		public var service:IXMLReader;
		[Inject]
		public var fbservice:IFacebookConnection;
		
		private var faceBookColor:int = 0x465A99;
		private var spacer:CasaSprite;
		private var offSet:Number = 503;
		
		public function MainWindowMediator()
		{
		
			super();
		}
		
		override public function onRegister():void
		{
		
			model.urlBack = service.dataLoad.dataAsXml.backURL.toString();
			model.audioPath = service.dataLoad.dataAsXml.audioPath.toString();
			model.imagePath = service.dataLoad.dataAsXml.imagePath.toString();
			model.swfPath = service.dataLoad.dataAsXml.swfPath.toString();
			model.swfPath = service.dataLoad.dataAsXml.videoPath.toString();
			fbservice.appID = service.dataLoad.dataAsXml.facebookAppID.toString();
			
			addViewListener(Event.ADDED_TO_STAGE, init, Event);
			
		
		
		}
		private function init(e:Event):void 
		{
			spacer = new CasaSprite();
			spacer.graphics.beginFill(faceBookColor);
			spacer.graphics.drawRect(0, 0, 1, 41);
			spacer.graphics.endFill();
			removeViewListener(Event.ADDED_TO_STAGE, init);
			
		
			view.addChild(spacer);
			spacer.x = view.facebookBase.width-1;
			eventMap.mapListener(contextView.stage, Event.RESIZE, onResize);
			contextView.stage.dispatchEvent(new Event(Event.RESIZE));
			fbservice.onLoadFacebookInfo();
			eventMap.mapListener(eventDispatcher, RemoteEvent.ON__FACEBOOK_READY, onFBDataReady);
			eventMap.mapListener(eventDispatcher, ViewsEvent.ON_IMAGE_FINISH_LOAD, onFinishUserPhoto);
			
		}
		
		private function onFinishUserPhoto(e:ViewsEvent):void 
		{
			eventMap.unmapListener(eventDispatcher, ViewsEvent.ON_IMAGE_FINISH_LOAD, onFinishUserPhoto);
			view.sections.y = TomaModel.USER_INFO_POINT.y + e.data.height + 10;
			var friendsView:FriendsView = new FriendsView();
			friendsView.y = view.sections.y +view.sections.height;
			friendsView.x = 9-offSet;
			view.addChild(friendsView);
			onAddPhotosView();
			onAddWallView();
			
	
			
		}
		
		private function onAddWallView():void 
		{
			var userWallView:UserWallView = new UserWallView();
			view.addChild(userWallView);
			userWallView.x = 210.85-offSet;
			userWallView.y = 280.95;
		}
		private function onAddPhotosView():void
		{
			var photosView:PhotosView = new PhotosView();
			view.addChild(photosView);
			photosView.y = 161.35;
			photosView.x = 213.85-offSet;
		}
		private function onFBDataReady(e:RemoteEvent):void 
		{
			
			var userInfoView:UserInfoView=new UserInfoView;
			view.addChild(userInfoView);
			userInfoView.x = TomaModel.USER_INFO_POINT.x-offSet;
			userInfoView.y = TomaModel.USER_INFO_POINT.y;
		}
		
		private function onResize(e:Event):void 
		{
			
			if (contextView.stage.stageWidth > view.facebookBase.width)
			{
	
				spacer.width = (contextView.stage.stageWidth -view.facebookBase.width);
				
			}
			
			view.x=((contextView.stage.stageWidth)/2)
		}
	
	}

}