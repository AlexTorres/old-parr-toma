package co.oldparr.toma.view.userWallView.WallStatus 
{
	import flash.events.Event;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class WallStatusViewMediator extends Mediator 
	{
		[Inject]
		public var view:WallStatusView;
		public function WallStatusViewMediator() 
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