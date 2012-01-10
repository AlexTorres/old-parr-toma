<div class="alogs view">
<h2><?php  __('Alog');?></h2>
	<dl><?php $i = 0; $class = ' class="altrow"';?>
		<dt<?php if ($i % 2 == 0) echo $class;?>><?php __('Id'); ?></dt>
		<dd<?php if ($i++ % 2 == 0) echo $class;?>>
			<?php echo $alog['Alog']['id']; ?>
			&nbsp;
		</dd>
		<dt<?php if ($i % 2 == 0) echo $class;?>><?php __('User Id'); ?></dt>
		<dd<?php if ($i++ % 2 == 0) echo $class;?>>
			<?php echo $alog['Alog']['user_id']; ?>
			&nbsp;
		</dd>
		<dt<?php if ($i % 2 == 0) echo $class;?>><?php __('Ip'); ?></dt>
		<dd<?php if ($i++ % 2 == 0) echo $class;?>>
			<?php echo $alog['Alog']['ip']; ?>
			&nbsp;
		</dd>
		<dt<?php if ($i % 2 == 0) echo $class;?>><?php __('Created'); ?></dt>
		<dd<?php if ($i++ % 2 == 0) echo $class;?>>
			<?php echo $alog['Alog']['created']; ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit Alog', true), array('action' => 'edit', $alog['Alog']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('Delete Alog', true), array('action' => 'delete', $alog['Alog']['id']), null, sprintf(__('Are you sure you want to delete # %s?', true), $alog['Alog']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List Alogs', true), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Alog', true), array('action' => 'add')); ?> </li>
	</ul>
</div>
