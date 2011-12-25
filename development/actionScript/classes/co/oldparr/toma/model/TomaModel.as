package co.oldparr.toma.model 
{
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class TomaModel extends Actor 
	{
		private var _urlBack:String;
		private var _urlFront:String;
		private var _audioPath:String;
		private var _videoPath:String;
		private var _imagePath:String;
		private var _xmlPath:String;
		private var _swfPath:String;
		
		
		public function TomaModel() 
		{
			super();
		}	
		
		public function get urlBack():String 
		{
			return _urlBack;
		}
		
		public function set urlBack(value:String):void 
		{
			_urlBack = value;
		}
		
		public function get urlFront():String 
		{
			return _urlFront;
		}
		
		public function set urlFront(value:String):void 
		{
			_urlFront = value;
		}
		
		public function get audioPath():String 
		{
			return _audioPath;
		}
		
		public function set audioPath(value:String):void 
		{
			_audioPath = value;
		}
		
		public function get videoPath():String 
		{
			return _videoPath;
		}
		
		public function set videoPath(value:String):void 
		{
			_videoPath = value;
		}
		
		public function get imagePath():String 
		{
			return _imagePath;
		}
		
		public function set imagePath(value:String):void 
		{
			_imagePath = value;
		}
		
		public function get swfPath():String 
		{
			return _swfPath;
		}
		
		public function set swfPath(value:String):void 
		{
			_swfPath = value;
		}
		
		
	}

}