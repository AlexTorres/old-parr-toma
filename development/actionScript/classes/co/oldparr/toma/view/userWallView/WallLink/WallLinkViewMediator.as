package co.oldparr.toma.view.userWallView.WallLink 
{
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class WallLinkViewMediator extends Mediator 
	{
		[Inject]
		public var view:WallLinkView;
		public function WallLinkViewMediator() 
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
		}
	}

}