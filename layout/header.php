<?php
session_start();
$auth = false;
if (isset($_SESSION["correo"])) {
  $rol = $_SESSION['privilegio'];
  $auth = true;
  switch ($rol) {
    case 'cliente':
      # code...
      $esAdmin = true;
      break;
    case 'empleado':
      # code...
      break;
    case 'admin':
      # code...
      break;
    
    default:
      # code...
      break;
  }



}
?>

<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Ferretería Azteca</title>
  <link rel="icon" href="/imgs/hammer.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>


  <nav class="navbar navbar-expand-lg bg-body-tertiary border-bottom shadow-sm">
    <div class="container">
      <a class="navbar-brand" href="/index.php">
        <img src="/imgs/hammer.png" width="30" height="30" class="d-inline-block align-top" alt="logo Hammer">
        Ferretería Azteca
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link text-dark" href="/index.php">Inicio</a>
          </li>
          <?php
          if ($auth) {
            ?>
            <li class="nav-item">
              <a class="nav-link text-dark" href="/index.php">Ver productos</a>
            </li>
            <?php
          }
          ?>
        </ul>
        <!-- CON LOGIN -->
        <?php
        if ($auth) {
          ?>
          <ul class="navbar-nav">
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle text-dark" href="#" role="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                Admin
              </a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="/profile.php">Perfil</a></li>
                <li>
                  <hr class="dropdown-divider">
                </li>
                <li><a class="dropdown-item" href="/logout.php">Cerrar sesión</a></li>
              </ul>
            </li>
          </ul>
          <?php
        } else {
          ?>
          <!-- CON LOGIN CIERRE -->
          <!-- SIN LOGIN -->
          <ul class="navbar-nav">
            <li><a class="btn btn-outline-primary me-2" href="/register.php">Registrate</a></li>
            <li><a class="btn btn-primary" href="/login.php">Iniciar sesión</a></li>
          </ul>
          <?php
        }
        ?>
        <!-- SIN LOGIN CIERRE -->
      </div>

    </div>
  </nav>