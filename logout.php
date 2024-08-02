<?php
// inicializar la sesión 
session_start();
// deshabilitar todas las variables de sesion
$_SESSION = array();
// destruir la sesion
session_destroy();
// redireccionar a la pagina de inicio
header("location: /index.php");