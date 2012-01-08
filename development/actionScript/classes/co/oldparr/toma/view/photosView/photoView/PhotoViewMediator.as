package co.oldparr.toma.view.photosView.photoView 
{
	import co.oldparr.toma.event.ViewsEvent;
	import co.oldparr.toma.view.imageView.ImageView;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class PhotoViewMediator extends Mediator 
	{
		[Inject]
		public var view:PhotoView;
		public function PhotoViewMediator() 
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
			addViewListener(ViewsEvent.ON_IMAGE_FINISH_LOAD,onFinishItemLoad);
			//eventMap.mapListener(eventDispatcher, ViewsEvent.ON_IMAGE_FINISH_LOAD, onFinishItemLoad);
			var imageView:ImageView = new ImageView();
			view.photoContainer.addChild(imageView);
			imageView.imageURL = view.urlImageItem;
		
			imageView.onLoad();
			
		}
		
		private function onFinishItemLoad(e:ViewsEvent):void 
		{
			eventMap.unmapListener(eventDispatcher, ViewsEvent.ON_IMAGE_FINISH_LOAD, onFinishItemLoad);
			e.stopImmediatePropagation();
			e.stopPropagation();
			view.photoContainer.x = (view.back.width - view.photoContainer.width) / 2;
			view.photoContainer.y = (view.back.height - view.photoContainer.height) / 2;
			trace(view.urlImageItem,"entraaaa");
			//dispatch(new ViewsEvent(ViewsEvent.ON_FRIEND_USER_LOAD));
		}

		
	}

}