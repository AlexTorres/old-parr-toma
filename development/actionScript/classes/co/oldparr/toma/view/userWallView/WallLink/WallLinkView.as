package co.oldparr.toma.view.userWallView.WallLink 
{
	import co.oldparr.view.userWall.WallPostMedia;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class WallLinkView extends WallPostMedia 
	{
		private var _urlImagePost:String;
		private var _urlIconPost:String;
		private var _urlLinkPost:String
		public function WallLinkView(urlImagePost:String=null,urlIconPost:String=null,urlLinkPost:String=null) 
		{
			super();
			this.urlImagePost = urlImagePost;
			this.urlIconPost = urlIconPost;
			this.urlLinkPost = urlLinkPost;
			
		}
		
		public function get urlImagePost():String 
		{
			return _urlImagePost;
		}
		
		public function set urlImagePost(value:String):void 
		{
			_urlImagePost = value;
		}
		
		public function get urlIconPost():String 
		{
			return _urlIconPost;
		}
		
		public function set urlIconPost(value:String):void 
		{
			_urlIconPost = value;
		}
		
		public function get urlLinkPost():String 
		{
			return _urlLinkPost;
		}
		
		public function set urlLinkPost(value:String):void 
		{
			_urlLinkPost = value;
		}
		
	}

}