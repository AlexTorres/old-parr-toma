package co.oldparr.toma.view.preloader
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
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
		
		private function onProgress(e:LoadEvent):void
		{
			trace(e.progress);
			mainLoad.loaderText.text = Math.round(100 * Number(e.progress)).toString() + "%" ;
			TweenMax.to(mainLoad.preloader.frontLoader, 0.5, { x: -490 + (490 * Number(e.progress) )} );
			
	
			
		}
		
		private function onComplete(e:LoadEvent):void
		{
			TweenMax.to(mainLoad, 0.5, { autoAlpha: 0 } );
			 this.addChild(loader.content);
			ExternalInterface.call("onChageBGColor");
		}
	}

}
