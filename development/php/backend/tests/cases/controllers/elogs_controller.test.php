<?php
/* Elogs Test cases generated on: 2012-01-08 01:29:28 : 1326004168*/
App::import('Controller', 'Elogs');

class TestElogsController extends ElogsController {
	var $autoRender = false;

	function redirect($url, $status = null, $exit = true) {
		$this->redirectUrl = $url;
	}
}

class ElogsControllerTestCase extends CakeTestCase {
	var $fixtures = array('app.elog');

	function startTest() {
		$this->Elogs =& new TestElogsController();
		$this->Elogs->constructClasses();
	}

	function endTest() {
		unset($this->Elogs);
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