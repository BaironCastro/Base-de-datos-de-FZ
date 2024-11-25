-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-11-2024 a las 15:31:52
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
-- Base de datos: `farrazone`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarTelefonoUsuario` (IN `p_usuario_id` INT, IN `p_nuevo_telefono` VARCHAR(15))   BEGIN
    UPDATE usuario
    SET telefono = p_nuevo_telefono
    WHERE id = p_usuario_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarReservasYBar` ()   BEGIN
    SELECT 
        usuario.nombre AS NombreUsuario,
        usuario.apellido AS ApellidoUsuario,
        reservas.fecha_reserva AS FechaReserva,
        bares.nombre_bar AS NombreBar,
        bares.direccion AS DireccionBar
    FROM reservas
    INNER JOIN usuario ON reservas.usuario_id = usuario.id
    INNER JOIN bares ON reservas.bar_id = bares.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarReserva` (IN `p_reserva_id` INT)   BEGIN
    DELETE FROM reservas
    WHERE id = p_reserva_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarReserva` (IN `p_usuario_id` INT, IN `p_bar_id` INT, IN `p_fecha_reserva` DATE, IN `p_cantidad_sillas` INT, IN `p_cantidad_botellas` INT)   BEGIN
    INSERT INTO reservas (usuario_id, bar_id, fecha_reserva, cantidad_sillas, cantidad_botellas)
    VALUES (p_usuario_id, p_bar_id, p_fecha_reserva, p_cantidad_sillas, p_cantidad_botellas);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerReservasPorUsuario` ()   BEGIN
    SELECT 
        usuario.nombre AS NombreUsuario,
        usuario.apellido AS ApellidoUsuario,
        reservas.fecha_reserva AS FechaReserva,
        reservas.cantidad_sillas AS SillasReservadas,
        reservas.cantidad_botellas AS BotellasReservadas
    FROM reservas
    INNER JOIN usuario ON reservas.usuario_id = usuario.id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bares`
--

