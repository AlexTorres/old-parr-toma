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

      echo $this->Html->css('bootstrap');

      echo $scripts_for_layout;
    ?>

  </head>

  <body>

    <div class="topbar">
      <div class="fill">
        <div class="container">
          <a class="brand" href="#">Oldparr toma</a>
          <ul class="nav">
            <li><?php echo $html->link("Usuarios", array("controller" => "users", "action" => "index"))?></li>
            <li><?php echo $html->link("Logs de acceso", array("controller" => "users", "action" => "index"))?></li>
            <li><?php echo $html->link("Logs de error", array("controller" => "users", "action" => "index"))?></li>
          </ul>
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
