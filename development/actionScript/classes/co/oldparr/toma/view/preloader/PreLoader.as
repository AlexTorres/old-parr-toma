package co.oldparr.toma.view.preloader
{
	
	import co.oldparr.toma.event.ViewsEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.casalib.load.SwfLoad;
	import org.casalib.events.LoadEvent;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.util.LocationUtil;
	import com.greensock.TweenMax;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.external.ExternalInterface;
	
	
	public class PreLoader extends CasaSprite
	{
		private var loader:SwfLoad;
		private var onShareItem:ShareView;
		
		public function PreLoader()
		{
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			this.stage.addEventListener(Event.RESIZE, onResize, false, 0, true);
			stage.dispatchEvent(new Event(Event.RESIZE));
			if (LocationUtil.isWeb(this))
			{
				loader = new SwfLoad("assets/swf/OldParrToma.swf?rnd"+new Date().getTime);
			}
			else
			{
				loader = new SwfLoad("OldParrToma.swf");
			}
			loader.addEventListener(LoadEvent.COMPLETE, onComplete, false, 0, true);
			loader.addEventListener(LoadEvent.PROGRESS, onProgress, false, 0, true);
			loader.start();
		}
		
		private function onResize(e:Event):void 
		{
			mainLoad.x = ((this.stage.stageWidth) / 2);
		}
		
		private function onProgress(e:LoadEvent):void
		{
			
			mainLoad.loaderText.text = Math.round(50 * Number(e.progress)).toString() + "%" ;
			TweenMax.to(mainLoad.preloader.frontLoader, 0.5, { x: -490 + (490 * Number(e.progress)*.5 )} );
			
			
		
			
		}
		
		private function onComplete(e:LoadEvent):void
		{
			loader.removeEventListener(LoadEvent.PROGRESS, onProgress);
			loader.removeEventListener(LoadEvent.COMPLETE, onComplete);
			this.addChild(loader.content);
			loader.content.visible = false;
			loader.content.alpha = 0;
			this.addEventListener(ViewsEvent.ON_LOAD_COMPLETE_ALL, onCompleteFBInfo, false, 0, true);
			this.addEventListener(ViewsEvent.ON_ANIMATION_FINSHED, onFinishAnimations, false, 0, true); 
			this.addEventListener(ViewsEvent.ON_TRACK_INTERMEDIATE, onTrackIntermediate, false, 0, true);
			this.addEventListener(LoadEvent.PROGRESS, onLoadVideo, false, 0, true);
		}
		
		private function onLoadVideo(e:LoadEvent):void 
		{
			mainLoad.loaderText.text = Math.round(50 +100*( Number(e.progress)) )+ "%" ;
			TweenMax.to(mainLoad.preloader.frontLoader, 0.5, { x: -490 + (490 * (Number(e.progress) ))} );	
			trace("miauuuuu");
		}
		private function onTrackVolver(e:ViewsEvent):void
		{
			tracker.trackPageview("/OLD_PARR_toma_fb_carnavalBarranqilla_volverAver"); 
		}
		private function onTrackIntermediate(e:ViewsEvent):void 
		{
			tracker.trackPageview("/OLD_PARR_toma_fb_carnavalBarranqilla_duracionIntermedio"); 
		}
		
		private function onResizeFinal(e:Event):void 
		{
			onShareItem.x = ((this.stage.stageWidth) / 2);
		}
		
		private function onFinishAnimations(e:ViewsEvent):void 
		{
			tracker.trackPageview("/OLD_PARR_toma_fb_carnavalBarranqilla_final"); 
			TweenMax.to(loader.content, 0.5, { autoAlpha: 0 } );
			onShareItem = new ShareView();
			onShareItem.visible = false;
			onShareItem.alpha = 0;
			this.addChild(onShareItem);
			TweenMax.to(onShareItem, 0.5, { autoAlpha: 1 } );
			this.stage.addEventListener(Event.RESIZE, onResizeFinal, false, 0, true); 
			onShareItem.btnShare.addEventListener(MouseEvent.CLICK, onShare, false, 0, true);
			onShareItem.restart.addEventListener(MouseEvent.CLICK, onBack, false, 0, true);
			stage.dispatchEvent(new Event(Event.RESIZE));
			ExternalInterface.call("onChageBGColorOrig");
		}
		
		private function onBack(e:MouseEvent):void 
		{
			var toma:*;
			toma = loader.content ;
			toma.onReLoad();
			tracker.trackPageview("/OLD_PARR_toma_fb_carnavalBarranqilla_volverAver");
			
		}
		
		private function onShare(e:MouseEvent):void 
		{
			//loader.content.onShowFriends();
			var toma:*;
			toma = loader.content ;
			toma.onShowFriends();
			
			tracker.trackPageview("/OLD_PARR_toma_fb_carnavalBarranqilla_compartir");
		}
		
		private function onCompleteFBInfo(e:ViewsEvent):void 
		{
			mainLoad.loaderText.text = "100%" ;
			TweenMax.to(mainLoad.preloader.frontLoader, 0.5, { x: -490 + (490  )} );
			TweenMax.to(mainLoad, 0.5, { autoAlpha: 0 } );
			TweenMax.to(loader.content, 0.5, { autoAlpha: 1 } );
			this.stage.removeEventListener(Event.RESIZE, onResize);
			ExternalInterface.call("onChageBGColor");
			tracker.trackPageview("/OLD_PARR_toma_fb_carnavalBarranqilla_inicio"); 
			
		}
	}

}
