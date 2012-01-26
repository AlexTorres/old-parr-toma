package 
{
	
	import co.oldparr.toma.event.RemoteEvent;
	import co.oldparr.toma.TomaContext;
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import org.casalib.util.AlignUtil;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class Main extends CasaSprite 
	{
		protected var context:TomaContext;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			context = new TomaContext(this);
			
			
			// entry point
			
		}
		public function onReLoad():void
		{
			context.contextView.dispatchEvent(new RemoteEvent(RemoteEvent.ON_RELOAD,true,true));
			
		}
		public function onShowFriends():void
		{
			trace("pasaaaa");
			context.contextView.dispatchEvent(new RemoteEvent(RemoteEvent.ON_UI_FRIENDS,true,true));
		}
		
	}
	
}