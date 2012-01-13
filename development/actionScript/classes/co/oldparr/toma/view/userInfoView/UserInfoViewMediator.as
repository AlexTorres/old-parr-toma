package co.oldparr.toma.view.userInfoView 
{
	import co.oldparr.toma.event.ViewsEvent;
	import co.oldparr.toma.remote.facebook.FacebookConnection;
	import co.oldparr.toma.remote.facebook.IFacebookConnection;
	import co.oldparr.toma.view.imageView.ImageView;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import org.robotlegs.mvcs.Mediator;
	
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class UserInfoViewMediator extends Mediator 
	{
		[Inject]
		public var view:UserInfoView;
		[Inject]
		public var fbservice:IFacebookConnection;
		
		private var monthArray:Array = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
		private var userPhoto:ImageView;
		
		public function UserInfoViewMediator() 
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
			view.userName.autoSize = view.bornCityView.bornCity.autoSize = view.currentCityView.currentCity.autoSize = view.BornDate.bornDateText.autoSize = TextFieldAutoSize.LEFT;
			
			view.userName.text = (fbservice.userObject.name != null) ? fbservice.userObject.name: ""; 
			if (fbservice.userObject.hometown != null)
			{
				view.bornCityView.bornCity.text =fbservice.userObject.hometown.name
			}
			else
			{
				view.bornCityView.bornCity.text = "Colombia";
			}
			if (fbservice.userObject.location!= null)
			{
				view.currentCityView.currentCity.text = fbservice.userObject.location.name;
			}
			else
			{
				view.currentCityView.currentCity.text = "Colombia";
			}
			//view.bornCityView.bornCity.text = (fbservice.userObject.hometown.name !=null) ? fbservice.userObject.hometown.name: ""; 
			//view.currentCityView.currentCity.text = (fbservice.userObject.location.name != null) ? fbservice.userObject.location.name: ""; 
			var stringBorn:String = "";
			if (fbservice.userObject.birthday != null)
			{
				var arrayFecha:Array = String(fbservice.userObject.birthday).split("/");
				stringBorn = arrayFecha[1] + " de " + monthArray[int(arrayFecha[0])-1] +" de " +arrayFecha[2] ;
			}
			
			view.BornDate.bornDateText.text = stringBorn;
			
			onReorderItems();
			onLoadUserPhoto();
			
			
		}
		
		private function onLoadUserPhoto():void 
		{
			
			userPhoto = new ImageView();
			view.addChild(userPhoto);
			
			userPhoto.imageURL = FacebookConnection.USER_PHOTO + fbservice.accessToken;
			userPhoto.onLoad();
			eventMap.mapListener(eventDispatcher, ViewsEvent.ON_IMAGE_FINISH_LOAD, onFinishUserPhoto);
		}
		
		private function onFinishUserPhoto(e:ViewsEvent):void 
		{
			eventMap.unmapListener(eventDispatcher, ViewsEvent.ON_IMAGE_FINISH_LOAD, onFinishUserPhoto);
			userPhoto.x = view.spacer.x - (userPhoto.width);
			
		}
		
		private function onReorderItems():void 
		{
			view.bornCityView.x = view.currentCityView.x + view.currentCityView.width + 5;
			view.BornDate.x = view.bornCityView.x + view.bornCityView.width + 5;
			view.info01.x=view.BornDate.x + view.BornDate.width + 5;
	
		}
	}

}