-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-07-2024 a las 04:22:50
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ferredevs2`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `Nombre` varchar(255) DEFAULT NULL,
  `Descripcion` longtext DEFAULT NULL,
  `idCategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`Nombre`, `Descripcion`, `idCategoria`) VALUES
('Herramientas', 'Para trabajar', 1),
('cemento', 'Para mezclas', 2),
('ropa', 'Para ponerse', 3);

--
-- Disparadores `categoria`
--
DELIMITER $$
CREATE TRIGGER `delete_categoria` AFTER DELETE ON `categoria` FOR EACH ROW BEGIN
    INSERT INTO copia_categoria (
        tipo_de_cambio,
        Nombre, 
        Descripcion, 
        idCategoria 
    ) 
    VALUES (
        'Delete', 
        old.Nombre, 
        old.Descripcion, 
        old.idCategoria

    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_categoria` AFTER INSERT ON `categoria` FOR EACH ROW BEGIN
    INSERT INTO copia_categoria (
        tipo_de_cambio,
        Nombre, 
        Descripcion, 
        idCategoria 
    ) 
    VALUES (
        'Insert', 
        NEW.Nombre, 
        NEW.Descripcion, 
        NEW.idCategoria

    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_categoria` AFTER UPDATE ON `categoria` FOR EACH ROW BEGIN
    INSERT INTO copia_categoria (
        tipo_de_cambio,
        Nombre, 
        Descripcion, 
        idCategoria 
    ) 
    VALUES (
        'Update', 
        NEW.Nombre, 
        NEW.Descripcion, 
        NEW.idCategoria

    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `copia_categoria`
--

CREATE TABLE `copia_categoria` (
  `Nombre` varchar(255) DEFAULT NULL,
  `Descripcion` longtext DEFAULT NULL,
  `idCategoria` int(11) NOT NULL,
  `fecha_de_cambio` date NOT NULL DEFAULT current_timestamp(),
  `tipo_de_cambio` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `copia_categoria`
--

INSERT INTO `copia_categoria` (`Nombre`, `Descripcion`, `idCategoria`, `fecha_de_cambio`, `tipo_de_cambio`) VALUES
('Herramientas', 'Para trabajar', 1, '2024-07-18', 'Insert'),
('cemento', 'Para mezclas', 2, '2024-07-18', 'Insert'),
('ropa', 'Para ponerse', 3, '2024-07-18', 'Insert');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `copia_direccion`
--

CREATE TABLE `copia_direccion` (
  `calle` varchar(255) NOT NULL,
  `CodigoPostal` int(11) NOT NULL,
  `Colonia` varchar(255) NOT NULL,
  `IdDireccion` int(11) NOT NULL,
  `fecha_de_cambio` date NOT NULL DEFAULT current_timestamp(),
  `tipo_de_cambio` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `copia_direccion`
--

INSERT INTO `copia_direccion` (`calle`, `CodigoPostal`, `Colonia`, `IdDireccion`, `fecha_de_cambio`, `tipo_de_cambio`) VALUES
('calle', 2345, 'sadsad', 2, '2024-07-18', 'INSERT');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `copia_personal`
--

CREATE TABLE `copia_personal` (
  `nombre` varchar(255) NOT NULL,
  `privilegio` int(11) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `IdDirecciones` int(11) NOT NULL,
  `RFC` varchar(255) DEFAULT NULL,
  `IdPersona` int(11) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `fecha_cambio` date NOT NULL DEFAULT current_timestamp(),
  `tipo_de_cambio` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `copia_personal`
--

INSERT INTO `copia_personal` (`nombre`, `privilegio`, `correo`, `IdDirecciones`, `RFC`, `IdPersona`, `contrasena`, `fecha_cambio`, `tipo_de_cambio`) VALUES
('luis', 1, 'hola@gmail', 1, '12345', 10, 'kkjslad', '2024-07-18', ''),
('luis', 1, 'hola@gmail', 1, '12345', 10, 'kkjslad', '2024-07-18', 'Borrado'),
('luis', 1, 'hola@gmail', 1, '12345', 10, 'kkjslad', '2024-07-18', 'insercion'),
('raul', 1, 'sus@gmail', 2, '12131212', 12, 'sosss', '2024-07-18', 'insercion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `copia_producto`
--

CREATE TABLE `copia_producto` (
  `Nombre` varchar(255) NOT NULL,
  `IdCategoria` int(11) NOT NULL,
  `PrecioUnitario` double NOT NULL,
  `Marca` varchar(255) NOT NULL,
  `Codigo` bigint(20) NOT NULL,
  `PrecioDeCompra` double NOT NULL,
  `Existencias` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL CHECK (`PrecioUnitario` >= 0),
  `fecha_de_cambio` date NOT NULL DEFAULT current_timestamp(),
  `tipo_de_cambio` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `copia_producto`
--

INSERT INTO `copia_producto` (`Nombre`, `IdCategoria`, `PrecioUnitario`, `Marca`, `Codigo`, `PrecioDeCompra`, `Existencias`, `IdProducto`, `fecha_de_cambio`, `tipo_de_cambio`) VALUES
('Martillo', 1, 100, 'martillosSA', 12345678, 100, 100, 1, '2024-07-18', 'INSERT'),
('botas', 3, 250, 'marco', 1234567, 250, 100, 2, '2024-07-18', 'INSERT'),
('botas', 3, 250, 'marco', 1234567, 250, 80, 2, '2024-07-18', 'UPDATE'),
('tijeras', 2, 140, '120', 0, 120, 100, 4, '2024-07-19', 'INSERT'),
('tijeras', 1, 140, '120', 0, 120, 100, 5, '2024-07-19', 'INSERT'),
('tijeras', 2, 140, '120', 0, 120, 100, 4, '2024-07-19', 'DELETE'),
('botas', 3, 250, 'marco', 1234567, 100, 80, 2, '2024-07-19', 'UPDATE'),
('botas', 3, 250, 'marco', 1234567, 100, 70, 2, '2024-07-19', 'UPDATE'),
('Martillo', 1, 100, 'martillosSA', 12345678, 100, 130, 1, '2024-07-19', 'UPDATE'),
('botas', 3, 250, 'marco', 1234567, 100, 100, 2, '2024-07-19', 'UPDATE'),
('tijeras', 1, 140, '120', 0, 120, 130, 5, '2024-07-19', 'UPDATE'),
('Martillo', 1, 100, 'martillosSA', 12345678, 100, 140, 1, '2024-07-19', 'UPDATE'),
('botas', 3, 250, 'marco', 1234567, 100, 110, 2, '2024-07-19', 'UPDATE'),
('tijeras', 1, 140, '120', 0, 120, 140, 5, '2024-07-19', 'UPDATE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `copia_promocion`
--

CREATE TABLE `copia_promocion` (
  `CodigoPromocion` varchar(255) NOT NULL,
  `Descuento` double NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  `idTiempo` int(11) NOT NULL,
  `IdPromocion` int(11) NOT NULL CHECK (`Descuento` >= 0),
  `fecha_de_cambio` date NOT NULL DEFAULT current_timestamp(),
  `tipo_de_cambio` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `copia_promocion`
--

INSERT INTO `copia_promocion` (`CodigoPromocion`, `Descuento`, `Descripcion`, `idTiempo`, `IdPromocion`, `fecha_de_cambio`, `tipo_de_cambio`) VALUES
('12345', 20, 'POR DIA DEL PADRE', 1, 1, '2024-07-18', 'INSERT');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `copia_venta`
--

CREATE TABLE `copia_venta` (
  `IdProductos` int(11) NOT NULL,
  `CantidadesProducto` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`CantidadesProducto`)),
  `IdCliente` int(11) NOT NULL,
  `Subtotal` int(11) NOT NULL,
  `Total` double NOT NULL,
  `IdDireccion` int(11) NOT NULL,
  `IdPromocion` int(11) NOT NULL,
  `IdVenta` int(11) NOT NULL CHECK (`Total` >= 0),
  `fecha_de_cambio` date NOT NULL DEFAULT current_timestamp(),
  `tipo_de_cambio` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `copia_venta`
--

INSERT INTO `copia_venta` (`IdProductos`, `CantidadesProducto`, `IdCliente`, `Subtotal`, `Total`, `IdDireccion`, `IdPromocion`, `IdVenta`, `fecha_de_cambio`, `tipo_de_cambio`) VALUES
(1, '10', 10, 40, 1000, 1, 1, 1, '2024-07-18', 'INSERT'),
(1, '20', 10, 40, 50, 1, 2, 2, '2024-07-18', 'INSERT'),
(2, '20', 10, 40, 50, 1, 2, 0, '2024-07-18', 'INSERT'),
(2, '10', 12, 40, 40, 2, 1, 121, '2024-07-18', 'INSERT'),
(2, '20', 10, 40, 50, 1, 1, 100, '2024-07-18', 'INSERT'),
(2, '10', 10, 10, 10, 11, 1, 10, '2024-07-19', 'INSERT');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direccion`
--

CREATE TABLE `direccion` (
  `calle` varchar(255) NOT NULL,
  `CodigoPostal` int(11) NOT NULL,
  `Colonia` varchar(255) NOT NULL,
  `IdDireccion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `direccion`
--

INSERT INTO `direccion` (`calle`, `CodigoPostal`, `Colonia`, `IdDireccion`) VALUES
('luis', 4565, 'MEX', 1),
('calle', 2345, 'sadsad', 2);

--
-- Disparadores `direccion`
--
DELIMITER $$
CREATE TRIGGER `Delete_direccion` AFTER DELETE ON `direccion` FOR EACH ROW BEGIN
    INSERT INTO copia_direccion (
        tipo_de_cambio,
        calle, 
        CodigoPostal,
        Colonia,
        IdDireccion
    ) 
    VALUES (
        'DELETE', -- Aquí estoy asumiendo que "Actualizacion" es una constante
        old.calle,
        old.CodigoPostal,
        old.Colonia,
        old.IdDireccion
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UPDATE_direccion` AFTER UPDATE ON `direccion` FOR EACH ROW BEGIN
    INSERT INTO copia_direccion (
        tipo_de_cambio,
        calle, 
        CodigoPostal,
        Colonia,
        IdDireccion
    ) 
    VALUES (
        'UPDATE', -- Aquí estoy asumiendo que "Actualizacion" es una constante
        NEW.calle,
        NEW.CodigoPostal,
        NEW.Colonia,
        NEW.IdDireccion
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_direccion` AFTER INSERT ON `direccion` FOR EACH ROW BEGIN
    INSERT INTO copia_direccion (
        tipo_de_cambio,
        calle, 
        CodigoPostal,
        Colonia,
        IdDireccion
    ) 
    VALUES (
        'INSERT', -- Aquí estoy asumiendo que "Actualizacion" es una constante
        NEW.calle,
        NEW.CodigoPostal,
        NEW.Colonia,
        NEW.IdDireccion
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

CREATE TABLE `personal` (
  `nombre` varchar(255) NOT NULL,
  `rol` varchar(20) NOT NULL DEFAULT 'cliente',
  `correo` varchar(255) NOT NULL,
  `IdDirecciones` int(11) NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT current_timestamp(),
  `IdPersona` int(11) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`nombre`, `rol`, `correo`, `IdDirecciones`, `creado_en`, `IdPersona`, `contrasena`, `telefono`) VALUES
('luis', '1', 'hola@gmail', 1, '0000-00-00 00:00:00', 10, 'kkjslad', NULL),
('raul', '1', 'sus@gmail', 2, '1213-12-12 00:00:00', 12, 'sosss', NULL),
('Maximo', 'cliente', 'maximogtz@gmail.com', 0, '2024-07-21 19:18:25', 0, 'maximo123123', '3325384434'),
('Maximo', 'cliente', 'maximo@correo.com', 0, '2024-07-22 03:18:54', 0, '$2y$10$RAcLK5jXkc622RQ9/AnFtuA2.muMbHlQOEnhHVJclwGq2Oc.cTAe.', '3325384434'),
('Luis Rey', 'cliente', 'luis@correo.com', 0, '2024-07-22 03:20:41', 0, '$2y$10$RjE9cvKSLH6P7iCMjWKhTONp/HLGzX95RKVSidgAaU2KiL3AdDa5u', '33231223145'),
('Alexis Jair Lopez Razo', 'cliente', 'alexis@puntocom.com', 0, '2024-07-23 00:55:38', 0, '$2y$10$OyMu3u936FW2Zn8B0cI1u.Y.WKRaBJVdwdsAtvDxnS.97oKIrPg2u', '3325384434'),
('Maximo', 'cliente', 'maximo123@correo.com', 0, '2024-07-23 01:35:18', 0, '$2y$10$efRWAxPDV4De20kOphXTUehufSsiJ2M2LtjPRVD8h8cBEbXVlipYq', '33123123'),
('Maximo Gutierritos', 'cliente', 'maximogtz@yahoo.com', 0, '2024-07-23 04:16:55', 0, '$2y$10$j8hG9/jZwM41tdH8XWBtM.k6BhBxu9F8yYAVyezWE2u5zZydX7zOW', '3324234234'),
('Maximo', 'cliente', 'maximogtz1@yahoo.com', 0, '2024-07-23 04:19:09', 0, '$2y$10$FNkoSTHsnQoRgWiGDFC8QulW6UqFn6ACCqnzKVprt8KvqdjC6k6wi', '332412312');

--
-- Disparadores `personal`
--
DELIMITER $$
CREATE TRIGGER `Delete_personal` AFTER DELETE ON `personal` FOR EACH ROW BEGIN
    INSERT INTO copia_personal (
        tipo_de_cambio,
        nombre, 
        privilegio, 
        correo, 
        IdDirecciones, 
        RFC, 
        IdPersona, 
        contrasena
    ) 
    VALUES (
        'Borrado',
        old.nombre_usuario, 
        old.privilegio, 
        old.correo, 
        old.IdDirecciones, 
        old.RFC, 
        old.IdPersona, 
        old.contrasena
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_personal` AFTER UPDATE ON `personal` FOR EACH ROW BEGIN
    INSERT INTO copia_personal (
        tipo_de_cambio,
        nombre, 
        privilegio, 
        correo, 
        IdDirecciones, 
        RFC, 
        IdPersona, 
        contrasena
    ) 
    VALUES (
        'Actualizacion',
        NEW.nombre_usuario, 
        NEW.privilegio, 
        NEW.correo, 
        NEW.IdDirecciones, 
        NEW.RFC, 
        NEW.IdPersona, 
        NEW.contrasena
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `Nombre` varchar(255) NOT NULL,
  `IdCategoria` int(11) NOT NULL,
  `PrecioUnitario` double NOT NULL,
  `Marca` varchar(255) NOT NULL,
  `Codigo` bigint(20) NOT NULL,
  `PrecioDeCompra` double NOT NULL,
  `Existencias` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL CHECK (`PrecioUnitario` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`Nombre`, `IdCategoria`, `PrecioUnitario`, `Marca`, `Codigo`, `PrecioDeCompra`, `Existencias`, `IdProducto`) VALUES
('Martillo', 1, 100, 'martillosSA', 12345678, 100, 140, 1),
('botas', 3, 250, 'marco', 1234567, 100, 110, 2),
('tijeras', 1, 140, '120', 0, 120, 140, 5);

--
-- Disparadores `producto`
--
DELIMITER $$
CREATE TRIGGER `DELETE_producto` AFTER DELETE ON `producto` FOR EACH ROW BEGIN
    INSERT INTO copia_producto (
        tipo_de_cambio,
        Nombre, 
        IdCategoria, 
        PrecioUnitario, 
        Marca, 
        Codigo, 
        PrecioDeCompra, 
        Existencias,
        IdProducto
    ) 
    VALUES (
        'DELETE',
        OLD.Nombre, 
        OLD.IdCategoria, 
        OLD.PrecioUnitario, 
        OLD.Marca, 
        OLD.Codigo, 
        OLD.PrecioDeCompra, 
        OLD.Existencias,
        OLD.IdProducto
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_producto` AFTER INSERT ON `producto` FOR EACH ROW BEGIN
    INSERT INTO copia_producto (
        tipo_de_cambio,
        Nombre, 
        IdCategoria, 
        PrecioUnitario, 
        Marca, 
        Codigo, 
        PrecioDeCompra, 
        Existencias,
        IdProducto
    ) 
    VALUES (
        'INSERT',
        NEW.Nombre, 
        NEW.IdCategoria, 
        NEW.PrecioUnitario, 
        NEW.Marca, 
        NEW.Codigo, 
        NEW.PrecioDeCompra, 
        NEW.Existencias,
        NEW.IdProducto
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_producto` AFTER UPDATE ON `producto` FOR EACH ROW BEGIN
    INSERT INTO copia_producto (
        tipo_de_cambio,
        Nombre, 
        IdCategoria, 
        PrecioUnitario, 
        Marca, 
        Codigo, 
        PrecioDeCompra, 
        Existencias,
        IdProducto
    ) 
    VALUES (
        'UPDATE',
        NEW.Nombre, 
        NEW.IdCategoria, 
        NEW.PrecioUnitario, 
        NEW.Marca, 
        NEW.Codigo, 
        NEW.PrecioDeCompra, 
        NEW.Existencias,
        NEW.IdProducto
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promocion`
--

CREATE TABLE `promocion` (
  `CodigoPromocion` varchar(50) DEFAULT NULL,
  `Descuento` double DEFAULT NULL,
  `Descripcion` varchar(50) DEFAULT NULL,
  `IdPromocion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `promocion`
--

INSERT INTO `promocion` (`CodigoPromocion`, `Descuento`, `Descripcion`, `IdPromocion`) VALUES
('12345', 20, 'POR DIA DEL PADRE', 1);

--
-- Disparadores `promocion`
--
DELIMITER $$
CREATE TRIGGER `DELETE_promocion` AFTER DELETE ON `promocion` FOR EACH ROW BEGIN
    INSERT INTO copia_promocion (
        tipo_de_cambio,
        CodigoPromocion, 
        Descuento, 
        Descripcion, 
        IdPromocion 
    ) 
    VALUES (
        'DELETE',
        OLD.CodigoPromocion, 
        OLD.Descuento, 
        OLD.Descripcion, 
        OLD.IdPromocion 
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UPDATE_promocion` AFTER UPDATE ON `promocion` FOR EACH ROW BEGIN
    INSERT INTO copia_promocion (
        tipo_de_cambio,
        CodigoPromocion, 
        Descuento, 
        Descripcion, 
        IdPromocion 
    ) 
    VALUES (
        'UPDATE',
        NEW.CodigoPromocion, 
        NEW.Descuento, 
        NEW.Descripcion, 
        NEW.IdPromocion 
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_promocion` AFTER INSERT ON `promocion` FOR EACH ROW BEGIN
    INSERT INTO copia_promocion (
        tipo_de_cambio,
        CodigoPromocion, 
        Descuento, 
        Descripcion, 
        IdPromocion 
    ) 
    VALUES (
        'INSERT',
        NEW.CodigoPromocion, 
        NEW.Descuento, 
        NEW.Descripcion, 
        NEW.IdPromocion 
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `fecha_de_venta` timestamp NOT NULL DEFAULT current_timestamp(),
  `IdProductos` int(11) NOT NULL,
  `CantidadesProducto` int(11) DEFAULT NULL,
  `IdCliente` int(11) NOT NULL,
  `Total` double NOT NULL,
  `IdDireccion` int(11) NOT NULL,
  `IdPromocion` int(11) NOT NULL,
  `IdVenta` int(11) NOT NULL CHECK (`Total` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`fecha_de_venta`, `IdProductos`, `CantidadesProducto`, `IdCliente`, `Total`, `IdDireccion`, `IdPromocion`, `IdVenta`) VALUES
('2024-07-19 01:08:20', 2, 20, 10, 50, 1, 2, 0),
('2024-07-19 01:08:20', 1, 10, 10, 1000, 1, 1, 1),
('2024-07-19 01:08:20', 1, 20, 10, 50, 1, 2, 2),
('2024-07-19 01:08:20', 2, 10, 12, 40, 2, 1, 121),
('2024-07-19 01:26:08', 2, 20, 10, 50, 1, 1, 100),
('2024-07-20 00:10:57', 2, 10, 10, 10, 11, 1, 10);

--
-- Disparadores `venta`
--
DELIMITER $$
CREATE TRIGGER `restar_existencias` AFTER INSERT ON `venta` FOR EACH ROW BEGIN
    UPDATE producto
    SET Existencias = Existencias - NEW.CantidadesProducto
    WHERE `IdProducto` = NEW.IdProductos;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `venta_hecha`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `venta_hecha` (
`IdVenta` int(11)
,`nombre` varchar(255)
,`PRODUCTOS` mediumtext
,`Total` double
,`fecha_de_venta` timestamp
);

-- --------------------------------------------------------

--
-- Estructura para la vista `venta_hecha`
--
DROP TABLE IF EXISTS `venta_hecha`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `venta_hecha`  AS SELECT `v`.`IdVenta` AS `IdVenta`, `p`.`nombre` AS `nombre`, group_concat(concat(`o`.`Nombre`,' (',`v`.`CantidadesProducto`,')') order by `o`.`Nombre` ASC separator ', ') AS `PRODUCTOS`, `v`.`Total` AS `Total`, `v`.`fecha_de_venta` AS `fecha_de_venta` FROM ((`venta` `v` join `personal` `p` on(`v`.`IdCliente` = `p`.`IdPersona`)) join `producto` `o` on(`v`.`IdProductos` = `o`.`IdProducto`)) GROUP BY `p`.`nombre`, `v`.`fecha_de_venta` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
