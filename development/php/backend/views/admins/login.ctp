<?php echo $this->Session->flash('auth'); ?>
<form id="AdminLoginForm" method="post" action="/admins/login" accept-charset="utf-8">
  <fieldset>
    <legend>Login</legend>
    <div style="display:none;">
      <input type="hidden" name="_method" value="POST">
    </div>
  
    <div class="clearfix">
      <label for="AdminUsername">Username</label>
      <div class="input">
        <input name="data[Admin][username]" type="text" maxlength="50" id="AdminUsername">
      </div>
    </div>
  
    <div class="clearfix">
      <label for="AdminPassword">Password</label>
      <div class="input">
        <input type="password" name="data[Admin][password]" id="AdminPassword">
      </div>
    </div>
  
    <div class="actions">
      <input type="submit" value="Login" class="btn primary">
    </div>
  </fieldset>
</form>
