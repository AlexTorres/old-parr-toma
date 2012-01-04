package co.oldparr.toma.view.userWallView.WallStatus 
{
	import co.oldparr.view.userWall.WallPostNormal;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class WallStatusView extends WallPostNormal 
	{
		
		private var _urlImagePost:String;
		private var _urlIconPost:String;
		
		public function WallStatusView(urlImagePost:String=null,urlIconPost:String=null) 
		{
			super();
			this.urlImagePost = urlImagePost;
			this.urlIconPost = urlIconPost;
			this.text_txt.autoSize = TextFieldAutoSize.LEFT;
			this.likes.date_txt.autoSize = TextFieldAutoSize.LEFT;
		
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
		
	}

}