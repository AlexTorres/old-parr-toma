package co.oldparr.toma.controller 
{
	
	import co.oldparr.toma.view.mainWindow.MainWindowView;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class AddMainWindowCommand extends Command 
	{
		
		override public function execute():void
		{
			var mainWindow:MainWindowView = new MainWindowView();
			contextView.addChild(mainWindow); 
		}
	}

}