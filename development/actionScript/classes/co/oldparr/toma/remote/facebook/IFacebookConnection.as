package co.oldparr.toma.remote.facebook 
{
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public interface IFacebookConnection 
	{
		function onLoadFacebookInfo():void;
		function get appID():String; 
		function set appID(value:String):void; 
		function get userObject():Object 
		function get friendsArray():Array 
		function get photosArray():Array 
		function get feedArray():Array 
		function get accessToken():String 
	}
	
}