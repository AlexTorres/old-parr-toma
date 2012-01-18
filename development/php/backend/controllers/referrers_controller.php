<?php
class ReferrersController extends AppController {

	var $uses = array('Referrer', 'Elog', 'User');
	var $paginate = array(
		'limit' => 30,
		'order' => array(
		  'Referrer.created' => 'DESC'
		)
	);
	var $name = 'Referrers';

	function index() {
		$this->Referrers->recursive = 1;
		$this->set('referrers', $this->paginate());
   		$this->set('total_events', $this->Referrer->find('count'));
	}

	function add() {
		$message = "";
	    $this->layout = 'ajax';

	    if (!empty($this->data)) {
	      $referrer = $this->data;
	      $valid = true;
	      $user_exists = false;
	      $facebook_id_is_ok = null;

	      // Total referrers present?
	      if(empty($referrer['Referrer']['total_referrers'])) {
	        $message = $message.'No total_referrers provided for the referrer. ';
	        $valid = false;
	      }

	      // Facebook ID present?
	      if(empty($referrer['Referrer']['facebookid'])) {
	        $message = $message.'No facebookid provided for the referrer. ';
	        $valid = false;
	      }
	      else{
	      	$facebook_id_is_ok = $this->User->findByFacebookid($referrer['Referrer']['facebookid']);
	      	if(empty($facebook_id_is_ok)){
	      		$message = $message.'There is no user with that facebookid. ';
	        	$valid = false;		
	      	}
	      	else{
	      		$user_exists = true;
	      	}
	      }

	      if($valid){
	        if(!empty($user_exists)){
	          // User exists, check if there is already a referrer record
	          $referrer_exists = $this->Referrer->findByUserId($facebook_id_is_ok['User']['id']);

	          if(empty($referrer_exists)){
	          	// It's a new referrer, please create a new record
	          	$new_record['user_id'] = $facebook_id_is_ok['User']['id'];
	          	$new_record['total_referrers'] = $this->data['Referrer']['total_referrers'];

	          	if ($this->Referrer->save($new_record)){
	          		$message = "Referrer saved";
	          		$this->set('type', 'success');
	        		$this->set('reason', $message);
	          	}
	          	else{
	          		$message = "Database error, please try again in a few moments. If the problem persists please communicate with the master of puppets.";
	          		$this->set('type', 'error');
	        		$this->set('reason', $message);
	          	}
	          }
	          else{
	          	// It's an existing record, please udpate it
	          	$referrer_exists['Referrer']['total_friends'] = $this->data['Referrer']['total_referrers']; 
	          	
	          	if ($this->Referrer->save($referrer_exists)){
	          		$message = "Referrer previously existed. Record updated";
		          	$this->set('type', 'success');
		          	$this->set('reason', $message);	
	          	}
	          	else{
	          		$message = "Database error, please try again in a few moments. If the problem persists please communicate with the master of puppets.";
	          		$this->set('type', 'error');
	        		$this->set('reason', $message);
	          	}
	          	
	          }

	      }

	  }
	  else {
	  	// Save the error event
	  	$error_event['Elog']['reason'] = $message;
	  	$error_event['Elog']['post_data'] = http_build_query($this->data);
	  	$error_event['Elog']['ip'] = $this->RequestHandler->getClientIP(); 
	  	$this->Elog->save($error_event);

	  	$this->set('type', 'error');
	  	$this->set('reason', $message);
	  }

	}
	else{
		// Create error event due to empty request.
		$message = 'Referrer - The request was empty';
		$error_event['Elog']['reason'] = $message;
		$error_event['Elog']['post_data'] = "";
		$error_event['Elog']['ip'] = $this->RequestHandler->getClientIP(); 
		$this->Elog->save($error_event);

		$this->set('type', 'error');
		$this->set('reason', $message);
	}
}

function delete($id = null) {
	if (!$id) {
		$this->Session->setFlash(__('Invalid id for alog', true));
		$this->redirect(array('action'=>'index'));
	}
	if ($this->Alog->delete($id)) {
		$this->Session->setFlash(__('Alog deleted', true));
		$this->redirect(array('action'=>'index'));
	}
	$this->Session->setFlash(__('Alog was not deleted', true));
	$this->redirect(array('action' => 'index'));
}
}
?>
