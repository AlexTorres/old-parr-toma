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

	function view($id = null) {
		if (!$id) {
			$this->Session->setFlash(__('Invalid elog', true));
			$this->redirect(array('action' => 'index'));
		}
		$this->set('elog', $this->Elog->read(null, $id));
	}

	function add() {
		if (!empty($this->data)) {
			$this->Elog->create();
			if ($this->Elog->save($this->data)) {
				$this->Session->setFlash(__('The elog has been saved', true));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The elog could not be saved. Please, try again.', true));
			}
		}
	}

	function edit($id = null) {
		if (!$id && empty($this->data)) {
			$this->Session->setFlash(__('Invalid elog', true));
			$this->redirect(array('action' => 'index'));
		}
		if (!empty($this->data)) {
			if ($this->Elog->save($this->data)) {
				$this->Session->setFlash(__('The elog has been saved', true));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The elog could not be saved. Please, try again.', true));
			}
		}
		if (empty($this->data)) {
			$this->data = $this->Elog->read(null, $id);
		}
	}

	function delete($id = null) {
		if (!$id) {
			$this->Session->setFlash(__('Invalid id for elog', true));
			$this->redirect(array('action'=>'index'));
		}
		if ($this->Elog->delete($id)) {
			$this->Session->setFlash(__('Elog deleted', true));
			$this->redirect(array('action'=>'index'));
		}
		$this->Session->setFlash(__('Elog was not deleted', true));
		$this->redirect(array('action' => 'index'));
	}
}
?>
