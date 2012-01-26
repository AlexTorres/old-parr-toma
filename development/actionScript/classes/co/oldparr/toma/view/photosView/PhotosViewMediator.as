package co.oldparr.toma.view.photosView
{
	import co.oldparr.toma.event.RemoteEvent;
	import co.oldparr.toma.event.ViewsEvent;
	import co.oldparr.toma.remote.facebook.IFacebookConnection;
	import co.oldparr.toma.view.photosView.photoView.PhotoView;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	import com.demonsters.debugger.MonsterDebugger;
	
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
		private var onConterPhoto:PhotoView;
		private var onCompeteTira:Number=0;
		
		public function PhotosViewMediator()
		{
			
			super();
		}
		
		override public function onRegister():void
		{
			addViewListener(Event.ADDED_TO_STAGE, init, Event);
			MonsterDebugger.initialize(this);
		}
		
		private function init(e:Event):void
		{
			removeViewListener(Event.ADDED_TO_STAGE, init);
			
			populatePhotos();
			//eventMap.mapListener(this.eventDispatcher, ViewsEvent.ON_ANIMATE_USER_PHOTOS, onAnimatePhotos);
			eventMap.mapListener(eventDispatcher,RemoteEvent.ON_ANIMATE_PHOTOS, onAnimatePhotos);
		}
		
		private function onAnimatePhotos(e:ViewsEvent):void 
		{
			onMoveItem();
			eventMap.unmapListener(eventDispatcher, RemoteEvent.ON_ANIMATE_PHOTOS, onAnimatePhotos);
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
					onCompeteTira++;
					MonsterDebugger.trace(this,onCompeteTira);
					if (onCompeteTira == 5)
					{
						onConterPhoto = photoView;
						trace("areUFukingKiddingme?");
						MonsterDebugger.trace(this,onConterPhoto);
					}
				}
			}
			else
			{
				for (var j:int = 0; j <5; j++)
				{
					var photoView2:PhotoView = new PhotoView(fbServices.photosArray[j].picture);
					
					photoView2.x = (photoView2.width + 1) * j;
					this.view.addChild(photoView2);
					onCompeteTira++;
					MonsterDebugger.trace(this,onCompeteTira);
					if (onCompeteTira == 5)
					{
						onConterPhoto = photoView2;
						trace("areUFukingKiddingme?");
						MonsterDebugger.trace(this,onConterPhoto);
					
					}

				}
			}
		}
		private function onMoveItem():void
		{
			MonsterDebugger.trace(this,onConterPhoto);
			if (onConterPhoto != null)
			{
				TweenMax.to(onConterPhoto, 0.8, { alpha:0,delay:2} );
				
			}
			TweenMax.to(view,0.8,{x:view.x+102,delay:2});
		}
	
	}

}