<?php
class AlogsController extends AppController {

 	var $paginate = array(
    	'limit' => 30,
    	'order' => array(
      		'Alog.created' => 'DESC'
    	)
  	);
	var $name = 'Alogs';

	function index() {
		$this->Alog->recursive = 1;
		$this->set('alogs', $this->paginate());
    	$this->set('total_events', $this->Alog->find('count'));
	}

	function export()
	{
		$logs = $this->Alog->find('all');
		$this->set(compact('logs'));
	}
}
?>
