<div class="elogs view">
<h2><?php  __('Elog');?></h2>
	<dl><?php $i = 0; $class = ' class="altrow"';?>
		<dt<?php if ($i % 2 == 0) echo $class;?>><?php __('Id'); ?></dt>
		<dd<?php if ($i++ % 2 == 0) echo $class;?>>
			<?php echo $elog['Elog']['id']; ?>
			&nbsp;
		</dd>
		<dt<?php if ($i % 2 == 0) echo $class;?>><?php __('Post Data'); ?></dt>
		<dd<?php if ($i++ % 2 == 0) echo $class;?>>
			<?php echo $elog['Elog']['post_data']; ?>
			&nbsp;
		</dd>
		<dt<?php if ($i % 2 == 0) echo $class;?>><?php __('Ip'); ?></dt>
		<dd<?php if ($i++ % 2 == 0) echo $class;?>>
			<?php echo $elog['Elog']['ip']; ?>
			&nbsp;
		</dd>
		<dt<?php if ($i % 2 == 0) echo $class;?>><?php __('Created'); ?></dt>
		<dd<?php if ($i++ % 2 == 0) echo $class;?>>
			<?php echo $elog['Elog']['created']; ?>
			&nbsp;
		</dd>
	</dl>
</div>
<div class="actions">
	<h3><?php __('Actions'); ?></h3>
	<ul>
		<li><?php echo $this->Html->link(__('Edit Elog', true), array('action' => 'edit', $elog['Elog']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('Delete Elog', true), array('action' => 'delete', $elog['Elog']['id']), null, sprintf(__('Are you sure you want to delete # %s?', true), $elog['Elog']['id'])); ?> </li>
		<li><?php echo $this->Html->link(__('List Elogs', true), array('action' => 'index')); ?> </li>
		<li><?php echo $this->Html->link(__('New Elog', true), array('action' => 'add')); ?> </li>
	</ul>
</div>
