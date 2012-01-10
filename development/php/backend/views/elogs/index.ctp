<div class="page-header">
  <h1>Error logs</h1>
</div>

<div class="row">

  <div class="span14">

    <div class="alert-message block-message info">

      <a href="#" class="close">x</a>

      <p>
        <strong>Logged events: </strong>
        <span class="big"><?php echo $total_events?></span>
      </p>

    </div>


    <div class="right">
      <?php echo $this->Html->link('Download excel spreadsheet', array('action' => 'add'), array('class' => 'btn success')); ?>
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
        <th>Reason</th>
        <th>POST data</th>
        <th>IP Address</th>
        <th>Created date</th>
      </tr>

      <?php foreach ($elogs as $elog): ?>

        <tr>
          <td>
            <?php echo $elog['Elog']['reason']; ?>
          </td>
          <td>
            <?php echo $elog['Elog']['post_data']; ?>
          </td>
          <td>
            <?php echo $elog['Elog']['ip']; ?>
          </td>

          <td>
            <a href="#" rel="twipsy" title="<?php echo $elog['Elog']['created'] ?>">
              <?php echo $time->timeAgoInWords($elog['Elog']['created']); ?>
            </a>
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
