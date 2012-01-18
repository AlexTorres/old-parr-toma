Users service
=============
This service manages all the users registration for the App.

How to use the resource?
========================
Please follow this instructions in order to call the resource and create/login users.

__Resource url:__ /users/add  
`_method=POST`  
`data['User']['name']=John Doe`  
`data['User']['email']=john@doe.com`  
`data['User']['facebookid']=123456789`  
`data['User']['current_city']=Bogota`  
`data['User']['sex']=Male`  
`data['User']['birth_date']=Jan 1, 1900`  

Parameters
==========
After the Facebook login, Alex makes a call to the service with the
following parameters via post.

User struct:  
__id:__ Autonum  
__email:__ The user email (mandatory)  -> Will accept any string  
__name:__ The user name (mandatory)  -> Will accept any string  
__facebookid:__ The facebook id (mandatory) -> Will accept any string  
__current_city:__ The city the user lives in (optional) -> Will accept any string  
__sex:__ String representing the user sex (optional) -> Will accept any string  
__birth_date:__ String representing the user bith date (optional) -> Will accept any string  

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

Facebook Share/Invite Application count service 
===============================================
After the Facebook Share application feature.  makes a call to the service with the
following parameters via post.

__facebookid:__ The facebook id (mandatory) -> Will accept any string  
__countShare:__ The count of the invites of the aplication (mandatory)-> Will accept any string  

Services responses
==================
The service can reply different messages according to each case:

__Successful:__ the_request_successful  
__Failed:__ the_request_fail  
__service error:__ service_error  

Backend access and features
===========================
The system will have a backend that allows an identified user to access the following:
* __Download user data:__ A link to download an excel document, containing all the registered user data.
* __View error log:__ A page in which an admin can see the error log.
* __View login log:__ A page in which an admin can see the login log.
* __Download the Share/invite register: __ A link to download an excel document, containing all share/invite registration.
