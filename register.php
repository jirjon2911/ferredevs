<?php
include "layout/header.php";
if(isset($_SESSION['correo'])){
    header("location: /index.php");
    exit;
}

$nombre ="";
$correo = "";
$telefono = "";
$contrasena ="";
$confirmar_contrasena = "";

$nombre_error="";
$correo_error= "";
$telefono_error= "";
$contrasena_error= "";
$confirmar_contrasena_error= "";

$error = false;

// if(isset($_POST["nombre"], $_POST["correo"], $_POST["telefono"], $_POST["contrasena"], $_POST["confirmar_contrasena"])){
// die("Error al conectar con MySQL: ");
if($_SERVER['REQUEST_METHOD'] == "POST"){
        $nombre = $_POST["nombre"];
        $correo = $_POST["correo"];
        $telefono = $_POST["telefono"];
        $contrasena = $_POST["contrasena"];
        $confirmar_contrasena = $_POST["confirmar_contrasena"];
    
    
    
    
    
    
// }

/*******************VALIDAR NOMBRE************************/
if(empty($nombre)){
    $nombre_error = "Introduce tu nombre";
    $error = true;
};
/*******************VALIDAR CORREO************************/
if(!filter_var($correo, FILTER_VALIDATE_EMAIL)){
    $correo_error = "El correo electrónico no es válido";
    $error = true;
};

include "herramientas/basededatos.php";
$conexion = crearConexion();
$declaracion = $conexion -> prepare("SELECT IdPersona FROM personal WHERE correo = ?");

//Une variables para prepar la declaracion como parámetro
$declaracion->bind_param("s", $correo);

//ejecutar declaracion
$declaracion->execute();

//verificamos si el correl electrónico ya esta en la base de datos
$declaracion->store_result();
if($declaracion->num_rows > 0){
    $correo_error = "El correo ya está en uso";
    $error = true;
}
//cerramos esta declaracion, de otra forma no podremos hacer otra declaración
$declaracion ->close();



/*******************VALIDAR TELEFONO************************/
if(!preg_match("/^(\+|00\d{1,3})?[- ]?\d{7,12}$/", $telefono)){
    $telefono_error = "El telefono no es válido";
    $error = true;
}

/*******************VALIDAR CONTRASEÑA************************/
if(strlen($contrasena) < 6){
    $contrasena_error = "La contraseña debe tener al menos 6 caracteres";
    $error = true;
}
if($confirmar_contrasena != $contrasena){
    $confirmar_contrasena_error = "Las contraseñas no coinciden";
    $error = true;
}


if(!$error){
        $contrasena = password_hash($contrasena, PASSWORD_DEFAULT);
        $creado_en = date('Y-m-d H:i:s');
        echo $creado_en;
//  DEJA PREPARADAS LAS DECLARACIONES PARA EVADIR LOS ERRORES DE INYECCION SQL
        $declaracion = $conexion->prepare(
        "INSERT INTO personal (nombre, correo, creado_en, contrasena, telefono)" .
            "VALUES (?, ?, ?, ?, ?)"
    );

    $declaracion->bind_param("sssss", $nombre, $correo, $creado_en, $contrasena, $telefono);


    // ejecutar sentencia
    $declaracion->execute();
    $insert_id = $declaracion->insert_id;
    $declaracion->close();

    // Se ha creado una nueva cuenta

    // GUARDAMOS LOS DATOS DE LA SESION
    $_SESSION["id"] = $insert_id;
    $_SESSION["nombre"] = $nombre;
    $_SESSION["correo"] = $correo;
    $_SESSION["telefono"] = $telefono;
    $_SESSION["privilegio"] = 'cliente';
    $_SESSION['creado_en'] = $creado_en;

    header("location: /index.php");
    exit;

    }
}
    ?>

<div class="container py-5 w-100 ">
    <div class="row">
        <div class="col-lg-6 mx-auto border shadow p-3">

            <h2 class="text-center mb-4">Registrate</h2>
            <hr />
            <form method="post">
                <div class="row mb-3">
                    <label class="col-sm-4 col-form-lavel">Nombre*</label>
                    <div class="col-sm-8">
                        <input class="form-control" name="nombre" value="<?= $nombre ?>">
                        <span class="text-danger"><?= $nombre_error ?></span>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-4 col-form-lavel">Correo electrónico*</label>
                    <div class="col-sm-8">
                        <input class="form-control" name="correo" value="<?= $correo ?>">
                        <span class="text-danger"><?= $correo_error ?></span>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-4 col-form-lavel">Telefono*</label>
                    <div class="col-sm-8">
                        <input class="form-control" name="telefono" value="<?=  $telefono?>">
                        <span class="text-danger"><?= $telefono_error ?></span>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-4 col-form-label">Contraseña*</label>
                    <div class="col-sm-8">
                        <input class="form-control" type="password" name="contrasena">
                        <span class="text-danger"><?= $contrasena_error ?></span>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-4 col-form-label">Confirma tu contraseña*</label>
                    <div class="col-sm-8">
                        <input class="form-control" type="password" name="confirmar_contrasena">
                        <span class="text-danger"><?=$confirmar_contrasena_error ?></span>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="offset-sm-4 col-sm-4 d-grid">
                        <button type="submit" class="btn btn-primary">Registrar</button>
                    </div>
                    <div class="col-sm-4 d-grid">
                        <a href="/index.php" class="btn btn-outline-primary">
                            Cancelar
                            <!-- </div> -->
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <?php
    include "layout/footer.php"
        ?>