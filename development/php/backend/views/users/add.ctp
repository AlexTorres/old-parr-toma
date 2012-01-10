{'type': '<?php echo $type?>', 'reason': '<?php echo $reason?>'}


<div class="users form">
<?php echo $this->Form->create('User');?>
	<fieldset>
 		<legend><?php __('Add User'); ?></legend>
	<?php
		echo $this->Form->input('email');
		echo $this->Form->input('name');
		echo $this->Form->input('facebook_id');
		echo $this->Form->input('current_city');
		echo $this->Form->input('sex');
		echo $this->Form->input('birth_date');
		echo $this->Form->input('updated_at');
	?>
	</fieldset>
<?php echo $this->Form->end(__('Submit', true));?>
</div>
<div class="actions">
	<h3><?php __('Actions'); ?></h3>
	<ul>

		<li><?php echo $this->Html->link(__('List Users', true), array('action' => 'index'));?></li>
	</ul>
</div>
