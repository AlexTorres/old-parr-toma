<?php
class User extends AppModel {
	var $name = 'User';
	var $displayField = 'name';
  var $hasMany = array('Alog');
}
?>