CREATE TABLE `bares` (
  `id` int(11) NOT NULL,
  `nombre_bar` varchar(100) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `pagina_web` varchar(255) DEFAULT NULL,
  `imagen_url` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `capacidad_minima` int(11) NOT NULL,
  `capacidad_maxima` int(11) NOT NULL,
  `codigo_vestimenta` varchar(255) NOT NULL,
  `evento_especial` tinyint(1) DEFAULT 0,
  `horario_bar` varchar(40) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id_usuario` int(11) NOT NULL,
  `id_Tematica` int(11) NOT NULL,
  `id_tipos_eventos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `bares`
--

INSERT INTO `bares` (`id`, `nombre_bar`, `direccion`, `pagina_web`, `imagen_url`, `descripcion`, `capacidad_minima`, `capacidad_maxima`, `codigo_vestimenta`, `evento_especial`, `horario_bar`, `activo`, `fecha_creacion`, `fecha_actualizacion`, `id_usuario`, `id_Tematica`, `id_tipos_eventos`) VALUES
(1, 'Bar La Cima', 'Calle 123 #45-67', 'www.lacima.com', NULL, 'Un bar con excelente vista', 50, 100, 'Casual', 1, '18:00-02:00', 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 1, 1, 1),
(2, 'Bar Nocturno', 'Carrera 10 #11-12', 'www.nocturno.com', NULL, 'Ambiente juvenil', 30, 60, 'Casual', 0, '19:00-01:00', 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 2, 2, 2),
(3, 'Bar El Encuentro', 'Calle 45 #23-90', 'www.elecuentro.com', NULL, 'Espacio para amigos', 20, 80, 'Formal', 0, '17:00-00:00', 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 3, 3, 3),
(4, 'Bar Medellín', 'Calle 80 #5-30', 'www.medellinbar.com', NULL, 'Lo mejor del ambiente paisa', 40, 100, 'Elegante', 1, '20:00-03:00', 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 4, 4, 4),
(5, 'Bar Bogotano', 'Carrera 7 #34-15', 'www.bogota.com', NULL, 'Un clásico capitalino', 25, 70, 'Casual', 0, '16:00-23:00', 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 5, 5, 5),
(6, 'Bar El Tropical', 'Carrera 12 #56-78', 'www.eltropical.com', NULL, 'Ambiente caribeño', 30, 100, 'Deportivo', 1, '20:00-02:00', 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 6, 6, 6),
(7, 'Bar La Esquina', 'Calle 67 #89-01', 'www.laesquina.com', NULL, 'Acogedor y divertido', 15, 50, 'Informal', 0, '15:00-22:00', 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 7, 7, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bebidas`
--

CREATE TABLE `bebidas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `precio` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen_url` varchar(255) DEFAULT NULL,
  `disponibilidad` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `bar_id` int(11) NOT NULL,
  `id_tipo_bebida` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `bebidas`
--

INSERT INTO `bebidas` (`id`, `nombre`, `precio`, `descripcion`, `imagen_url`, `disponibilidad`, `created_at`, `updated_at`, `bar_id`, `id_tipo_bebida`) VALUES
(1, 'Cubeta de Poker', 18000, 'Cerveza Poker (6 botellas)', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 1, 1),
(2, 'Vino Tinto', 42000, 'Vino tinto 750ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 1, 2),
(3, 'Whisky Chivas Regal', 95000, 'Whisky Chivas 12 años 375ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 1, 3),
(4, 'Cubeta de Aguila Light', 20000, 'Cerveza Aguila Light (6 botellas)', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 2, 1),
(5, 'Ginebra Tanqueray', 78000, 'Ginebra Tanqueray 750ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 2, 4),
(6, 'Ron Bacardí', 65000, 'Ron Bacardí 750ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 2, 5),
(7, 'Cubeta de Corona', 22000, 'Cerveza Corona (6 botellas)', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 3, 1),
(8, 'Tequila Don Julio', 89000, 'Tequila Don Julio Blanco 750ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 3, 6),
(9, 'Vodka Absolut', 48000, 'Vodka Absolut 750ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 3, 7),
(10, 'Whisky Johnnie Walker', 99000, 'Whisky Johnnie Walker Black 375ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 4, 3),
(11, 'Brandy Torres 10', 85000, 'Brandy Torres 750ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 4, 8),
(12, 'Pisco Sour', 55000, 'Pisco Sour listo para servir 750ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 4, 10),
(13, 'Cubeta de Club Colombia', 25000, 'Cerveza Club Colombia (6 botellas)', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 5, 1),
(14, 'Aguardiente Antioqueño', 34000, 'Aguardiente Antioqueño sin azúcar 375ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 5, 9),
(15, 'Baileys Original', 70000, 'Licor Baileys Original 750ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 5, 11),
(16, 'Cubeta de Redds', 19000, 'Cerveza Redds (6 botellas)', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 6, 1),
(17, 'Vino Blanco', 40000, 'Vino blanco seco 750ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 6, 2),
(18, 'Tequila Patrón', 92000, 'Tequila Patrón Reposado 750ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 6, 6),
(19, 'Whisky Glenfiddich', 105000, 'Whisky Glenfiddich 12 años 375ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 7, 3),
(20, 'Ginebra Bombay Sapphire', 81000, 'Ginebra Bombay Sapphire 750ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 7, 4),
(21, 'Ron Santa Teresa', 68000, 'Ron Santa Teresa 750ml', NULL, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41', 7, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_novedades`
--

CREATE TABLE `categorias_novedades` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categorias_novedades`
--

INSERT INTO `categorias_novedades` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Partidos', 'Disfrutar de un buen partido con amigos y bebidas.'),
(2, 'Cerveza Artesanal', 'Categoría para eventos relacionados con cervezas artesanales.'),
(3, 'Coctelería', 'Experiencias de mixología y coctelería en bares.'),
(4, 'Música en Vivo', 'Conciertos y presentaciones en bares con música en vivo.'),
(5, 'Fiestas Temáticas', 'Celebraciones con temáticas específicas en bares.'),
(6, 'Stand-Up Comedy', 'Presentaciones de comedia en bares.'),
(7, 'Happy Hour', 'Promociones y eventos durante las horas felices en bares.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `novedades`
--

CREATE TABLE `novedades` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `imagen_url` varchar(255) DEFAULT NULL,
  `entrada_gratis` tinyint(1) DEFAULT 1,
  `precio_entrada` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `activo` tinyint(1) DEFAULT 1,
  `bar_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `novedades`
--

INSERT INTO `novedades` (`id`, `nombre`, `descripcion`, `fecha_inicio`, `fecha_fin`, `direccion`, `imagen_url`, `entrada_gratis`, `precio_entrada`, `fecha_creacion`, `fecha_actualizacion`, `activo`, `bar_id`, `categoria_id`) VALUES
(1, 'Noche de rock en Vivo', 'Disfruta de una noche llena de rock en nuestro acogedor bar. Artistas invitados y ambiente.', '2023-11-25 00:00:00', '2023-11-25 00:00:00', 'Calle del Jazz 123', NULL, 0, 15000, '2023-11-20 05:00:00', '2023-11-20 05:00:00', 1, 1, 4),
(2, 'Fiesta de Disfraces', 'Celebra Halloween con nosotros. ¡El mejor disfraz gana un premio!', '2023-10-31 00:00:00', '2023-10-31 00:00:00', 'Avenida de la Fiesta 456', NULL, 1, 0, '2023-10-25 05:00:00', '2023-10-25 05:00:00', 1, 2, 5),
(3, 'Cata de Vinos', 'Descubre los mejores vinos de la región. Cata guiada por expertos.', '2023-12-02 00:00:00', '2023-12-02 00:00:00', 'Plaza de los Vinos 789', NULL, 0, 20000, '2023-11-25 05:00:00', '2023-11-25 05:00:00', 1, 3, 1),
(4, 'Karaoke Night', 'Canta tus canciones favoritas y diviértete con tus amigos.', '2023-11-18 00:00:00', '2023-11-18 00:00:00', 'Calle del Karaoke 567', NULL, 1, 0, '2023-11-15 05:00:00', '2023-11-15 05:00:00', 1, 4, 6),
(5, 'Torneo de Billar', 'Participa en nuestro torneo de billar y gana increíbles premios.', '2023-12-10 00:00:00', '2023-12-10 00:00:00', 'Calle del Billar 345', NULL, 0, 10000, '2023-11-28 05:00:00', '2023-11-28 05:00:00', 1, 5, 7),
(6, 'Noche de Stand-up Comedy', 'Ríete a carcajadas con nuestros comediantes invitados.', '2023-11-23 00:00:00', '2023-11-23 00:00:00', 'Teatro de la Comedia 987', NULL, 0, 12000, '2023-11-20 05:00:00', '2023-11-20 05:00:00', 1, 6, 2),
(7, 'Cata de Cervezas Artesanales', 'Descubre una amplia variedad de cervezas artesanales.', '2023-12-05 00:00:00', '2023-12-05 00:00:00', 'Fábrica de Cerveza 111', NULL, 0, 18000, '2023-11-27 05:00:00', '2023-11-27 05:00:00', 1, 7, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo_pago` varchar(50) NOT NULL,
  `estado_pago` enum('pendiente','completado','fallido','cancelado') DEFAULT 'pendiente',
  `fecha_pago` timestamp NOT NULL DEFAULT current_timestamp(),
  `descripcion` text DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `reserva_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `monto`, `metodo_pago`, `estado_pago`, `fecha_pago`, `descripcion`, `usuario_id`, `reserva_id`, `created_at`, `updated_at`) VALUES
(1, 150000.00, 'Efectivo', 'completado', '2024-11-25 14:19:41', 'Pago realizado en el bar', 8, 1, '2024-11-25 14:19:41', '2024-11-25 14:19:41'),
(2, 200000.00, 'Tarjeta de crédito', 'completado', '2024-11-25 14:19:41', 'Pago online', 9, 2, '2024-11-25 14:19:41', '2024-11-25 14:19:41'),
(3, 75000.00, 'PSE', 'fallido', '2024-11-25 14:19:41', 'Error de conexión', 10, 3, '2024-11-25 14:19:41', '2024-11-25 14:19:41'),
(4, 300000.00, 'Efectivo', 'cancelado', '2024-11-25 14:19:41', 'Cancelación previa', 11, 4, '2024-11-25 14:19:41', '2024-11-25 14:19:41'),
(5, 120000.00, 'Nequi', 'completado', '2024-11-25 14:19:41', 'Transferencia directa', 12, 5, '2024-11-25 14:19:41', '2024-11-25 14:19:41'),
(6, 250000.00, 'Tarjeta de débito', 'pendiente', '2024-11-25 14:19:41', 'Esperando confirmación', 13, 6, '2024-11-25 14:19:41', '2024-11-25 14:19:41'),
(7, 100000.00, 'Daviplata', 'completado', '2024-11-25 14:19:41', 'Pago con código QR', 14, 7, '2024-11-25 14:19:41', '2024-11-25 14:19:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_bebidas_actualizadas`
--

CREATE TABLE `registro_bebidas_actualizadas` (
  `id` int(11) NOT NULL,
  `nombre_anterior` varchar(100) DEFAULT NULL,
  `descripcion_anterior` varchar(255) DEFAULT NULL,
  `nombre_nuevo` varchar(100) DEFAULT NULL,
  `descripcion_nueva` varchar(255) DEFAULT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `registro_bebidas_actualizadas`
--

INSERT INTO `registro_bebidas_actualizadas` (`id`, `nombre_anterior`, `descripcion_anterior`, `nombre_nuevo`, `descripcion_nueva`, `fecha_actualizacion`) VALUES
(1, 'Cerveza Artesanal', 'Cerveza de sabor suave, hecha artesanalmente.', 'cubetazo artesanal', 'Cerveza de sabor suave, hecha artesanalmente.', '2024-11-25 14:31:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_bebidas_borradas`
--

CREATE TABLE `registro_bebidas_borradas` (
  `id` int(11) NOT NULL,
  `nombre_anterior` varchar(100) DEFAULT NULL,
  `descripcion_anterior` varchar(255) DEFAULT NULL,
  `fecha_borrado` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `registro_bebidas_borradas`
--

INSERT INTO `registro_bebidas_borradas` (`id`, `nombre_anterior`, `descripcion_anterior`, `fecha_borrado`) VALUES
(1, 'Vino Tinto', 'Vino tinto de calidad premium con un sabor afrutado.', '2024-11-25 14:26:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `fecha_reserva` datetime NOT NULL,
  `cantidad_sillas` int(11) DEFAULT 1,
  `cantidad_botellas` int(11) DEFAULT 1,
  `estado` enum('pendiente','confirmada','cancelada','asistida') DEFAULT 'pendiente',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hora_reserva` time NOT NULL,
  `bar_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `id_tipo_reserva` int(11) NOT NULL,
  `precio` int(11) NOT NULL,
  `comision` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `fecha_reserva`, `cantidad_sillas`, `cantidad_botellas`, `estado`, `fecha_creacion`, `fecha_actualizacion`, `hora_reserva`, `bar_id`, `usuario_id`, `id_tipo_reserva`, `precio`, `comision`) VALUES
(1, '2024-11-20 20:00:00', 5, 2, 'pendiente', '2024-11-25 14:19:41', '2024-11-25 14:19:41', '08:00:00', 1, 8, 10, 60000, 40000),
(2, '2024-11-25 19:30:00', 1, 1, 'confirmada', '2024-11-25 14:19:41', '2024-11-25 14:19:41', '10:00:00', 2, 9, 6, 30000, 15000),
(3, '2024-11-18 21:00:00', 4, 3, 'asistida', '2024-11-25 14:19:41', '2024-11-25 14:19:41', '03:00:00', 3, 10, 1, 100000, 55000),
(4, '2024-11-22 22:00:00', 6, 4, 'cancelada', '2024-11-25 14:19:41', '2024-11-25 14:19:41', '20:30:00', 4, 11, 2, 60000, 30000),
(5, '2024-11-19 20:30:00', 4, 1, 'pendiente', '2024-11-25 14:19:41', '2024-11-25 14:19:41', '06:00:00', 5, 12, 8, 100000, 100000),
(6, '2024-11-23 18:00:00', 10, 2, 'confirmada', '2024-11-25 14:19:41', '2024-11-25 14:19:41', '08:30:00', 6, 13, 9, 200000, 150000),
(7, '2024-11-21 17:30:00', 7, 3, 'asistida', '2024-11-25 14:19:41', '2024-11-25 14:19:41', '04:00:00', 7, 14, 7, 50000, 30000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tematica`
--

CREATE TABLE `tematica` (
  `id` int(11) NOT NULL,
  `tematica` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tematica`
--

INSERT INTO `tematica` (`id`, `tematica`) VALUES
(1, 'Rock'),
(2, 'Salsa'),
(3, 'Dance hall'),
(4, 'Reggae'),
(5, 'Crossover'),
(6, 'Viejoteca'),
(7, 'sinTematica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_bebida`
--

CREATE TABLE `tipos_bebida` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipos_bebida`
--

INSERT INTO `tipos_bebida` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Cubetazo', 'Bebidas alcohólicas fermentadas.'),
(2, 'Vino', 'Bebida alcohólica a base de uva.'),
(3, 'Whisky', 'Licor destilado a base de cereales.'),
(4, 'Ginebra', 'Con sabor a enebro y otros botánicos.'),
(5, 'Ron', 'Bebida alcohólica a base de caña de azúcar.'),
(6, 'Tequila y Mezcal', 'Licor destilado de agave.'),
(7, 'Vodka', 'Bebida alcohólica destilada incolora.'),
(8, 'Brandi o Coñac', 'Destilado de vinos o frutas destiladas.'),
(9, 'Aguariente', 'Destilado fuerte.'),
(10, 'Pisco', 'Aguardiente de uva.'),
(11, 'Baileys', 'Licor cremoso de wshiky y crema de leche'),
(13, 'cubetazo artesanal', 'Cerveza de sabor suave, hecha artesanalmente.');

--
-- Disparadores `tipos_bebida`
--
DELIMITER $$
CREATE TRIGGER `trigger_bebida_actualizar` BEFORE UPDATE ON `tipos_bebida` FOR EACH ROW BEGIN
    INSERT INTO registro_bebidas_actualizadas (
        nombre_anterior,
        descripcion_anterior,
        nombre_nuevo,
        descripcion_nueva
    ) 
    VALUES (
        OLD.nombre,
        OLD.descripcion,
        NEW.nombre,
        NEW.descripcion
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_bebida_borrar4` BEFORE DELETE ON `tipos_bebida` FOR EACH ROW BEGIN
    INSERT INTO registro_bebidas_borradas (
        nombre_anterior,
        descripcion_anterior
    ) 
    VALUES (
        OLD.nombre,
        OLD.descripcion
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_evento`
--

CREATE TABLE `tipos_evento` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `cantidad_maxima` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipos_evento`
--

INSERT INTO `tipos_evento` (`id`, `nombre`, `cantidad_maxima`, `descripcion`) VALUES
(1, 'Reserva', 30, 'Reserva'),
(2, 'Fiesta Cumpleaños', 20, 'organizamos tu cumpleaños con decoraciones tematicas'),
(3, 'Fiesta de fin de año', 25, 'organizamos tu fiesta de find de año'),
(4, 'Eventos corporativos', 50, 'invita a tu grupo de trabajo para una ocacion especial'),
(5, 'Despedida de solter@', 20, 'organizamos tu despedida de soltero con la mayor divercion antes de comprometerte'),
(6, 'Dia de la madres', 10, 'organizamos un dia especial para tu mama'),
(7, 'Graduacion', 10, 'organizamos tu celebracion de graduacion'),
(8, 'Despedida empresarial', 30, 'organiza tu grupo de amigos y celebra una despedida');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_reserva`
--

CREATE TABLE `tipos_reserva` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `id_tipo_evento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipos_reserva`
--

INSERT INTO `tipos_reserva` (`id`, `nombre`, `descripcion`, `id_tipo_evento`) VALUES
(1, 'Soltero', 'para con un grupo de desconocidos a un bar', 1),
(2, 'Grupo', 'cuando yo voy con mi parche', 1),
(3, 'Bar', 'eventos que puede realizar el bar', 1),
(4, 'Bar', 'eventos que puede realizar el bar', 2),
(5, 'Bar', 'eventos que puede realizar el bar', 3),
(6, 'Bar', 'eventos que puede realizar el bar', 4),
(7, 'Bar', 'eventos que puede realizar el bar', 5),
(8, 'Bar', 'eventos que puede realizar el bar', 6),
(9, 'Bar', 'eventos que puede realizar el bar', 7),
(10, 'Bar', 'eventos que puede realizar el bar', 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `id` int(11) NOT NULL,
  `tipo_documento` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipo_documento`
--

INSERT INTO `tipo_documento` (`id`, `tipo_documento`) VALUES
(1, 'CC'),
(2, 'NIT');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuarios`
--

CREATE TABLE `tipo_usuarios` (
  `id` varchar(5) NOT NULL,
  `tipo` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipo_usuarios`
--

INSERT INTO `tipo_usuarios` (`id`, `tipo`) VALUES
('1', 'SuperAdmin'),
('2', 'Admin'),
('3', 'Usuario'),
('4', 'Sociobar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicaciones`
--

CREATE TABLE `ubicaciones` (
  `id` int(11) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `localidad` varchar(255) NOT NULL,
  `longitud` varchar(100) NOT NULL,
  `latitud` varchar(100) NOT NULL,
  `bar_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ubicaciones`
--

INSERT INTO `ubicaciones` (`id`, `direccion`, `localidad`, `longitud`, `latitud`, `bar_id`) VALUES
(1, 'Calle 85 #12-34', 'Chapinero', '-74.0448', '4.6615', 1),
(2, 'Calle 82 #12-21', 'Zona T', '-74.0435', '4.6661', 2),
(3, 'Carrera 14 #83-56', 'Zona Rosa', '-74.0402', '4.6645', 3),
(4, 'Carrera 7 #65-17', 'Zona G', '-74.0594', '4.6549', 4),
(5, 'Calle 53 #13-45', 'Galerías', '-74.0637', '4.6473', 5),
(6, 'Carrera 5 #26-80', 'La Macarena', '-74.0632', '4.6138', 6),
(7, 'Carrera 10 #10-10', 'La Candelaria', '-74.0735', '4.6019', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(40) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `edad` int(11) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `genero` varchar(10) DEFAULT NULL,
  `id_tipo_usuario` varchar(16) NOT NULL,
  `id_tipo_documento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `email`, `contraseña`, `fecha_nacimiento`, `edad`, `fecha_registro`, `nombre`, `telefono`, `apellido`, `genero`, `id_tipo_usuario`, `id_tipo_documento`) VALUES
(1, 'juan.perez@example.com', '1234', '1990-01-01', 34, '2024-11-25 14:19:41', 'Juan', '3001234567', 'Perez', 'M', '4', 1),
(2, 'maria.gomez@example.com', 'abcd', '1985-05-15', 39, '2024-11-25 14:19:41', 'Maria', '3017654321', 'Gomez', 'F', '4', 1),
(3, 'carlos.lopez@example.com', '5678', '1992-10-20', 32, '2024-11-25 14:19:41', 'Carlos', '3023456789', 'Lopez', 'M', '4', 2),
(4, 'luis.rodriguez@example.com', 'pass', '1994-07-18', 30, '2024-11-25 14:19:41', 'Luis', '3034567890', 'Rodriguez', 'M', '4', 1),
(5, 'ana.martinez@example.com', 'secure', '1999-12-12', 25, '2024-11-25 14:19:41', 'Ana', '3045678901', 'Martinez', 'F', '4', 1),
(6, 'pedro.garcia@example.com', 'key123', '1988-03-25', 36, '2024-11-25 14:19:41', 'Pedro', '3056789012', 'Garcia', 'M', '4', 2),
(7, 'sofia.castro@example.com', 'qwerty', '1997-11-11', 27, '2024-11-25 14:19:41', 'Sofia', '3067890123', 'Castro', 'F', '4', 1),
(8, 'laura.fernandez@example.com', 'laura123', '1995-06-30', 29, '2024-11-25 14:19:41', 'Laura', '3078901234', 'Fernandez', 'F', '3', 1),
(9, 'diego.moreno@example.com', 'dmoreno', '1993-08-25', 31, '2024-11-25 14:19:41', 'Diego', '3089012345', 'Moreno', 'M', '3', 2),
(10, 'juliana.vargas@example.com', 'julie456', '2001-01-17', 23, '2024-11-25 14:19:41', 'Juliana', '3090123456', 'Vargas', 'F', '3', 1),
(11, 'andres.sanchez@example.com', 'pass567', '1998-04-10', 26, '2024-11-25 14:19:41', 'Andres', '3101234567', 'Sanchez', 'M', '3', 1),
(12, 'carolina.ruiz@example.com', 'caro890', '1990-09-05', 34, '2024-11-25 14:19:41', 'Carolina', '3112345678', 'Ruiz', 'F', '3', 2),
(13, 'fernando.torres@example.com', 'fern123', '1986-12-22', 37, '2024-11-25 14:19:41', 'Fernando', '3123456789', 'Torres', 'M', '3', 1),
(14, 'valeria.mendez@example.com', 'val2024', '1996-03-03', 28, '2024-11-25 14:19:41', 'Valeria', '3134567890', 'Mendez', 'F', '3', 2);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `ver_descripcion_bebidas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `ver_descripcion_bebidas` (
`descripcion` text
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `ver_nombre_bebidas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `ver_nombre_bebidas` (
`nombre` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `ver_descripcion_bebidas`
--
DROP TABLE IF EXISTS `ver_descripcion_bebidas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ver_descripcion_bebidas`  AS SELECT `tipos_bebida`.`descripcion` AS `descripcion` FROM `tipos_bebida` ORDER BY `tipos_bebida`.`descripcion` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `ver_nombre_bebidas`
--
DROP TABLE IF EXISTS `ver_nombre_bebidas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ver_nombre_bebidas`  AS SELECT `tipos_bebida`.`nombre` AS `nombre` FROM `tipos_bebida` ORDER BY `tipos_bebida`.`nombre` ASC ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bares`
--
ALTER TABLE `bares`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_Tematica` (`id_Tematica`),
  ADD KEY `id_tipos_eventos` (`id_tipos_eventos`),
  ADD KEY `idx_bares` (`nombre_bar`);

--
-- Indices de la tabla `bebidas`
--
ALTER TABLE `bebidas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bar_id` (`bar_id`),
  ADD KEY `id_tipo_bebida` (`id_tipo_bebida`);

--
-- Indices de la tabla `categorias_novedades`
--
ALTER TABLE `categorias_novedades`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `novedades`
--
ALTER TABLE `novedades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bar_id` (`bar_id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `reserva_id` (`reserva_id`);

--
-- Indices de la tabla `registro_bebidas_actualizadas`
--
ALTER TABLE `registro_bebidas_actualizadas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `registro_bebidas_borradas`
--
ALTER TABLE `registro_bebidas_borradas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bar_id` (`bar_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `id_tipo_reserva` (`id_tipo_reserva`);

--
-- Indices de la tabla `tematica`
--
ALTER TABLE `tematica`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipos_bebida`
--
ALTER TABLE `tipos_bebida`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipos_evento`
--
ALTER TABLE `tipos_evento`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipos_reserva`
--
ALTER TABLE `tipos_reserva`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tipo_evento` (`id_tipo_evento`);

--
-- Indices de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_usuarios`
--
ALTER TABLE `tipo_usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bar_id` (`bar_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_tipo_usuario` (`id_tipo_usuario`),
  ADD KEY `id_tipo_documento` (`id_tipo_documento`),
  ADD KEY `idx_usuairo` (`nombre`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bares`
--
ALTER TABLE `bares`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `bebidas`
--
ALTER TABLE `bebidas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `categorias_novedades`
--
ALTER TABLE `categorias_novedades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `novedades`
--
ALTER TABLE `novedades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `registro_bebidas_actualizadas`
--
ALTER TABLE `registro_bebidas_actualizadas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `registro_bebidas_borradas`
--
ALTER TABLE `registro_bebidas_borradas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tematica`
--
ALTER TABLE `tematica`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tipos_bebida`
--
ALTER TABLE `tipos_bebida`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `tipos_evento`
--
ALTER TABLE `tipos_evento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tipos_reserva`
--
ALTER TABLE `tipos_reserva`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bares`
--
ALTER TABLE `bares`
  ADD CONSTRAINT `bares_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `bares_ibfk_2` FOREIGN KEY (`id_Tematica`) REFERENCES `tematica` (`id`),
  ADD CONSTRAINT `bares_ibfk_3` FOREIGN KEY (`id_tipos_eventos`) REFERENCES `tipos_evento` (`id`);

--
-- Filtros para la tabla `bebidas`
--
ALTER TABLE `bebidas`
  ADD CONSTRAINT `bebidas_ibfk_1` FOREIGN KEY (`bar_id`) REFERENCES `bares` (`id`),
  ADD CONSTRAINT `bebidas_ibfk_2` FOREIGN KEY (`id_tipo_bebida`) REFERENCES `tipos_bebida` (`id`);

--
-- Filtros para la tabla `novedades`
--
ALTER TABLE `novedades`
  ADD CONSTRAINT `novedades_ibfk_1` FOREIGN KEY (`bar_id`) REFERENCES `bares` (`id`),
  ADD CONSTRAINT `novedades_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias_novedades` (`id`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `pagos_ibfk_2` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`);

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`bar_id`) REFERENCES `bares` (`id`),
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `reservas_ibfk_3` FOREIGN KEY (`id_tipo_reserva`) REFERENCES `tipos_reserva` (`id`);

--
-- Filtros para la tabla `tipos_reserva`
--
ALTER TABLE `tipos_reserva`
  ADD CONSTRAINT `tipos_reserva_ibfk_1` FOREIGN KEY (`id_tipo_evento`) REFERENCES `tipos_evento` (`id`);

--
-- Filtros para la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  ADD CONSTRAINT `ubicaciones_ibfk_1` FOREIGN KEY (`bar_id`) REFERENCES `bares` (`id`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_tipo_usuario`) REFERENCES `tipo_usuarios` (`id`),
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`id_tipo_documento`) REFERENCES `tipo_documento` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
