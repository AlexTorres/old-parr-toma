<?php
/* Elog Test cases generated on: 2012-01-08 01:28:32 : 1326004112*/
App::import('Model', 'Elog');

class ElogTestCase extends CakeTestCase {
	var $fixtures = array('app.elog');

	function startTest() {
		$this->Elog =& ClassRegistry::init('Elog');
	}

	function endTest() {
		unset($this->Elog);
		ClassRegistry::flush();
	}

}
?>