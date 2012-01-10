<div class="alogs form">
<?php echo $this->Form->create('Alog');?>
	<fieldset>
 		<legend><?php __('Add Alog'); ?></legend>
	<?php
		echo $this->Form->input('user_id');
		echo $this->Form->input('ip');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit', true));?>
</div>
<div class="actions">
	<h3><?php __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Html->link(__('List Alogs', true), array('action' => 'index'));?></li>
	</ul>
</div>