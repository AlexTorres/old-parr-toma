<div class="elogs form">
<?php echo $this->Form->create('Elog');?>
	<fieldset>
 		<legend><?php __('Add Elog'); ?></legend>
	<?php
		echo $this->Form->input('post_data');
		echo $this->Form->input('ip');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit', true));?>
</div>
<div class="actions">
	<h3><?php __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Html->link(__('List Elogs', true), array('action' => 'index'));?></li>
	</ul>
</div>