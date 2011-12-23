package 
{
	
	import co.oldparr.toma.TomaContext;
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	
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
			context = new TomaContext(this);
			// entry point
			
		}
		
	}
	
}