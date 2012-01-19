<?php
class ElogsController extends AppController {

  	var $paginate = array(
    	'limit' => 30,
    	'order' => array(
      		'Elog.created' => 'DESC'
    	)
  	);

	var $name = 'Elogs';

	function index() {
		$this->Elog->recursive = 0;
		$this->set('elogs', $this->paginate());
    	$this->set('total_events', $this->Elog->find('count'));
	}

	function export()
	{
		$logs = $this->Elog->find('all');
		$this->set(compact('logs'));
	}
}
?>
