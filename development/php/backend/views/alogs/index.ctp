<div class="page-header">
  <h1>Access logs</h1>
</div>

<div class="row">

  <div class="span14">

    <div class="alert-message block-message info">

      <p>
        <strong>Logged events: </strong>
        <span class="big"><?php echo $total_events?></span>
      </p>

    </div>


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
        <th>User</th>
        <th>POST data</th>
        <th>IP Address</th>
        <th>Created date</th>
      </tr>

      <?php foreach ($alogs as $alog): ?>

        <tr>
          <td>
            <h2><?php echo $alog['User']['name']; ?> </h2>
            <a href="mailto:<?php echo $alog['User']['email']?>"><?php echo $alog['User']['email']?></a>
            <br />
            <strong>Facebook id</strong>: <?php echo $alog['User']['facebookid']; ?>

            <hr />

            <strong>City</strong>: <?php echo $alog['User']['current_city']; ?> 
            <br />

            <strong>Sex</strong>: <?php echo $alog['User']['sex']; ?> 
            <br />

            <strong>Birth date</strong>: <?php echo $alog['User']['birth_date']; ?> 
            <br />
          </td>
          <td>
            <pre>
              <?php echo rawurldecode($alog['Alog']['post_data']); ?>
            </pre>
          </td>
          <td>
            <?php echo $alog['Alog']['ip']; ?>
          </td>

          <td>
            <strong>Created</strong>: 
            <a href="#" rel="twipsy" title="<?php echo $alog['Alog']['created'] ?>">
              <?php echo $time->timeAgoInWords($alog['Alog']['created']); ?>
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
