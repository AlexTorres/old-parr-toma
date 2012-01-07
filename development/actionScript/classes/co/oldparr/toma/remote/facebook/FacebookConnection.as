package co.oldparr.toma.remote.facebook
{
	import co.oldparr.toma.event.RemoteEvent;
	import org.robotlegs.mvcs.Actor;
	import com.demonsters.debugger.MonsterDebugger;
	import org.casalib.util.StageReference;
	import com.adobe.serialization.json.JSON;
	import com.facebook.graph.Facebook;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class FacebookConnection extends Actor implements IFacebookConnection
	{
		public static const FRIEND_PICTURE:String = "https://graph.facebook.com/{0}/picture?access_token=";
		public static const USER_PHOTO:String = "https://graph.facebook.com/me/picture?type=large&access_token=";
		public static const USER_PHOTO_SMALL:String = "https://graph.facebook.com/me/picture?access_token=";
		protected static const LIMIT_ITEMS:Object = {limit: 10};
		protected static const USER_INFO:String = "/me";
		protected static const USER_FRIENDS:String = "/me/friends";
		protected static const USER_FEED:String = "/me/posts";
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
				var fbquery:String = 'SELECT post_id, actor_id, target_id, message,source_id FROM stream WHERE source_id = me()  AND message!="" LIMIT 20';
				_photosArray = result as Array;
				Facebook.fqlQuery(fbquery,onUserFeed);
			}
			else
			{
				
			}
		
		}
		
		private function onUserFeed(result:Object, fail:Object):void
		{
			trace("noooo");
			MonsterDebugger.trace(this,result);
			if (result)
			{
				
				//_feedArray //= result as Array;
				onUserFeedAdd(result as Array);
				
				
				
				
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
				MonsterDebugger.trace(this,_feedArray);
				dispatch(new RemoteEvent(RemoteEvent.ON__FACEBOOK_READY));
			}
			
		}
	
	}

}