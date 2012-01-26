package co.oldparr.toma.view.mainWindow
{
	import co.oldparr.toma.event.RemoteEvent;
	import co.oldparr.toma.event.ViewsEvent;
	import co.oldparr.toma.model.TomaModel;
	import co.oldparr.toma.remote.facebook.FacebookConnection;
	import co.oldparr.toma.remote.facebook.IFacebookConnection;
	import co.oldparr.toma.remote.xmlReader.IXMLReader;
	import co.oldparr.toma.view.explodeView.ExplodeView;
	import co.oldparr.toma.view.friendsView.FriendsView;
	import co.oldparr.toma.view.imageView.ImageView;
	import co.oldparr.toma.view.photosView.PhotosView;
	import co.oldparr.toma.view.userInfoView.UserInfoView;
	import co.oldparr.toma.view.userWallView.UserWallView;
	import com.greensock.easing.Back;
	import fl.video.MetadataEvent;
	import fl.video.VideoEvent;
	import fl.video.VideoProgressEvent;
	import flash.events.StatusEvent;
	import org.casalib.util.NavigateUtil;

	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quint;
	import com.greensock.TweenMax;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import org.casalib.display.CasaSprite;
	import org.casalib.events.VideoInfoEvent;
	import org.casalib.events.VideoLoadEvent;
	import org.casalib.load.VideoLoad;
	import org.casalib.util.LocationUtil;
	import org.robotlegs.mvcs.Mediator;
	import co.oldparr.toma.utils.ScaleAnimation;
	import fl.video.FLVPlayback;
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
		private static const DELTAT:Number = 0.8;
		
		private var faceBookColor:int = 0x465A99;
		private var spacer:CasaSprite;
		private var offSet:Number = 503;
		private var loader:URLLoader;
		private var videoLoad:FLVPlayback;
		private var animation1:ScaleAnimation;
		private var animation2:ScaleAnimation;
		
		public function MainWindowMediator()
		{
			
			super();
		}
		
		override public function onRegister():void
		{
		
			model.urlFront = service.dataLoad.dataAsXml.frontURL.toString();
			model.urlBack = service.dataLoad.dataAsXml.backURL.toString();
			model.audioPath = service.dataLoad.dataAsXml.audioPath.toString();
			model.imagePath = service.dataLoad.dataAsXml.imagesPath.toString();
			model.swfPath = service.dataLoad.dataAsXml.swfPath.toString();
			model.videoPath = service.dataLoad.dataAsXml.videoPath.toString();
			fbservice.appID = service.dataLoad.dataAsXml.facebookAppID.toString();
			trace("video path", model.videoPath);
			
			addViewListener(Event.ADDED_TO_STAGE, init, Event);
		
		}
		
		private function init(e:Event):void
		{
			onInitContidionsAnimations();
			spacer = new CasaSprite();
			spacer.graphics.beginFill(faceBookColor);
			spacer.graphics.drawRect(0, 0, 1, 41);
			spacer.graphics.endFill();
			removeViewListener(Event.ADDED_TO_STAGE, init);
			view.addChild(spacer);
			spacer.x = view.facebookBase.width - 1;
			eventMap.mapListener(contextView.stage, Event.RESIZE, onResize);
			contextView.stage.dispatchEvent(new Event(Event.RESIZE));
			if (LocationUtil.isWeb(view))
			{
				fbservice.onLoadFacebookInfo();
			}
			else
			{
				onLoadVideo();
			}
			eventMap.mapListener(eventDispatcher, RemoteEvent.ON__FACEBOOK_READY, onFBDataReady);
			eventMap.mapListener(eventDispatcher, ViewsEvent.ON_IMAGE_FINISH_LOAD, onFinishUserPhoto);
			eventMap.mapListener(contextView, RemoteEvent.ON_UI_FRIENDS, onFacebookUICall);
			eventMap.mapListener(contextView, RemoteEvent.ON_RELOAD, onReload);
		
		}
		
		private function onReload(e:RemoteEvent):void 
		{
			NavigateUtil.openUrl(model.urlFront);
		}
		
		private function onLoadVideo():void
		{
			var videoString:String;
			if (LocationUtil.isWeb(view))
			{
				videoString = model.urlFront + model.videoPath + "videoFinal.flv";
			}
			else
			{
				videoString =model.urlFront + model.videoPath + "videoFinal.flv";
			}
			
			/*videoLoad = new VideoLoad(videoString);
			videoLoad.pauseStart = true;
			videoLoad.addEventListener(VideoLoadEvent.PROGRESS, onProgress, false, 0, true);
			videoLoad.addEventListener(VideoLoadEvent.BUFFERED, onBuffered, false, 0, true);
			videoLoad.addEventListener(VideoInfoEvent.CUE_POINT, onCue_Point, false, 0, true);
			videoLoad.start();*/
			videoLoad = new FLVPlayback();
			videoLoad.autoPlay = false;
			videoLoad.addEventListener(MetadataEvent.CUE_POINT, onCue_Point, false, 0, true);
			videoLoad.addEventListener(VideoProgressEvent.PROGRESS, onProgress, false, 0, true);
			videoLoad.addEventListener(VideoEvent.READY,onBuffered,false,0,true);
			videoLoad.source=videoString;
		
		}
		
		private function onCue_Point(e:MetadataEvent):void
		{
			
			//MonsterDebugger.trace(this, e);
			trace(e.info.name)
			if (e.info.name == "CaePendon")
			{
				
				startAnimations();
			}
			if (e.info.name == "Paso1"||e.info.name == "Paso2"||e.info.name == "Paso3")
			{
				if (e.info.name == "Paso1")
				{
					dispatch(new RemoteEvent(RemoteEvent.ON_SHOW_HATS));
					TweenMax.to(view.fakeItem,DELTAT,{scaleX:1,scaleY:1,ease:Back.easeOut});
				}
				dispatch(new RemoteEvent(RemoteEvent.ON_ANIMATE_UP,true));
				TweenMax.to(view.sections, 0.3, { y:view.sections.y + 10, ease:Back.easeIn } );
			
				trace("gatoo");
			}
			if (e.info.name == "SubeVol")
			{
				animation1.maxScale = 1.03;
				animation2.maxScale = 1.03;
				animation1.minScale = 0.97;
				animation2.minScale = 0.97;
			}
			if (e.info.name == "Foto")
			{
				TweenMax.delayedCall(DELTAT * 10, onGoShare);
				view.setChildIndex(view.sharedPhoto, view.numChildren - 1);
				//TweenMax.to(view.sharedPhoto, DELTAT , { autoAlpha: 1, delay:DELTAT * 2});
				//TweenMax.to(videoLoad.video, DELTAT, { alpha: 0 } );
				TweenMax.to(view.thumb, DELTAT, { scaleX: 1, scaleY:1, delay:2, ease:Elastic.easeOut } ); 
				dispatch(new ViewsEvent(RemoteEvent.ON_ANIMATE_PHOTOS));
				animation1.maxScale = 1;
				animation2.maxScale = 1;
				animation1.minScale = 1;
				animation2.minScale = 1;
				//videoLoad.netStream.togglePause();
			}
		}
		
		private function onBuffered(e:VideoEvent):void
		{
			
			
			onChargeAddVideo();
		
		}
		
		private function onStartVideo():void
		{
			videoLoad.play();
			animation1 = new ScaleAnimation(view.bocinaUp, 1.01, 0.99);
			animation2 = new ScaleAnimation(view.bocinaDown, 1.01, 0.99);
		}
		
		private function onProgress(e:VideoProgressEvent):void
		{
			//MonsterDebugger.trace(this,e.progress);
			var progress:Number = e.bytesLoaded / e.bytesTotal;
			if (Number(progress) < 0.99 && !model.onLoadVideo)
			{
				//onChargeAddVideo();
				//videoLoad.netStream.addEventListener(StatusEvent.STATUS
			}
			else
			{
				//contextView.dispatchEvent(e);
			}
		
		}
		
		private function onChargeAddVideo():void
		{
			trace("vifeo cargado");
			model.onLoadVideo = true;
			contextView.dispatchEvent(new ViewsEvent(ViewsEvent.ON_LOAD_COMPLETE_ALL, true, true));
			view.addChild(videoLoad);
			videoLoad.x = -963.9;
			videoLoad.y = -42.95;
			videoLoad.width = 1920;
			videoLoad.height = 1080;
			videoLoad.alpha = 0;
			TweenMax.to(videoLoad, DELTAT * 2.5, {alpha: 1, onComplete: onStartVideo});
		
		}
		
		private function onFacebookUICall(e:RemoteEvent):void
		{
			fbservice.onFriendsUI();
			if (!model.onUplodaPhotoYet)
			{
				view.sharedPhoto.alpha = 1;
				view.setChildIndex(view.sharedPhoto, view.numChildren - 1);
				var bitmapData:BitmapData = new BitmapData(view.sharedPhoto.width, view.sharedPhoto.height);
				bitmapData.draw(view, new Matrix(1, 0, 0, 1, 285.6, -242.35));
				fbservice.onUploadFunction(bitmapData);
				model.onUplodaPhotoYet = true;
				fbservice.onPushPost();
			}
		
		}
		
		private function onInitContidionsAnimations():void
		{
			view.cintasFront.alpha = 0;
			view.esquinas.tira_L.x = view.esquinas.tira_L.x + 25;
			view.esquinas.tira_R.x = view.esquinas.tira_R.x - 25;
			view.cintasBack.y = -view.cintasBack.height;
			view.backTexture.maskTextureL.x = view.backTexture.maskTextureL.x + view.backTexture.maskTextureL.width;
			view.backTexture.maskTextureR.x = view.backTexture.maskTextureR.x - view.backTexture.maskTextureR.width;
			view.torosAnimations.toroL.rotationZ = 45;
			view.torosAnimations.toroR.rotationZ = 135;
			//view.torosAnimations.toroR.rotationZ = 180;
			view.torosAnimations.toroL.x = view.torosAnimations.toroL.x + 25;
			view.torosAnimations.toroR.x = view.torosAnimations.toroR.x - 25;
			//view.adornosVector.adornosVectorL.scaleX = view.adornosVector.adornosVectorL.scaleY = 0;
			view.adornosVector.adornosVectorL.rotationZ = -90;
			//view.adornosVector.adornosVectorR.scaleX = view.adornosVector.adornosVectorR.scaleY = 0;
			view.adornosVector.adornosVectorR.rotationZ = 90;
			view.sharedPhoto.alpha = 0;
			view.thumb.scaleX = 0;
			view.thumb.scaleY = 0;
			view.fakeItem.scaleX = 0;
			view.fakeItem.scaleY = 0;
		
			//trace(view.torosAnimations.toroR.rotationZ,"lorem ipsum dolor sit amet");
		
			//TweenMax.to(view.torosAnimations.toroR,10,{rotationZ:-45} );
		
		}
		
		private function onSendBack():void
		{
			
			var url:String = model.urlBack + "/users/add";
			var request:URLRequest = new URLRequest(url);
			var user:Object = new Object();
			
			var variables:URLVariables = new URLVariables();
			
			variables["data[User][name]"] = fbservice.userObject.name;
			variables["data[User][facebookid]"] = fbservice.userObject.id;
			
			if (fbservice.userObject.location != null)
			{
				variables["data[User][current_city]"] = fbservice.userObject.location.name;
			}
			else
			{
				variables["data[User][current_city]"] = "Colombia";
			}
			if (fbservice.userObject.gender != null)
			{
				variables["data[User][sex]"] = fbservice.userObject.gender;
			}
			else
			{
				variables["data[User][sex]"] = "N/A";
			}
			if (fbservice.userObject.birthday != null)
			{
				variables["data[User][birth_date]"] = fbservice.userObject.birthday;
			}
			else
			{
				variables["data[User][birth_date]"] = "N/A";
			}
			variables["data[User][email]"] = fbservice.userObject.email;
			
			request.data = variables;
			request.method = URLRequestMethod.POST;
			
			loader = new URLLoader();
			loader.load(request);
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, onCompleteBBDD, false, 0, true);
		
		}
		
		private function onCompleteBBDD(e:Event):void
		{
			var userInfoView:UserInfoView = new UserInfoView;
			view.addChild(userInfoView);
			userInfoView.x = TomaModel.USER_INFO_POINT.x - offSet;
			userInfoView.y = TomaModel.USER_INFO_POINT.y;
		}
		
		private function onFinishUserPhoto(e:ViewsEvent):void
		{
			eventMap.unmapListener(eventDispatcher, ViewsEvent.ON_IMAGE_FINISH_LOAD, onFinishUserPhoto);
			view.sections.y = TomaModel.USER_INFO_POINT.y + e.data.height + 10;
			var friendsView:FriendsView = new FriendsView();
			var imageView:ImageView = new ImageView();
			imageView.imageURL = FacebookConnection.USER_PHOTO_SMALL + fbservice.accessToken;
			view.fakeItem.photoContainer.addChild(imageView);
			view.fakeItem.title_txt.text = fbservice.userObject.name;
			view.fakeItem.text_txt.text=fbservice.userObject.name + " está viviendo el carnaval de una forma diferente.";
			friendsView.y = view.sections.y + view.sections.height;
			friendsView.x = 9 - offSet;
			view.addChild(friendsView);
			eventMap.mapListener(eventDispatcher, ViewsEvent.ON_IMAGE_FINISH_LOAD, onFinishLoadPhoto);
			onAddPhotosView();
			onAddWallView();
			imageView.onLoad();
			
		}
		
		private function onFinishLoadPhoto(e:ViewsEvent):void
		{
			
			if (model.imageCount == 0)
			{
				//startAnimations();
				trace("entra y llama al vifeo");
				TweenMax.delayedCall(DELTAT * 2.5, onLoadVideo);
				
			}
		}
		
		private function onPublishPhoto():void
		{
		
			//eventMap.mapListener(view.sharedPhoto, MouseEvent.CLICK, onClickFalse);
			//view.sharedPhoto.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		
		}
		
		private function onClickFalse(e:MouseEvent):void
		{
			eventMap.unmapListener(view.sharedPhoto, MouseEvent.CLICK, onClickFalse);
		
		}
		
		private function onGoShare():void
		{
			contextView.dispatchEvent(new ViewsEvent(ViewsEvent.ON_ANIMATION_FINSHED, true, true));
		
		}
		
		private function startAnimations():void
		{
			
			view.setChildIndex(view.cintasFront, view.numChildren - 1);
			view.setChildIndex(videoLoad, view.numChildren - 1);
			TweenMax.to(view.cintasFront, DELTAT, {alpha: 1, ease: Quint.easeIn});
			TweenMax.to(view.esquinas.tira_L, DELTAT * 2.5, {x: view.esquinas.tira_L.x - 25, ease: Elastic.easeOut});
			TweenMax.to(view.esquinas.tira_R, DELTAT * 2.5, {x: view.esquinas.tira_R.x + 25, ease: Elastic.easeOut});
			TweenMax.to(view.cintasBack, DELTAT * 2.5, {y: -26, ease: Bounce.easeOut});
			TweenMax.delayedCall(DELTAT * 2.5, startAnimations2);
		}
		
		private function startAnimations2():void
		{
			TweenMax.to(view.backTexture.maskTextureL, DELTAT * 2.5, {x: view.backTexture.maskTextureL.x - view.backTexture.maskTextureL.width});
			TweenMax.to(view.backTexture.maskTextureR, DELTAT * 2.5, {x: view.backTexture.maskTextureR.x + view.backTexture.maskTextureR.width});
			TweenMax.to(view.torosAnimations.toroL, DELTAT * 3, {rotationZ: 0, x: view.torosAnimations.toroL.x - 25, delay: DELTAT * 1.5, ease: Bounce.easeOut});
			TweenMax.to(view.torosAnimations.toroR, DELTAT * 3, {rotationZ: 180, x: view.torosAnimations.toroR.x + 25, delay: DELTAT, ease: Bounce.easeOut});
			
			TweenMax.to(view.adornosVector.adornosVectorL, DELTAT * 2.5, {scaleX: 1, scaleY: 1, rotationZ: 0, delay: DELTAT * 4.5, ease: Bounce.easeOut});
			TweenMax.to(view.adornosVector.adornosVectorR, DELTAT * 2.5, {scaleX: 1, scaleY: 1, rotationZ: 0, delay: DELTAT * 4.5, ease: Bounce.easeOut});
			TweenMax.delayedCall(DELTAT * 3, startAnimationsParticle);
		
		}
		
		public function startAnimationsParticle():void
		{
			//trace("nooo");
			var myEmitt:ExplodeView = new ExplodeView();
			contextView.dispatchEvent(new ViewsEvent (ViewsEvent.ON_TRACK_INTERMEDIATE,true,true));
			view.emiterL.addChild(myEmitt);
			myEmitt.onCreateEmition(-Math.PI * 1.5, Math.PI, 400, 0);
			var myEmitt2:ExplodeView = new ExplodeView();
			view.emiterR.addChild(myEmitt2);
			myEmitt2.onCreateEmition(0, Math.PI / 2, 0, 0);
			var myEmitt3:ExplodeView = new ExplodeView();
			view.addChild(myEmitt3);
			myEmitt3.onCreateEmition(0, 0, 500, 0, false);
			myEmitt3.x = -500;
			myEmitt3.y = -50;
		}
		
		private function onAddWallView():void
		{
			var userWallView:UserWallView = new UserWallView();
			view.addChild(userWallView);
			userWallView.x = 210.85 - offSet;
			userWallView.y = 280.95;
		}
		
		private function onAddPhotosView():void
		{
			var photosView:PhotosView = new PhotosView();
			view.addChild(photosView);
			photosView.y = 161.35;
			photosView.x = 213.85 - offSet;
		}
		
		private function onFBDataReady(e:RemoteEvent):void
		{
			onSendBack();
		}
		
		private function onResize(e:Event):void
		{
			
			if (contextView.stage.stageWidth > view.facebookBase.width)
			{
				
				spacer.width = (contextView.stage.stageWidth - view.facebookBase.width);
				
			}
			
			view.x = ((contextView.stage.stageWidth) / 2);
		}
	
	}

}