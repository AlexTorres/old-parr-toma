<?php
/* Alog Test cases generated on: 2012-01-08 01:28:13 : 1326004093*/
App::import('Model', 'Alog');

class AlogTestCase extends CakeTestCase {
	var $fixtures = array('app.alog');

	function startTest() {
		$this->Alog =& ClassRegistry::init('Alog');
	}

	function endTest() {
		unset($this->Alog);
		ClassRegistry::flush();
	}

}
?>