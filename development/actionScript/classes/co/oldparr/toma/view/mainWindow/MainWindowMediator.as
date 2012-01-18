package co.oldparr.toma.view.mainWindow
{
	import co.oldparr.toma.event.RemoteEvent;
	import co.oldparr.toma.event.ViewsEvent;
	import co.oldparr.toma.model.TomaModel;
	import co.oldparr.toma.remote.facebook.IFacebookConnection;
	import co.oldparr.toma.remote.xmlReader.IXMLReader;
	import co.oldparr.toma.view.explodeView.ExplodeView;
	import co.oldparr.toma.view.friendsView.FriendsView;
	import co.oldparr.toma.view.photosView.PhotosView;
	import co.oldparr.toma.view.userInfoView.UserInfoView;
	import co.oldparr.toma.view.userWallView.UserWallView;
	import com.adobe.serialization.json.JSON;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import org.casalib.display.CasaSprite;
	import org.robotlegs.mvcs.Mediator;
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quint;
	import com.greensock.easing.Bounce;
	
	
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
		
		public function MainWindowMediator()
		{
		
			super();
		}
		
		override public function onRegister():void
		{
			MonsterDebugger.initialize(this);
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
			onInitContidionsAnimations();
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
			view.adornosVector.adornosVectorL.x = view.adornosVector.adornosVectorL.x + view.adornosVector.adornosVectorL.width;
			view.adornosVector.adornosVectorL.y = view.adornosVector.adornosVectorL.y + view.adornosVector.adornosVectorL.height;
			//view.adornosVector.adornosVectorR.scaleX = view.adornosVector.adornosVectorR.scaleY = 0;
			view.adornosVector.adornosVectorR.x = view.adornosVector.adornosVectorR.x - view.adornosVector.adornosVectorR.width;
			view.adornosVector.adornosVectorR.y = view.adornosVector.adornosVectorR.y+ view.adornosVector.adornosVectorR.height;
			//trace(view.torosAnimations.toroR.rotationZ,"lorem ipsum dolor sit amet");
			
			//TweenMax.to(view.torosAnimations.toroR,10,{rotationZ:-45} );
			

			
		}
		private function onSendBack ():void
		{
		
			var url:String = model.urlBack+"/users/add";
            var request:URLRequest = new URLRequest(url);
			var user:Object = new Object();
			
            var variables:URLVariables = new URLVariables();
			MonsterDebugger.trace(this, fbservice.userObject.name);
		
			
			variables["data[User][name]"] = fbservice.userObject.name;
			variables["data[User][facebookid]"] = fbservice.userObject.id;
		
			
			if (fbservice.userObject.location!= null)
			{
				variables["data[User][current_city]"] = fbservice.userObject.location.name;
			}
			else
			{
				variables["data[User][current_city]"]  =  "Colombia";
			}
			if (fbservice.userObject.gender != null)
			{
				variables["data[User][sex]"] = fbservice.userObject.gender;
			}
			else
			{
				variables["data[User][sex]"]  = "N/A";
			}
			if (fbservice.userObject.birthday != null)
			{
				variables["data[User][birth_date]"]  = fbservice.userObject.birthday;
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
			MonsterDebugger.trace(this,loader.data);
			
			
			//MonsterDebugger.trace(this, JSON.decode(loader.data));
			
			var userInfoView:UserInfoView=new UserInfoView;
			view.addChild(userInfoView);
			userInfoView.x = TomaModel.USER_INFO_POINT.x-offSet;
			userInfoView.y = TomaModel.USER_INFO_POINT.y;
		}
		
		private function onFinishUserPhoto(e:ViewsEvent):void 
		{
			eventMap.unmapListener(eventDispatcher, ViewsEvent.ON_IMAGE_FINISH_LOAD, onFinishUserPhoto);
			view.sections.y = TomaModel.USER_INFO_POINT.y + e.data.height + 10;
			var friendsView:FriendsView = new FriendsView();
			friendsView.y = view.sections.y +view.sections.height;
			friendsView.x = 9-offSet;
			view.addChild(friendsView);
			eventMap.mapListener(eventDispatcher, ViewsEvent.ON_IMAGE_FINISH_LOAD, onFinishLoadPhoto);
			onAddPhotosView();
			onAddWallView();
			
	
			
		}
		
		private function onFinishLoadPhoto(e:ViewsEvent):void 
		{
			
			if (model.imageCount == 0)
			{
				startAnimations();
				
			}
		}
		
		private function startAnimations():void 
		{
			view.setChildIndex(view.cintasFront, view.numChildren - 1);
			TweenMax.to(view.cintasFront, DELTAT, { alpha:1, ease:Quint.easeIn } );
			TweenMax.to(view.esquinas.tira_L, DELTAT, { x:view.esquinas.tira_L.x - 25, ease:Elastic.easeOut } );
			TweenMax.to(view.esquinas.tira_R, DELTAT, { x:view.esquinas.tira_R.x + 25, ease:Elastic.easeOut } );
			TweenMax.to(view.cintasBack, DELTAT, { y: -26, ease:Bounce.easeOut } );
			TweenMax.delayedCall(DELTAT, startAnimations2);
		}
		
		private function startAnimations2():void 
		{
			TweenMax.to(view.backTexture.maskTextureL, DELTAT, { x:view.backTexture.maskTextureL.x - view.backTexture.maskTextureL.width } );
			TweenMax.to(view.backTexture.maskTextureR, DELTAT, { x:view.backTexture.maskTextureR.x + view.backTexture.maskTextureR.width } );
			TweenMax.to(view.torosAnimations.toroL, DELTAT, { rotationZ:0 , x:view.torosAnimations.toroL.x - 25, delay:DELTAT, ease:Bounce.easeOut } );
			TweenMax.to(view.torosAnimations.toroR, DELTAT, { rotationZ:180 , x:view.torosAnimations.toroR.x + 25, delay:DELTAT, ease:Bounce.easeOut } );
			
			TweenMax.to(view.adornosVector.adornosVectorL, DELTAT, { scaleX:1 , scaleY:1, x:view.adornosVector.adornosVectorL.x - view.adornosVector.adornosVectorL.width, y:view.adornosVector.adornosVectorL.y - view.adornosVector.adornosVectorL.height, delay:DELTAT*2, ease:Quint.easeIn } );
			TweenMax.to(view.adornosVector.adornosVectorR, DELTAT, { scaleX:1 , scaleY:1, x:view.adornosVector.adornosVectorR.x + view.adornosVector.adornosVectorR.width, y:view.adornosVector.adornosVectorR.y - view.adornosVector.adornosVectorR.height, delay:DELTAT * 2, ease:Quint.easeIn } );
			TweenMax.delayedCall(DELTAT*3, startAnimationsParticle);
			
		
		}
		
		public function startAnimationsParticle():void 
		{
			//trace("nooo");
			var myEmitt:ExplodeView = new ExplodeView();
			view.emiterL.addChild(myEmitt);
			myEmitt.onCreateEmition( -Math.PI * 1.5, Math.PI, 400, 0);
			var myEmitt2:ExplodeView = new ExplodeView();
			view.emiterR.addChild(myEmitt2);
			myEmitt2.onCreateEmition(0, Math.PI/2,0,0);
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
			onSendBack();
			
		
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