package co.oldparr.toma.remote.facebook
{
	import co.oldparr.toma.event.RemoteEvent;
	import co.oldparr.toma.model.TomaModel;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import org.robotlegs.mvcs.Actor;

	import org.casalib.util.StageReference;
	import com.adobe.serialization.json.JSON;
	import com.facebook.graph.Facebook;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class FacebookConnection extends Actor implements IFacebookConnection
	{
		[Inject]
		public var model:TomaModel;
		
		public static const FRIEND_PICTURE:String = "https://graph.facebook.com/{0}/picture?access_token=";
		public static const USER_PHOTO:String = "https://graph.facebook.com/me/picture?type=large&access_token=";
		public static const USER_PHOTO_SMALL:String = "https://graph.facebook.com/me/picture?access_token=";
		protected static const LIMIT_ITEMS:Object = {limit: 10};
		protected static const USER_INFO:String = "/me";
		protected static const USER_FRIENDS:String = "/me/friends";
		protected static const USER_FEED:String = "/me/feed";
		protected static const USER_PHOTOS:String = "/me/photos";
		private var _appID:String;
		private var _accessToken:String;
		private var _userObject:Object;
		private var _friendsArray:Array;
		private var _photosArray:Array;
		private var _feedArray:Array;
		private var _lengthItems:Number;
		private var tempArray:Array;
		
		public function FacebookConnection()
		{
			
			super();
		}
		
		public function onLoadFacebookInfo():void
		{
			MonsterDebugger.initialize(this);
			Facebook.init(this.appID, onInit);
		
		}
		
		protected function onInit(result:Object, fail:Object):void
		{
			if (result)
			{
				
				_accessToken = result.accessToken;
				Facebook.api(USER_INFO, onUserData, null, "GET");
				
			}
			else
			{
				
			}
		}
		
		protected function onUserData(result:Object, fail:Object):void
		{
			if (result)
			{
				
				_userObject = result;
				Facebook.api(USER_FRIENDS, onUserFriends, LIMIT_ITEMS, "GET");
				
			}
			else
			{
				
			}
		}
		
		protected function onUserFriends(result:Object, fail:Object):void
		{
			
			if (result)
			{
				_friendsArray = result as Array;
				Facebook.api(USER_PHOTOS, onUserPhotos, LIMIT_ITEMS, "GET");
			}
			else
			{
				
			}
		
		}
		
		protected function onUserPhotos(result:Object, fail:Object):void
		{
			
			if (result)
			{
				//var fbquery:String = 'SELECT post_id, actor_id, target_id, message,source_id FROM stream WHERE source_id = me()  AND message!="" LIMIT 20';
				_photosArray = result as Array;
				Facebook.api(USER_FEED,onUserFeed,{fields:"message,icon,created_time,caption,description,picture,type,description,name,from",limit: 20},"GET");
			}
			else
			{
				
			}
		
		}
		
		private function onUserFeed(result:Object, fail:Object):void
		{
			trace("noooo");
		
			if (result)
			{
				
				_feedArray = result as Array;
				MonsterDebugger.trace(this,_feedArray);
				dispatch(new RemoteEvent(RemoteEvent.ON__FACEBOOK_READY));
				//onUserFeedAdd(result as Array);
				
				
				
				
			}
			else
			{
				
			}
		
		}
		private function onUserFeedAdd(arrayFB:Array):void
		{
			tempArray=arrayFB;
			_feedArray = new Array(arrayFB.length);
			this.lengthItems = arrayFB.length;
			
			for (var j:uint=0; j < arrayFB.length; j++ )
			{
				Facebook.api("/"+arrayFB[j].post_id.toString(), onUserFeedItem,{fields:"message,icon,created_time,caption,description,picture,type,description,name,from"}, "GET");
			}
		}
		private function onUserFeedItem(result:Object, fail:Object):void
		{
			
			
			if (result)
			{
				
				for (var j:uint = 0; j < tempArray.length; j++ )
				{
					if (tempArray[j].post_id.toString() == result.id)
					{
						feedArray[j] = result;
					}
				}
				this.lengthItems--;
			}
			else
			{
				
			}
		
		}
		
		public function onFriendsUI ():void
		{
			var params:Object = { message: "Some pilots get picked and become television programs. Some don't, become nothing", title:"Are you ready for the truth?" };
			Facebook.ui("apprequests", params, onUIFriendsComplete);
		}
		protected function onUIFriendsComplete(result:Object):void
		{
			//trace("\n\nUICallback: " + JSON.encode(result));
		
			//TODO:  result.to.lenght;
		
			
			if (result != null)
			{
				if (result.to != null)
				{
					
					if (result.to.length > 0)
					{
							var url:String = model.urlBack + "/referrers/add";
							var request:URLRequest = new URLRequest(url);
							var user:Object = new Object();
							
							var variables:URLVariables = new URLVariables();
							variables["data[Referrer][facebookid]"] = this.userObject.id;
							variables["data[Referrer][total_referrers]"] = result.to.length;
							request.data = variables;
							request.method = URLRequestMethod.POST;
							var loader:URLLoader = new URLLoader();
							loader.load(request);
							loader.dataFormat = URLLoaderDataFormat.BINARY;
						
						
					}
				}
			}
			
		
			
		}
		public function onUploadFunction(bitmapData:BitmapData):void
		{
			var bitmap:Bitmap=new Bitmap(bitmapData);
			var params:Object = {image:bitmap, message:'Así se vive la alegría desde una perspectiva diferente. El Viejo Parr y yo nos gozamos todo el sabor delCarnaval.', fileName:'El Carnaval con el Viejo Parr.'};
			Facebook.api(USER_PHOTOS, onSaveToPhotoAlbumComplete, params);

		}
		
		private function onSaveToPhotoAlbumComplete(result:Object, fail:Object):void 
		{
			
		}
		public function onPushPost():void
		{
			var params:Object = { message :this.userObject.name + " está viviendo el carnaval de una forma diferente.", name:"El Carnaval con el Viejo Parr.", caption:"Así se vive la alegría desde una perspectiva diferente. El Viejo Parr y yo nos gozamos todo el sabor del Carnaval.", link:model.urlFront, description:"Old parr", picture:model.urlFront + model.imagePath + "icono_app.jpg" };
			Facebook.api(USER_FEED, onpost, params, "POST");
			MonsterDebugger.trace(this,model.urlFront + model.imagePath + "icono_app.jpg");
			
			
			
		}
		
		private function onpost(result:Object, fail:Object):void 
		{
			MonsterDebugger.trace(this,result);
		}
		
		public function get appID():String
		{
			return _appID;
		}
		
		public function set appID(value:String):void
		{
			_appID = value;
		}
		
		public function get userObject():Object
		{
			return _userObject;
		}
		
		public function get friendsArray():Array
		{
			return _friendsArray;
		}
		
		public function get photosArray():Array
		{
			return _photosArray;
		}
		
		public function get feedArray():Array
		{
			return _feedArray;
		}
		
		public function get accessToken():String
		{
			return _accessToken;
		}
		
		public function get lengthItems():Number 
		{
			
			return _lengthItems;
		}
		
		public function set lengthItems(value:Number):void 
		{
			_lengthItems = value;
			if (value == 0)
			{
				
				
			}
			
		}
	
	}

}