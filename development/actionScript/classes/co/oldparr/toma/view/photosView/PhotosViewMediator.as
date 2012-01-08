package co.oldparr.toma.view.photosView
{
	import co.oldparr.toma.remote.facebook.IFacebookConnection;
	import co.oldparr.toma.view.photosView.photoView.PhotoView;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class PhotosViewMediator extends Mediator
	{
		
		[Inject]
		public var view:PhotosView;
		[Inject]
		public var fbServices:IFacebookConnection;
		
		public function PhotosViewMediator()
		{
			
			super();
		}
		
		override public function onRegister():void
		{
			addViewListener(Event.ADDED_TO_STAGE, init, Event);
		}
		
		private function init(e:Event):void
		{
			removeViewListener(Event.ADDED_TO_STAGE, init);
			populatePhotos();
		}
		
		private function populatePhotos():void
		{
			
			
			if (fbServices.photosArray.length <5)
			{
				for (var i:int = 0; i < fbServices.photosArray.length; i++)
				{
					var photoView:PhotoView = new PhotoView(fbServices.photosArray[i].picture);
				
					photoView.x = (photoView.width + 5) * i;
					this.view.addChild(photoView);
				}
			}
			else
			{
				for (var j:int = 0; j <5; j++)
				{
					var photoView2:PhotoView = new PhotoView(fbServices.photosArray[j].picture);
					
					photoView2.x = (photoView2.width + 1) * j;
					this.view.addChild(photoView2);
				}
			}
		}
	
	}

}