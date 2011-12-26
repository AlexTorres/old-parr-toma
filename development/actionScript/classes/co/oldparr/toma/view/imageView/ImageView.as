package co.oldparr.toma.view.imageView 
{
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	import org.casalib.events.LoadEvent;
	import org.casalib.load.ImageLoad;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class ImageView extends CasaSprite  implements IImageView
	{
		protected var imageLoad:ImageLoad;
		private var _imageURL:String;
		public function ImageView() 
		{
			super();
		}
		
		public function onLoad():void
		{
			this.imageLoad = new ImageLoad("test.jpg");
            this.imageLoad.addEventListener(LoadEvent.COMPLETE, this.onComplete,false,0,true);
            this.imageLoad.start()
		}
		
		private function onComplete(e:LoadEvent):void 
		{
			 this.addChild(this.imageLoad.contentAsBitmap);
			
		}
		public function get imageURL():String 
		{
			return _imageURL;
		}
		
		public function set imageURL(value:String):void 
		{
			_imageURL = value;
		}
	
	}

}