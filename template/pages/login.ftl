<!DOCTYPE html>
<html>
<#include "head.ftl">

<body>
  <div class="container">
    <div class="wrapper-login">
      <form action="authentication" method="POST" name="Login_Form" class="form-horizontal form-signin" role="form">
        <h3 class="form-signin-heading">Nplay Admin</h3>
        <hr class="colorgraph"><br>

        <#if message??>
          <#if message?length gt 1>
            <div class="error-message">
              <div class="alert alert-danger fade in">
                ${message}
              </div>
            </div>
          </#if>
        </#if>

        <div style="margin-bottom: 25px" class="input-group">
          <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
          <input id="username" type="text" class="form-control" name="username" placeholder="username" required="" autofocus>
        </div>

        <div style="margin-bottom: 25px" class="input-group">
          <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
          <input id="password" type="password" class="form-control" name="password" placeholder="password" required>
        </div>

        <button class="btn btn-lg btn-primary btn-block" type="Submit">Login</button>
      </form>
    </div>
  </div>
</body>

</html>
