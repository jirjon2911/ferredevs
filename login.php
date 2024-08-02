<?php
include "layout/header.php";



//Compruyeba si el usuiario esta logueado, si sí entonces lo redirige a la pagina de inicio
if (isset($_SESSION["email"])) {
    header("location: /index.php");
    exit;
}

$email = "";
$error = "";
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $correo = $_POST['correo'];
    $contrasena = $_POST['contrasena'];

    if (empty($correo) || empty($contrasena)) {
        $error = 'Introduce el correo y la contraseña';
    } else {
        include "herramientas/basededatos.php";
        $conexion = crearConexion();
        $declaracion = $conexion->prepare(
            "SELECT IdPersona, rol, nombre, correo,  telefono, creado_en, contrasena FROM personal WHERE correo = ?"
        );

        // sustituir variables para ser preparadas como parametros
        $declaracion->bind_param("s", $correo);

        // ejecutar declaracion
        $declaracion->execute();

        // unir los resultados de las variables
        $declaracion->bind_result($IdPersona, $rol, $nombre, $correo, $telefono, $creado_en, $contrasena_almacenada);

        if ($declaracion->fetch()) {

            if (password_verify($contrasena, $contrasena_almacenada)) {
                // la contraseña es correcta

                // almacena los datos en variables de sesion 
                $_SESSION['id'] = $IdPersona;
                $_SESSION['correo'] = $correo;
                $_SESSION['nombre'] = $nombre;
                $_SESSION['telefono'] = $telefono;
                $_SESSION['creado_en'] = $creado_en;
                $_SESSION['privilegio'] = $rol;


                // redirecciona al usuario a la pagina principal
                header("location: /vistas_clientes/index.php");
                exit;
            }
        }
        $declaracion->close();
        $error = "Correo o contraseña incorrectas";

    }


}


?>

<div class="container py-5">
    <div class="mx-auto border shadow p-4" style="width:400px">
        <h2 class="text-cneter mb-4">Iniciar sesión</h2>
        <hr />

        <?php if (!empty($error)) { ?>
            <div class="alert alert-danger alert dismissible fade show" role="alert">
                <strong><?= $error ?></strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php } ?>

        <form method="post">
            <div class="mb-3">
                <label class="form-label">Correo electrónico</label>
                <input class="form-control" name="correo" value="<?= $email ?>" />

            </div>
            <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <input class="form-control" type="password" name="contrasena" />
            </div>
            <div class="row mb-3">
                <div class="col d-grid">
                    <button type="submit" class="btn btn-primary">Inicia sesión</button>
                </div>
                <div class="col d-grid">
                    <a href="/index.php" class="btn btn-outline-primary">Cancelar</a>
                </div>
            </div>

        </form>
    </div>
</div>



<?php
include "layout/footer.php";

?>