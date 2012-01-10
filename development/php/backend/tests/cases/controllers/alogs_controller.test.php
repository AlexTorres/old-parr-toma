<?php
/* Alogs Test cases generated on: 2012-01-08 01:29:03 : 1326004143*/
App::import('Controller', 'Alogs');

class TestAlogsController extends AlogsController {
	var $autoRender = false;

	function redirect($url, $status = null, $exit = true) {
		$this->redirectUrl = $url;
	}
}

class AlogsControllerTestCase extends CakeTestCase {
	var $fixtures = array('app.alog');

	function startTest() {
		$this->Alogs =& new TestAlogsController();
		$this->Alogs->constructClasses();
	}

	function endTest() {
		unset($this->Alogs);
		ClassRegistry::flush();
	}

	function testIndex() {

	}

	function testView() {

	}

	function testAdd() {

	}

	function testEdit() {

	}

	function testDelete() {

	}

}
?>