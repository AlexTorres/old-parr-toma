package co.oldparr.toma.view.userWallView.WallStatus 
{
	import co.oldparr.toma.event.RemoteEvent;
	import com.greensock.easing.Bounce;
	import com.greensock.TweenMax;
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
			view.sombrero.scaleX = 0;
			view.sombrero.scaleY = 0;
			//eventMap.mapListener(eventDispatcher, RemoteEvent.ON_SHOW_HATS, onShowHats);
		}
		
		private function onShowHats(e:RemoteEvent):void 
		{
			 TweenMax.to(view.sombrero,0.8,{scaleX:1,scaleY:1,ease:Bounce.easeOut,delay:Math.random()*0.8})
		}
		
	}

}