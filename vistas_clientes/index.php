<?php
include "../layout/header.php";

if (!isset($_SESSION['correo'])) {
    header("location: ../index.php");
}

?>

<style>
    <?php include 'styles.css'; ?>
</style>
<div style="min-height: 1000px; background-color:#D35400;">

    <div style="height:500px" class="imagenFondo pt-5">
        <div class="container w-50 shadow-lg p-2 mb-5 bg-white rounded">
            <h1>Bienvenido a nuestra tienda!</h1>
        </div>

        <div class="d-flex justify-content-around ">
            <div class="cajaHeader shadow-lg p-3 mb-5 bg-white rounded">
                Esta es mi primera cajas
                <a href="/index.php">

                    <img src="../imgs/svgs/homeIcon.svg" alt="no se cargo el svg" />
                </a>
                <i class="bi bi-airplane-fill"></i>
            </div>
            <div class="cajaHeader shadow-lg p-3 mb-5 bg-white rounded">
                Esta es mi segunda caja
            </div>
        </div>

    </div>
    <img src="../imgs/svgs/homeIcon.svg" alt="no se cargo el svg" />
</div>




<?php
include "../layout/footer.php";
?>