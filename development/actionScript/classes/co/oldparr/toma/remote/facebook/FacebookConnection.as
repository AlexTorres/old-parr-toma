package co.oldparr.toma.remote.facebook
{
	import co.oldparr.toma.event.RemoteEvent;
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
		public static const FRIEND_PICTURE:String = "https://graph.facebook.com/{0}/picture?access_token=";
		public static const USER_PHOTO:String = "https://graph.facebook.com/me/picture?type=large&access_token=";
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
		
		
		public function FacebookConnection()
		{
			MonsterDebugger.initialize(this);
			super();
		}
		
		public function onLoadFacebookInfo():void
		{
		
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
				MonsterDebugger.trace(this,_friendsArray);
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
				_photosArray = result as Array;
				Facebook.api(USER_FEED, onUserFeed, LIMIT_ITEMS, "GET");
			}
			else
			{
				
			}
			
		}
		
		private function onUserFeed(result:Object, fail:Object):void 
		{
			if (result)
			{
				
				_feedArray =result as Array;
				
				dispatch(new RemoteEvent(RemoteEvent.ON__FACEBOOK_READY));
			
				
			}
			else
			{
				
			}
			
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
	
	}

}