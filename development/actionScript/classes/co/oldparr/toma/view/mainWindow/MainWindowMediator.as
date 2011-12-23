package co.oldparr.toma.view.mainWindow 
{
	import co.oldparr.toma.view.interfaces.IStandardWindow;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class MainWindowMediator extends Mediator
	{
		[Inject]
		public var view:MainWindow
		
		public function MainWindowMediator() 
		{
			super();
			
		}
		
	}

}