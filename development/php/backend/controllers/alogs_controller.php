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

	function view($id = null) {
		if (!$id) {
			$this->Session->setFlash(__('Invalid alog', true));
			$this->redirect(array('action' => 'index'));
		}
		$this->set('alog', $this->Alog->read(null, $id));
	}

	function add() {
		if (!empty($this->data)) {
			$this->Alog->create();
			if ($this->Alog->save($this->data)) {
				$this->Session->setFlash(__('The alog has been saved', true));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The alog could not be saved. Please, try again.', true));
			}
		}
	}

	function edit($id = null) {
		if (!$id && empty($this->data)) {
			$this->Session->setFlash(__('Invalid alog', true));
			$this->redirect(array('action' => 'index'));
		}
		if (!empty($this->data)) {
			if ($this->Alog->save($this->data)) {
				$this->Session->setFlash(__('The alog has been saved', true));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The alog could not be saved. Please, try again.', true));
			}
		}
		if (empty($this->data)) {
			$this->data = $this->Alog->read(null, $id);
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
