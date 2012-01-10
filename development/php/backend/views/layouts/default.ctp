<!DOCTYPE html>
<html lang="en">
  <head>
    <?php echo $this->Html->charset(); ?>
    <title>Olparr toma</title>

    <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le styles -->
    <?php
      echo $this->Html->meta('icon');

      echo $this->Javascript->link('https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js');
      echo $this->Javascript->link('bootstrap-modal');
      echo $this->Javascript->link('bootstrap-alerts');
      echo $this->Javascript->link('bootstrap-twipsy');
      echo $this->Javascript->link('bootstrap-popover');
      echo $this->Javascript->link('bootstrap-dropdown');
      echo $this->Javascript->link('bootstrap-scrollspy');
      echo $this->Javascript->link('bootstrap-tabs');
      echo $this->Javascript->link('bootstrap-buttons');
      echo $this->Html->css('bootstrap');
      echo $this->Html->css('http://fonts.googleapis.com/css?family=Open Sans&subset=latin');

      echo $scripts_for_layout;
    ?>

  </head>

  <body>

    <div class="topbar">
      <div class="fill">
        <div class="container">
          <?php echo $html->link("Oldparr toma", array("controller" => "users", "action" => "index"), array('class'=>'brand'))?>
          <ul class="nav">
            <li><?php echo $html->link("Users", array("controller" => "users", "action" => "index"))?></li>
            <li><?php echo $html->link("Access logs", array("controller" => "alogs", "action" => "index"))?></li>
            <li><?php echo $html->link("Error logs", array("controller" => "elogs", "action" => "index"))?></li>
          </ul>
          <div class="pull-right">
            <?php if (!is_null($this->Session->read('Auth.Admin'))): ?>
            <?php echo $html->link("Logout", array("controller" => "admins", "action" => "logout"), array('class'=>'btn danger small'))?>
            <?php endif?>
          </div>
        </div>

      </div>
    </div>

    <div class="container">

      <div class="content">
        <?php echo $this->Session->flash(); ?>

        <?php echo $content_for_layout; ?>
      </div>

      <footer>
        <p>&copy; Pech&aacute;n Inc 2012</p>
      </footer>

      <div class="row">

        <div class="span14">
          <?php echo $this->element('sql_dump'); ?>
        </div>

      </div>

    </div> <!-- /container -->

  </body>
</html>
