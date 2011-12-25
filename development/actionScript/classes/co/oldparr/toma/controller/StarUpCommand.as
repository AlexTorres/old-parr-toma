package co.oldparr.toma.controller 
{
	import co.oldparr.toma.remote.xmlReader.IXMLReader;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class StarUpCommand extends Command 
	{
		
		[Inject]
		public var service:IXMLReader;

		override public function execute():void
		{
			
			service.onLoad(contextView);
		}
		
	}

}