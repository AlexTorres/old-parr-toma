package co.oldparr.toma.view.imageView 
{
	import co.oldparr.toma.event.ViewsEvent;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import org.casalib.display.CasaSprite;
	import org.casalib.events.LoadEvent;
	import org.casalib.load.ImageLoad;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.events.SecurityErrorEvent;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	
	public class ImageView extends CasaSprite  implements IImageView
	{
		[Inject]
		public var view:ImageView;
		protected var imageLoad:Loader;
		private var _imageURL:String;
		public function ImageView() 
		{
			Security.loadPolicyFile("https://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("https://profile.ak.fbcdn.net/crossdomain.xml");
			Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			Security.loadPolicyFile("https://s-external.ak.fbcdn.net/crossdomain.xml?__cb=55448555654");
			Security.loadPolicyFile("https://s-static.ak.facebook.com/crossdomain.xml?__cb=55448555654");
			
			Security.loadPolicyFile("https://www.facebook.com/crossdomain.xml?__cb=55448555654");
			Security.allowDomain("*");

			super();
		}
		
		public function onLoad():void
		{
			var lc:LoaderContext = new LoaderContext();
			lc.checkPolicyFile = true;
			imageLoad = new Loader();
			imageLoad.load(new URLRequest(this.imageURL), lc);
			this.imageLoad.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete, false, 0, true);
		
			
          
		}
		
		private function onSecurity(e:SecurityErrorEvent):void 
		{
			trace("::errorHandler");
		}
		
		private function onComplete(e:Event):void 
		{
			this.imageLoad.content.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurity);
			var content:Bitmap = this.imageLoad.content as Bitmap;
			content.smoothing = true;
			this.addChild(content);
			this.dispatchEvent(new ViewsEvent(ViewsEvent.ON_IMAGE_FINISH_LOAD,true,true,this));
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