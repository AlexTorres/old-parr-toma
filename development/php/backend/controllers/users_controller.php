<?php
class UsersController extends AppController {

  var $uses = array('User', 'Elog', 'Alog', 'Referrer');
  var $paginate = array(
    'limit' => 10,
    'order' => array(
      'User.created' => 'DESC'
    )
  );
  var $name = 'Users';

  function index() {
    $this->User->recursive = 1;
    $this->set('users', $this->paginate());
    $this->set('total_users', $this->User->find('count'));
  }

  function add() {
    $message = "";
    $this->layout = 'ajax';

    if (!empty($this->data)) {
      $user = $this->data;
      $valid = true;

      // Email present?
      if(empty($user['User']['email'])) {
        $message = $message.'No email provided. ';
        $valid = false;
      }

      // Name present?
      if(empty($user['User']['name'])) {
        $message = $message.'No name provided. ';
        $valid = false;
      }

      // Facebook ID present?
      if(empty($user['User']['facebookid'])) {
        $message = $message.'No facebook id provided. ';
        $valid = false;
      }


      if($valid){
        $user_exists = $this->User->findByEmail($this->data['User']['email']);

        if(empty($user_exists)){
          // New user, create the user and the login event
          $message = 'New user created. Login event created. ';
          $this->User->save($this->data);

          $access_event['Alog']['user_id'] = $this->User->getLastInsertID();
          $access_event['Alog']['ip'] = $this->RequestHandler->getClientIP(); 
          $access_event['Alog']['post_data'] = http_build_query($this->data);
        }
        else{
          $message = 'Existing user. Login event created. ';
          $access_event['Alog']['user_id'] = $user_exists['User']['id'];
          $access_event['Alog']['ip'] = $this->RequestHandler->getClientIP(); 
          $access_event['Alog']['post_data'] = http_build_query($this->data);
        }

        $this->Alog->save($access_event);
        $this->set('type', 'success');
        $this->set('reason', $message);

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
      $message = 'The request was empty';
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
      $this->Session->setFlash(__('Invalid id for user', true));
      $this->redirect(array('action'=>'index'));
    }
    if ($this->User->delete($id)) {
      $this->Session->setFlash(__('User deleted', true));
      $this->redirect(array('action'=>'index'));
    }
    $this->Session->setFlash(__('User was not deleted', true));
    $this->redirect(array('action' => 'index'));
  }

}
?>
