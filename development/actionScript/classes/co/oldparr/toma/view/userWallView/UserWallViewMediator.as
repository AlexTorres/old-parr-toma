package co.oldparr.toma.view.userWallView
{
	import co.oldparr.toma.event.RemoteEvent;
	import co.oldparr.toma.remote.facebook.FacebookConnection;
	import co.oldparr.toma.remote.facebook.IFacebookConnection;
	import co.oldparr.toma.view.imageView.ImageView;
	import co.oldparr.toma.view.userWallView.WallStatus.WallStatusView;
	import com.greensock.easing.Quint;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import org.casalib.util.DateUtil;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author John Alexander Torres
	 */
	public class UserWallViewMediator extends Mediator
	{
		[Inject]
		public var view:UserWallView;
		[Inject]
		public var fbservice:IFacebookConnection;
		private var monthArray:Array = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
		
		public function UserWallViewMediator()
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
			populateWall();
			eventMap.mapListener(eventDispatcher, RemoteEvent.ON_SHOW_HATS, onAnimateItem);
		}
		
		private function onAnimateItem(e:RemoteEvent):void 
		{
			TweenMax.to(view, 0.8, { y:view.y + 200 , ease:Quint.easeOut } );
		}
		
		private function populateWall():void
		{
			for (var j:uint = 0; j < fbservice.feedArray.length; j++)
			{
				trace(fbservice.feedArray[j].type);
				var userPhoto:ImageView = new ImageView();
				//var imageItem:ImageView = new ImageView();
				var stringMoarr:String="";
				
				if (fbservice.feedArray[j].message !=null)
				{
					stringMoarr = fbservice.feedArray[j].message;
				}
				else
				{
					if (fbservice.feedArray[j].description != null)
					{
						stringMoarr = fbservice.feedArray[j].description;
					}
				}
				
				if (stringMoarr != "")
				{
					var wallStatusView:WallStatusView = new WallStatusView();
					
					if (fbservice.feedArray[j].icon != null)
					{
						
						//imageItem.imageURL = fbservice.feedArray[j].icon.toString()+"?access_token="+fbservice.accessToken;
						//imageItem.onLoad();
						//wallStatusView.likes.photoVideoContainer.addChild(imageItem);
					}
					if (j == 0)
					{
						wallStatusView.spacer_mc.alpha = 0;
					}
					else
					{
						wallStatusView.spacer_mc.alpha = 1;
					}
					userPhoto.imageURL = FacebookConnection.FRIEND_PICTURE.replace("{0}", fbservice.feedArray[j].from.id) + fbservice.accessToken;
					wallStatusView.photoContainer.addChild(userPhoto);
					var dateItem:Date = DateUtil.iso8601ToDate(fbservice.feedArray[j].created_time.toString());
					var dateString:String = dateItem.date + " de " + monthArray[dateItem.month] + " de " + dateItem.fullYear + " a las " + dateItem.hours + ":" + dateItem.minutes;
					
					wallStatusView.likes.date_txt.text = dateString;
					wallStatusView.likes.likeItem.x = wallStatusView.likes.date_txt.x + wallStatusView.likes.date_txt.width + 5;
					userPhoto.onLoad();
					wallStatusView.title_txt.text = (fbservice.userObject.name != null) ? fbservice.feedArray[j].from.name : "";
					wallStatusView.text_txt.text = stringMoarr;
					wallStatusView.likes.y = wallStatusView.text_txt.y + wallStatusView.text_txt.height;
					wallStatusView.y = view.height + 20;
					view.addChild(wallStatusView);
				}
				
				/*else
				   {
				   var wallLinkView:WallLinkView = new WallLinkView();
				   var imagePicture:ImageView = new ImageView();
				   if (fbservice.feedArray[j].icon != null)
				   {
				   imageItem.imageURL = fbservice.feedArray[j].icon.toString()+"?access_token="+fbservice.accessToken;
				   //imageItem.onLoad();
				   //wallLinkView.likes.photoVideoContainer.addChild(imageItem);
				   }
				
				   wallLinkView.likes.photoVideoContainer.addChild(imageItem);
				   wallLinkView.title_txt.text = (fbservice.userObject.name != null) ? fbservice.userObject.name: "";
				   wallLinkView.text_txt.text = fbservice.feedArray[j].message.toString();
				   wallLinkView.photoContainer.addChild(userPhoto);
				   userPhoto.onLoad();
				   wallLinkView.videoItem.name_txt.text = fbservice.feedArray[j].name.toString() ;
				   wallLinkView.videoItem.link_txt.text = fbservice.feedArray[j].caption.toString() ;
				   wallLinkView.videoItem.video_txt.text = fbservice.feedArray[j].description.toString() ;
				   wallLinkView.videoItem.photoVideoContainer.addChild(imagePicture);
				   wallLinkView.y = view.height + 10 ;
				   view.addChild(wallLinkView);
				
				
				 }*/
			}
		}
	
	}

}