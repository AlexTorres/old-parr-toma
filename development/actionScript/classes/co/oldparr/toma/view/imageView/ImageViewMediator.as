package co.oldparr.toma.view.imageView 
{
	import co.oldparr.toma.event.ViewsEvent;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class ImageViewMediator extends Mediator 
	{
		[Inject]
		public var view:ImageView;
		public function ImageViewMediator() 
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
			addViewListener(ViewsEvent.ON_IMAGE_FINISH_LOAD, onImageLoad, ViewsEvent);
		}
		
		private function onImageLoad(e:ViewsEvent):void 
		{
			removeViewListener(ViewsEvent.ON_IMAGE_FINISH_LOAD, onImageLoad);
			
			e.stopPropagation();
			dispatch(e);
			
		}
		
	}

}