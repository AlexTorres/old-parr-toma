<div class="page-header">
  <h1>Referrers</h1>
</div>

<div class="row">

  <div class="span14">

    <div class="right">
      <?php echo $this->Html->link('Download excel spreadsheet', array('action' => 'export'), array('class' => 'btn success')); ?>
      <br />
      <br />
    </div>

    <div>
      <?php echo $this->Paginator->prev('&larr; ' . __('Previous', true), array('class'=>'prev', 'escape'=>false), null, array('class'=>'prev disabled', 'escape'=>false ));?> 
      <?php echo $this->Paginator->numbers();?>
      <?php echo $this->Paginator->next(__('Next', true) . ' &rarr;', array('class'=>'next', 'escape'=>false), null, array('class' => 'next disabled', 'escape'=>false));?>
    </div>

    <table class="bordered-table zebra-striped">
			<tr>
        <th>User data</th>
        <th>Other info</th>
        <th>Total referrers</th>
        <th>Options</th>
      </tr>

      <?php foreach ($referrers as $referrer): ?>

        <tr>
          <td>
            <h2><?php echo $referrer['User']['name']; ?> </h2>
            <a href="mailto:<?php echo $referrer['User']['email']?>"><?php echo $referrer['User']['email']?></a>
            <br />
            <strong>Facebook id</strong>: <?php echo $referrer['User']['facebookid']; ?>

            <hr />

            <strong>City</strong>: <?php echo $referrer['User']['current_city']; ?> 
            <br />

            <strong>Sex</strong>: <?php echo $referrer['User']['sex']; ?> 
            <br />

            <strong>Birth date</strong>: <?php echo $referrer['User']['birth_date']; ?> 
            <br />

          </td>
          <td>

            <strong>Created</strong>: 
            <a href="#" rel="twipsy" title="<?php echo $referrer['User']['created'] ?>">
              <?php echo $time->timeAgoInWords($referrer['User']['created']); ?>
            </a>
            <br />
            <strong>Updated</strong>: 
            <a href="#" rel="twipsy" title="<?php echo $referrer['User']['updated_at'] ?>">
              <?php echo $time->timeAgoInWords($referrer['User']['updated_at']); ?> 
            </a>
          </td>
          <td>
            <?php echo $referrer['Referrer']['total_friends'] ?>
          </td>
          <td>
            <?php echo $this->Html->link('Delete', array('action' => 'delete', $referrer['Referrer']['id']), array('class'=>'btn small danger'), sprintf(__('Are you sure you want to delete # %s?', true), $referrer['Referrer']['id'])); ?>
          </td>
        </tr>

      <?php endforeach; ?>

    </table>


  </div>

</div>

<?php
echo $this->Paginator->counter(array(
  'format' => __('Page %page% of %pages%', true)
));
?>
<br />
<br />
<div>
  <?php echo $this->Paginator->prev('&larr; ' . __('Previous', true), array('class'=>'prev', 'escape'=>false), null, array('class'=>'prev disabled', 'escape'=>false ));?> 
  <?php echo $this->Paginator->numbers();?>
  <?php echo $this->Paginator->next(__('Next', true) . ' &rarr;', array('class'=>'next', 'escape'=>false), null, array('class' => 'next disabled', 'escape'=>false));?>
</div>
