<div class="elogs form">
<?php echo $this->Form->create('Elog');?>
	<fieldset>
 		<legend><?php __('Edit Elog'); ?></legend>
	<?php
		echo $this->Form->input('id');
		echo $this->Form->input('post_data');
		echo $this->Form->input('ip');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit', true));?>
</div>
<div class="actions">
	<h3><?php __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Html->link(__('Delete', true), array('action' => 'delete', $this->Form->value('Elog.id')), null, sprintf(__('Are you sure you want to delete # %s?', true), $this->Form->value('Elog.id'))); ?></li>
		<li><?php echo $this->Html->link(__('List Elogs', true), array('action' => 'index'));?></li>
	</ul>
</div>