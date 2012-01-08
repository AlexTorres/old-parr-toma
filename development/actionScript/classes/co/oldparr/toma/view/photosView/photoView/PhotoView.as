package co.oldparr.toma.view.photosView.photoView 
{
	import co.oldparr.view.photosView.Photo;
	import org.casalib.display.CasaSprite;
	import co.oldparr.toma.event.ViewsEvent
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class PhotoView extends Photo
	{
		private var _urlImageItem:String;
		public function PhotoView(urlImageItem:String) 
		{
			
			super();
			this.urlImageItem = urlImageItem;
			
		}
		
		public function get urlImageItem():String 
		{
			return _urlImageItem;
		}
		
		public function set urlImageItem(value:String):void 
		{
			_urlImageItem = value;
		}
		
	}

}