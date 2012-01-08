<div class="page-header">
  <h1>Users</h1>
</div>

<div class="row">

  <div class="span14">
    <div class="right">
      <?php echo $this->Html->link('Download excel spreadsheet', array('action' => 'add'), array('class' => 'btn success')); ?>
      <?php echo $this->Html->link(__('New User', true), array('action' => 'add'), array('class' => 'btn primary')); ?>
      <br />
      <br />
    </div>
    <table class="bordered-table zebra-striped">
			<tr>
        <th>User data</th>
        <th>Other info</th>
        <th>Options</th>
      </tr>

      <?php foreach ($users as $user): ?>

        <tr>
          <td>
            <h2><?php echo $user['User']['name']; ?> </h2>
            <a href="mailto:<?php echo $user['User']['email']?>"><?php echo $user['User']['email']?></a>
            <br />
            <strong>Facebook id</strong>: <?php echo $user['User']['facebook_id']; ?>

            <hr />

            <strong>City</strong>: <?php echo $user['User']['current_city']; ?> 
            <br />

            <strong>Sex</strong>: <?php echo $user['User']['sex']; ?> 
            <br />

            <strong>Birth date</strong>: <?php echo $user['User']['birth_date']; ?> 
            <br />

          </td>
          <td>

            <strong>Total logins</strong>: <span class="big">3</span>
            <br />

            <strong>Last login</strong>: 
            <a href="#" rel="twipsy" title="<?php echo $user['User']['created'] ?>">
              <?php echo $time->timeAgoInWords($user['User']['created']); ?>
            </a>
            <hr />

            <strong>Created</strong>: 
            <a href="#" rel="twipsy" title="<?php echo $user['User']['created'] ?>">
              <?php echo $time->timeAgoInWords($user['User']['created']); ?>
            </a>
            <br />
            <strong>Updated</strong>: 
            <a href="#" rel="twipsy" title="<?php echo $user['User']['updated_at'] ?>">
              <?php echo $time->timeAgoInWords($user['User']['updated_at']); ?> 
            </a>
          </td>
          <td>
            <?php if (Configure::read('debug') > 0): ?>
              <?php echo $this->Html->link('View', array('action' => 'view', $user['User']['id']), array('class' => 'btn small')); ?>
              <?php echo $this->Html->link('Edit', array('action' => 'edit', $user['User']['id']), array('class' => 'btn small')); ?>
            <?php endif; ?>

            <?php echo $this->Html->link('Delete', array('action' => 'delete', $user['User']['id']), array('class'=>'btn small danger'), sprintf(__('Are you sure you want to delete # %s?', true), $user['User']['id'])); ?>
          </td>
        </tr>

      <?php endforeach; ?>

    </table>


  </div>

</div>

<?php
echo $this->Paginator->counter(array(
  'format' => __('Page %page% of %pages%, showing %current% records out of %count% total, starting on record %start%, ending on %end%', true)
));
?>

  <div class="paging">
    <?php echo $this->Paginator->prev('<< ' . __('previous', true), array(), null, array('class'=>'disabled'));?>
   | 	<?php echo $this->Paginator->numbers();?>
 |
    <?php echo $this->Paginator->next(__('next', true) . ' >>', array(), null, array('class' => 'disabled'));?>
  </div>
