<?php
include "layout/header.php";

// verifica si el usuario se encuentra logueado, en caso de que no, retorna al index
if (!isset($_SESSION['correo'])) {
    header("location: /login.php");
}
?>


<?php
include "layout/footer.php";
?>