// JavaScript Document
var APP_ID = "204888432932799";
var d = new Date();
                 
var REDIRECT_URI = "http://www.alexgamer.net/oldParr";                
var PERMS = "email,publish_stream,offline_access,read_stream,friends_photos,friends_photos,user_photos,user_birthday,user_hometown,user_location,user_videos"; //comma separated list of extended permissions

$(document).on("ready", onStart);
function onStart()
{
   
   $("#facebookConnection").css( "display", "none" );  
  init();
}
function onConnect()
{
   
   FB.getLoginStatus(handleLoginOfNew);
}
                        
function init()
{
    FB.init({appId:APP_ID, status: true, cookie: true});
    FB.getLoginStatus(handleLoginStatus);
}
                        
function handleLoginStatus(response) 
{
   
    if (response.status == "connected") 
    { 
        swfobject.embedSWF("assets/swf/OldParrToma.swf?rnd"+d.getTime(), "flashContent", "100%", "100%", "10.0", null, null, null, {name:"flashContent"});
       
    } 
    else 
    { //put the button for login 
        $("#fbButton").on("click",onConnect);
         $("#facebookConnection").css( "display", "block" ); 
                                                                                
                                        
    }
}
function handleLoginOfNew(response)
{
    if (response.status == "connected") 
    { 
        $("#flashContent").css("min-height","1016");
        swfobject.embedSWF("assets/swf/OldParrToma.swf", "flashContent", "100%", "100%", "10.0", null, null, null, {name:"flashContent"});
        $(facebookConnection).css( "display", "none" );

    } 
    else 
    { //put the button for login 
       
        var params = window.location.toString().slice(window.location.toString().indexOf('?'));                                 
         top.location = 'https://graph.facebook.com/oauth/authorize?client_id='+APP_ID+'&scope='+PERMS+'&redirect_uri='+REDIRECT_URI+params;                                                                             
                                        
    }    

}

                       