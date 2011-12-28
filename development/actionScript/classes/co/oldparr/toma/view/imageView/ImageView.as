package co.oldparr.toma.view.imageView 
{
	import co.oldparr.toma.event.ViewsEvent;
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	import org.casalib.events.LoadEvent;
	import org.casalib.load.ImageLoad;
	import flash.system.LoaderContext;
	import flash.system.Security;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	
	public class ImageView extends CasaSprite  implements IImageView
	{
		[Inject]
		public var view:ImageView;
		protected var imageLoad:ImageLoad;
		private var _imageURL:String;
		public function ImageView() 
		{
			Security.loadPolicyFile("http://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			super();
		}
		
		public function onLoad():void
		{
			var lc:LoaderContext = new LoaderContext();
			lc.checkPolicyFile = true;
			this.imageLoad = new ImageLoad(this.imageURL,lc);
            this.imageLoad.addEventListener(LoadEvent.COMPLETE, this.onComplete,false,0,true);
            this.imageLoad.start()
		}
		
		private function onComplete(e:LoadEvent):void 
		{
			this.addChild(this.imageLoad.contentAsBitmap);
			this.dispatchEvent(new ViewsEvent(ViewsEvent.ON_IMAGE_FINISH_LOAD,false,false,this));
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