Users service
=============
This service manages all the users registration for the App.


After the Facebook login, Alex makes a call to the service with the
following parameters via post.

User struct:  
__id:__ Autonum  
__email:__ The user email (mandatory)  
__name:__ The user name (mandatory)  
__facebook_id:__ The facebook id (mandatory)  
__current_city:__ The city the user lives in (optional)  
__sex:__ String representing the user sex (optional)  
__birth_date:__ String representing the user bith date (optional). Check
the string format, MM/DD/YYYY or what?  

Services responses
==================
The service can reply different messages according to each case:

__New user logged in:__ new_user_logged_in
__Old user logged in:__ old_user_logged_in
__Login error:__ loggin_error

`{message: 'message_string'}`  
Where `'message_string'` is the message identifier.


Error Log
=========
Each time there is a "Loggin error" message, the system will log the
reason of the error. Each record will have the following:  

* __post data:__ Data sent via POST.  
* __created:__ Hour/date of the service call  

There should be a webpage in which the error log can be viewed.

Login log
=========
Each time a user logs in, the system will log the following:

* __user_id:__ This is the local id of the logged in user.  
* __IP:__ The user IP address.  
* __date:__ The date/time of the login event.  
