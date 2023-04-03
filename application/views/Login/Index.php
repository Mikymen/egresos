<div class="container">
  <div class="col-md-offset-4 col-md-4" style="margin-top:100px;">
    <!-- <div class="loginLogo">
              <img  src="assets/img/pharmaquick.png" />
      </div> -->
      <h2 class="text-center">SISTEMA DE EGRESOS DIARIOS</h2>
      <form class="form-signin" action="AuthController/Login" method="post">
        <h3 class="form-signin-heading text-center">Acceso</h3>
        <label for="inputEmail" class="sr-only">Usuario</label>
        <input type="text" name='username' id="inputEmail" class="form-control" placeholder="Usuario" required autofocus>
        <label for="inputPassword" class="sr-only">Contraseña</label>
        <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Contraseña" required>
        <!-- <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div> -->
        <button class="btn btn-lg btn-primary btn-block" type="submit">Ingresar</button>
      </form>
  </div>

  <div class="col-md-offset-4 col-md-4">
    <h4 style="color:green">Demo version</h4>
    Admin login:
    <ul>
      <li>User: admin</li>
      <li>Password: 123</li>
    </ul>
    Assistant login:
    <ul>
      <li>User: asistente</li>
      <li>Password: 123</li>
    </ul>
  </div>
</div> 