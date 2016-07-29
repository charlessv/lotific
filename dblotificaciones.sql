-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-07-2016 a las 01:53:49
-- Versión del servidor: 5.6.20
-- Versión de PHP: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `dblotificaciones`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_clientes`
--

CREATE TABLE IF NOT EXISTS `lo_clientes` (
  `cl_idcliente` varchar(10) NOT NULL,
  `cl_idempresa` int(11) NOT NULL DEFAULT '1',
  `cl_p_nombre` varchar(50) DEFAULT NULL,
  `cl_s_nombre` varchar(50) DEFAULT NULL,
  `cl_p_apellido` varchar(50) DEFAULT NULL,
  `cl_s_apellido` varchar(50) DEFAULT NULL,
  `cl_nombrecompleto` varchar(250) NOT NULL,
  `cl_num_documento` varchar(10) DEFAULT NULL,
  `cl_nit` varchar(20) DEFAULT NULL,
  `cl_direccion` varchar(100) DEFAULT NULL,
  `cl_id_municipio` int(11) DEFAULT NULL,
  `cl_id_depto` int(11) DEFAULT NULL,
  `cl_id_pais` int(11) DEFAULT NULL,
  `cl_telefono` varchar(10) DEFAULT NULL,
  `cl_movil` varchar(10) DEFAULT NULL,
  `cl_fax` varchar(10) DEFAULT NULL,
  `cl_email` varchar(50) DEFAULT NULL,
  `cl_fechaingreso` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cl_estado` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `lo_clientes`
--

INSERT INTO `lo_clientes` (`cl_idcliente`, `cl_idempresa`, `cl_p_nombre`, `cl_s_nombre`, `cl_p_apellido`, `cl_s_apellido`, `cl_nombrecompleto`, `cl_num_documento`, `cl_nit`, `cl_direccion`, `cl_id_municipio`, `cl_id_depto`, `cl_id_pais`, `cl_telefono`, `cl_movil`, `cl_fax`, `cl_email`, `cl_fechaingreso`, `cl_estado`) VALUES
('0000000001', 1, 'Carlos', 'Alberto', 'Cuadra', 'Serrano', 'Carlos Alberto Cuadra Serrano', '02672789-0', '0614-260481-115-6', '', 12, 4, 1, '7450-4858', '7450-4850', '', 'carlos.cuadra@outlook.com', '2015-01-22 19:24:54', 1),
('0000000001', 5, 'Leslie', 'Maria', 'Martinez', 'Enamorado', 'Leslie Maria Martinez Enamorado', '21212121-2', '1212-112121-211-1', '', 11, 4, 1, '1131-2312', '3123-1231', '', 'leslie.maria@hotmail.com', '2015-04-10 04:52:24', 1),
('0000000002', 1, 'Juan', '', 'Perez', '', 'Juan  Perez ', '22222222-2', '2222-222222-222-2', '', NULL, NULL, 1, '1111-1111', '1111-1111', '', 'juan.perez@outlook.com', '2015-01-22 19:36:17', 1),
('0000000003', 1, 'Juan', 'Alberto', 'Portillo', '', 'Juan Alberto Portillo ', '40404040-4', '4404-040400-404-0', 'San Sivar', 1, 3, 1, '3232-2332', '', '', 'juanportillo@gmail.com', '2015-01-30 20:40:28', 1);

--
-- Disparadores `lo_clientes`
--
DELIMITER //
CREATE TRIGGER `trggBeforeInsertLo_Clientes` BEFORE INSERT ON `lo_clientes`
 FOR EACH ROW begin
if NEW.cl_idempresa is null then
  set NEW.cl_idempresa=1;
end if;

set @ultimoCodigo=(select max(cl_idcliente) from lo_clientes where cl_idempresa=New.cl_idempresa);
if @ultimoCodigo is null then
	set @ultimoCodigo="0000000000";
end if;
set @parteNumerica=(@ultimoCodigo)+1;
set @longitudNumero=(select length(@parteNumerica));
set @codigoNumerico=concat(repeat('0', 10-@longitudNumero), @parteNumerica);
set @codigo=(@codigoNumerico);
set NEW.cl_idcliente=(select @codigo);
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_departamento`
--

CREATE TABLE IF NOT EXISTS `lo_departamento` (
`de_iddepartamento` int(11) NOT NULL,
  `de_descripcion` varchar(100) NOT NULL,
  `de_idpais` int(11) NOT NULL,
  `de_estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `lo_departamento`
--

INSERT INTO `lo_departamento` (`de_iddepartamento`, `de_descripcion`, `de_idpais`, `de_estado`) VALUES
(3, 'San Salvador', 59, 1),
(4, 'San Miguel', 59, 1),
(5, 'Santa Ana', 59, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_detallelotes`
--

CREATE TABLE IF NOT EXISTS `lo_detallelotes` (
  `dt_idlote` int(11) NOT NULL,
  `dt_poligono` varchar(2) DEFAULT NULL,
  `dt_idlotificacion` int(11) DEFAULT NULL,
  `dt_idcliente` int(11) DEFAULT NULL,
  `dt_plazo` int(11) DEFAULT NULL,
  `dt_fechaventa` datetime DEFAULT NULL,
  `dt_fechaultimopago` datetime DEFAULT NULL,
  `dt_interes` double DEFAULT NULL,
  `dt_prima` double DEFAULT NULL,
  `dt_cuota` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_detallepago`
--

CREATE TABLE IF NOT EXISTS `lo_detallepago` (
  `dp_idpago` int(11) NOT NULL,
  `dp_iddetpago` int(11) NOT NULL,
  `dp_capital` double DEFAULT NULL,
  `dp_interes` double DEFAULT NULL,
  `dp_iva` double DEFAULT NULL,
  `dp_prima` double DEFAULT NULL,
  `dp_mora` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_empresa`
--

CREATE TABLE IF NOT EXISTS `lo_empresa` (
`em_idempresa` int(11) NOT NULL,
  `em_nombre` varchar(100) NOT NULL,
  `em_fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `em_pais` int(11) DEFAULT NULL,
  `em_departamento` int(11) DEFAULT NULL,
  `em_municipio` int(11) DEFAULT NULL,
  `em_direccion` varchar(255) DEFAULT NULL,
  `em_estado` tinyint(1) DEFAULT '1',
  `em_codigoverificacion` varchar(13) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `lo_empresa`
--

INSERT INTO `lo_empresa` (`em_idempresa`, `em_nombre`, `em_fecharegistro`, `em_pais`, `em_departamento`, `em_municipio`, `em_direccion`, `em_estado`, `em_codigoverificacion`) VALUES
(1, 'LOTIVERSA', '2015-01-27 20:58:43', 1, 3, 1, 'ss', 1, '19LE00036'),
(2, 'Provivienda', '2015-01-27 21:00:55', 1, 3, 1, 'SS', 1, '111PE00044'),
(3, 'La Alcancia S.A', '2015-01-30 22:22:07', 1, 3, 1, 'Colonia Escalon', 1, '215LE00060'),
(4, 'ProTierra', '2015-01-30 22:39:04', 1, 3, 1, 'San Salvador', 1, '39PE00036'),
(5, 'Panaderia El Rosario', '2015-04-10 04:46:33', 1, 3, 1, 'Prueba', 1, '420PE00080'),
(6, 'Lotificaciones Pamplona', '2016-07-17 03:56:03', 1, 3, 1, 'Pamplona', 1, '523LE00092');

--
-- Disparadores `lo_empresa`
--
DELIMITER //
CREATE TRIGGER `trggBeforeInsertLo_empresa` BEFORE INSERT ON `lo_empresa`
 FOR EACH ROW begin
set @ultimoCodigo=(select max(em_idempresa) from lo_empresa);
if @ultimoCodigo is null then
	set @ultimoCodigo="1";
end if;

set @empresa=New.em_nombre;
set @textofijo="E";
set @letraempresa=mid(@empresa,1,1);
set @longitudempresa=(select length(@empresa));
set @codigoverifempresa=@longitudempresa*4;
set @longitudNumero=(select length(@codigoverifempresa));
set @codigoNumerico=concat(repeat('0', 5-@longitudNumero), @codigoverifempresa);
set @codigo=concat(@ultimoCodigo,@longitudempresa,@letraempresa,@textofijo,@codigoNumerico);

if (select length(@codigo)>13) then
    set @codigo=mid(@codigo,1,13);
end if;    

set NEW.em_codigoverificacion =(select @codigo);
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_funcionarios`
--

CREATE TABLE IF NOT EXISTS `lo_funcionarios` (
  `fu_idfuncionario` varchar(13) NOT NULL,
  `fu_pnombre` varchar(50) NOT NULL,
  `fu_snombre` varchar(50) DEFAULT NULL,
  `fu_papellido` varchar(50) NOT NULL,
  `fu_spellido` varchar(50) DEFAULT NULL,
  `fu_numdocumento` varchar(10) DEFAULT NULL,
  `fu_empresa` int(11) NOT NULL,
  `fu_email` varchar(45) NOT NULL,
  `fu_estado` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `lo_funcionarios`
--

INSERT INTO `lo_funcionarios` (`fu_idfuncionario`, `fu_pnombre`, `fu_snombre`, `fu_papellido`, `fu_spellido`, `fu_numdocumento`, `fu_empresa`, `fu_email`, `fu_estado`) VALUES
('1US0000000001', 'CARLOS', 'ALBERTO', 'CUADRA', 'SERRANO', '33333333-3', 1, 'carloscuadra@gmail.com', 1),
('2US0000000001', 'Juan', '', 'Perez', '', '11111111-1', 2, 'juanperez@gmail.com', 1),
('3US0000000001', 'Pedro', 'Alberto', 'Cuadra', 'Benavides', '91923922-9', 3, 'pedro.cuadra@outlook.com', 1),
('4US0000000001', 'Carlos', '', 'Cuadra', '', '40404040-4', 4, 'carlos.cuadra@hotmail.com', 1),
('5US0000000001', 'Leslie', 'Maria', 'Martinez', 'Enamorado', '11111111-1', 5, 'leslie.enamorado@elrosario.com', 1),
('6US0000000001', 'Carlos', 'Alberto', 'Cuadra', 'Serrano', '02672789-0', 6, 'carlos.cuadra@outlook.com', 1);

--
-- Disparadores `lo_funcionarios`
--
DELIMITER //
CREATE TRIGGER `trggBeforeInsertLo_funcionarios` BEFORE INSERT ON `lo_funcionarios`
 FOR EACH ROW begin
if NEW.fu_empresa is null then
  set NEW.fu_empresa=1;
end if;

set @ultimoCodigo=(select max(fu_idfuncionario) from lo_funcionarios where fu_empresa=New.fu_empresa);
if @ultimoCodigo is null then
	set @ultimoCodigo="0000000000";
end if;
set @empresa=New.fu_empresa;
set @textofijo="US";
set @parteNumerica=mid(@ultimoCodigo, 4, 10)+1;
set @longitudNumero=(select length(@parteNumerica));
set @codigoNumerico=concat(repeat('0', 10-@longitudNumero), @parteNumerica);
set @codigo=concat(@empresa,@textofijo,@codigoNumerico);
set NEW.fu_idfuncionario=(select @codigo);
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_lotes`
--

CREATE TABLE IF NOT EXISTS `lo_lotes` (
  `lt_idlote` int(11) NOT NULL,
  `lt_idlotificacion` int(11) NOT NULL,
  `lt_poligono` varchar(3) NOT NULL,
  `lt_area` double DEFAULT '0',
  `lt_precio` double DEFAULT '0',
  `lt_estado` char(1) DEFAULT 'V'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_lotificacion`
--

CREATE TABLE IF NOT EXISTS `lo_lotificacion` (
  `lo_idlotificacion` varchar(13) NOT NULL,
  `lo_empresa` int(11) NOT NULL,
  `lo_nombre` varchar(100) NOT NULL,
  `lo_propietario` varchar(100) DEFAULT NULL,
  `lo_direccion` varchar(100) DEFAULT NULL,
  `lo_idpais` int(11) DEFAULT NULL,
  `lo_iddepartamento` int(11) DEFAULT NULL,
  `lo_idmunicipio` int(11) DEFAULT NULL,
  `lo_area` double DEFAULT '0',
  `lo_numerolotes` int(11) DEFAULT '0',
  `lo_estado` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `lo_lotificacion`
--

INSERT INTO `lo_lotificacion` (`lo_idlotificacion`, `lo_empresa`, `lo_nombre`, `lo_propietario`, `lo_direccion`, `lo_idpais`, `lo_iddepartamento`, `lo_idmunicipio`, `lo_area`, `lo_numerolotes`, `lo_estado`) VALUES
('1LO0000000001', 1, 'Lotificación El Manguito', 'Juan Perez', 'San Salvador', 1, 3, 1, 0, NULL, 1),
('1LO0000000002', 1, 'Lotificación Las Flores', 'Juan Perez', 'San Miguel', 1, 4, 11, 0, NULL, 1),
('1LO0000000003', 1, 'Lotificación Las Dunas', 'Juan Perez', 'Chalchuapa', 1, 5, 16, 0, NULL, 1),
('1LO0000000004', 1, 'Lotificacion Santo Tomas', 'Juan Perez Sosa', 'Soyajevo', 1, 3, 1, 0, NULL, 1),
('1LO0000000005', 1, 'Lotificacion La Providencia', 'Juan Perez', 'Canton las Lomas', 1, 4, 14, 250.1, 30, 1),
('1LO0000000006', 1, 'Prueba', 'Prueba', '', NULL, NULL, NULL, NULL, NULL, 1),
('1LO0000000007', 1, 'Lotificacion la Manzana', 'Carlos Cuadra', 'Prueba', 1, 3, 1, 2000, NULL, 1),
('1LO0000000008', 1, 'Lotificacion la Manzana1', 'Carlos Cuadra', 'Prueba', 1, 3, 3, 2000, NULL, 1),
('1LO0000000009', 1, 'Prueba2', 'Prueba', '', 1, 3, 4, 2000, NULL, 1),
('1LO0000000010', 1, 'Prueba4', 'prueba4', 'asfa', 1, 3, 1, 400, NULL, 1),
('1LO0000000011', 1, 'AFDASFD', 'jUAN PEREZ', '', NULL, NULL, NULL, NULL, NULL, 1),
('2LO0000000001', 2, 'Lotificación El Manguito', 'Juan Perez', 'San Rafael ', 1, 4, 14, 400, 100, 1);

--
-- Disparadores `lo_lotificacion`
--
DELIMITER //
CREATE TRIGGER `trggBeforeInsertLo_Lotificaciones` BEFORE INSERT ON `lo_lotificacion`
 FOR EACH ROW begin
if NEW.lo_empresa is null then
  set NEW.lo_empresa=1;
end if;

set @ultimoCodigo=(select max(lo_idlotificacion) from lo_lotificacion where lo_empresa=New.lo_empresa);
if @ultimoCodigo is null then
	set @ultimoCodigo="0000000000";
end if;
set @empresa=New.lo_empresa;
set @textofijo="LO";
set @parteNumerica=mid(@ultimoCodigo, 4, 10)+1;
set @longitudNumero=(select length(@parteNumerica));
set @codigoNumerico=concat(repeat('0', 10-@longitudNumero), @parteNumerica);
set @codigo=concat(@empresa,@textofijo,@codigoNumerico);
set NEW.lo_idlotificacion=(select @codigo);
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_municipios`
--

CREATE TABLE IF NOT EXISTS `lo_municipios` (
`mu_idmunicipio` int(11) NOT NULL,
  `mu_descripcion` varchar(100) NOT NULL,
  `mu_iddepartamento` int(11) NOT NULL,
  `mu_estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Volcado de datos para la tabla `lo_municipios`
--

INSERT INTO `lo_municipios` (`mu_idmunicipio`, `mu_descripcion`, `mu_iddepartamento`, `mu_estado`) VALUES
(1, 'San Salvador', 3, 1),
(2, 'Soyapango', 3, 1),
(3, 'Ilopango', 3, 1),
(4, 'San Martin', 3, 1),
(5, 'Aguilares', 3, 1),
(6, 'San Marcos', 3, 1),
(7, 'Santo Tomas', 3, 1),
(8, 'Apopa', 3, 1),
(9, 'Mejicanos', 3, 1),
(10, 'Carolina', 4, 1),
(11, 'San Miguel', 4, 1),
(12, 'Chinameca', 4, 1),
(13, 'Lolotique', 4, 1),
(14, 'San Rafael Oriente', 4, 1),
(15, 'Metapan', 5, 1),
(16, 'Santa Ana', 5, 1),
(17, 'Coatepeque', 5, 1),
(18, 'El Congo', 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_pagos`
--

CREATE TABLE IF NOT EXISTS `lo_pagos` (
  `pa_idpago` int(11) NOT NULL,
  `pa_factura` varchar(15) NOT NULL,
  `pa_idcliente` int(11) DEFAULT NULL,
  `pa_fecha` datetime NOT NULL,
  `pa_valor` double DEFAULT NULL,
  `pa_estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_pais`
--

CREATE TABLE IF NOT EXISTS `lo_pais` (
`pa_pais` int(11) NOT NULL,
  `pa_descripcionesp` varchar(100) NOT NULL,
  `pa_descripcioneng` varchar(100) DEFAULT NULL,
  `pa_iso2` varchar(3) NOT NULL,
  `pa_iso3` varchar(3) DEFAULT NULL,
  `pa_codigotelefono` varchar(4) DEFAULT NULL,
  `pa_estado` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=247 ;

--
-- Volcado de datos para la tabla `lo_pais`
--

INSERT INTO `lo_pais` (`pa_pais`, `pa_descripcionesp`, `pa_descripcioneng`, `pa_iso2`, `pa_iso3`, `pa_codigotelefono`, `pa_estado`) VALUES
(1, 'Afganist', 'Afghanistan', 'AF', 'AFG', '93', 1),
(2, 'Albania', 'Albania', 'AL', 'ALB', '355', 1),
(3, 'Alemania', 'Germany', 'DE', 'DEU', '49', 1),
(4, 'Algeria', 'Algeria', 'DZ', 'DZA', '213', 1),
(5, 'Andorra', 'Andorra', 'AD', 'AND', '376', 1),
(6, 'Angola', 'Angola', 'AO', 'AGO', '244', 1),
(7, 'Anguila', 'Anguilla', 'AI', 'AIA', '1 26', 1),
(8, 'Ant?rtida', 'Antarctica', 'AQ', 'ATA', '672', 1),
(9, 'Antigua y Barbuda', 'Antigua and Barbuda', 'AG', 'ATG', '1 26', 1),
(10, 'Antillas Neerlandesas', 'Netherlands Antilles', 'AN', 'ANT', '599', 1),
(11, 'Arabia Saudita', 'Saudi Arabia', 'SA', 'SAU', '966', 1),
(12, 'Argentina', 'Argentina', 'AR', 'ARG', '54', 1),
(13, 'Armenia', 'Armenia', 'AM', 'ARM', '374', 1),
(14, 'Aruba', 'Aruba', 'AW', 'ABW', '297', 1),
(15, 'Australia', 'Australia', 'AU', 'AUS', '61', 1),
(16, 'Austria', 'Austria', 'AT', 'AUT', '43', 1),
(17, 'Azerbay', 'Azerbaijan', 'AZ', 'AZE', '994', 1),
(18, 'B?lgica', 'Belgium', 'BE', 'BEL', '32', 1),
(19, 'Bahamas', 'Bahamas', 'BS', 'BHS', '1 24', 1),
(20, 'Bahrein', 'Bahrain', 'BH', 'BHR', '973', 1),
(21, 'Bangladesh', 'Bangladesh', 'BD', 'BGD', '880', 1),
(22, 'Barbados', 'Barbados', 'BB', 'BRB', '1 24', 1),
(23, 'Belice', 'Belize', 'BZ', 'BLZ', '501', 1),
(24, 'Ben', 'Benin', 'BJ', 'BEN', '229', 1),
(25, 'Bhut', 'Bhutan', 'BT', 'BTN', '975', 1),
(26, 'Bielorrusia', 'Belarus', 'BY', 'BLR', '375', 1),
(27, 'Birmania', 'Myanmar', 'MM', 'MMR', '95', 1),
(28, 'Bolivia', 'Bolivia', 'BO', 'BOL', '591', 1),
(29, 'Bosnia y Herzegovina', 'Bosnia and Herzegovina', 'BA', 'BIH', '387', 1),
(30, 'Botsuana', 'Botswana', 'BW', 'BWA', '267', 1),
(31, 'Brasil', 'Brazil', 'BR', 'BRA', '55', 1),
(32, 'Brun', 'Brunei', 'BN', 'BRN', '673', 1),
(33, 'Bulgaria', 'Bulgaria', 'BG', 'BGR', '359', 1),
(34, 'Burkina Faso', 'Burkina Faso', 'BF', 'BFA', '226', 1),
(35, 'Burundi', 'Burundi', 'BI', 'BDI', '257', 1),
(36, 'Cabo Verde', 'Cape Verde', 'CV', 'CPV', '238', 1),
(37, 'Camboya', 'Cambodia', 'KH', 'KHM', '855', 1),
(38, 'Camer?n', 'Cameroon', 'CM', 'CMR', '237', 1),
(39, 'Canad', 'Canada', 'CA', 'CAN', '1', 1),
(40, 'Chad', 'Chad', 'TD', 'TCD', '235', 1),
(41, 'Chile', 'Chile', 'CL', 'CHL', '56', 1),
(42, 'China', 'China', 'CN', 'CHN', '86', 1),
(43, 'Chipre', 'Cyprus', 'CY', 'CYP', '357', 1),
(44, 'Ciudad del Vaticano', 'Vatican City State', 'VA', 'VAT', '39', 1),
(45, 'Colombia', 'Colombia', 'CO', 'COL', '57', 1),
(46, 'Comoras', 'Comoros', 'KM', 'COM', '269', 1),
(47, 'Congo', 'Congo', 'CG', 'COG', '242', 1),
(49, 'Corea del Norte', 'North Korea', 'KP', 'PRK', '850', 1),
(50, 'Corea del Sur', 'South Korea', 'KR', 'KOR', '82', 1),
(51, 'Costa de Marfil', 'Ivory Coast', 'CI', 'CIV', '225', 1),
(52, 'Costa Rica', 'Costa Rica', 'CR', 'CRI', '506', 1),
(53, 'Croacia', 'Croatia', 'HR', 'HRV', '385', 1),
(54, 'Cuba', 'Cuba', 'CU', 'CUB', '53', 1),
(55, 'Dinamarca', 'Denmark', 'DK', 'DNK', '45', 1),
(56, 'Dominica', 'Dominica', 'DM', 'DMA', '1 76', 1),
(57, 'Ecuador', 'Ecuador', 'EC', 'ECU', '593', 1),
(58, 'Egipto', 'Egypt', 'EG', 'EGY', '20', 1),
(59, 'El Salvador', 'El Salvador', 'SV', 'SLV', '503', 1),
(60, 'Emiratos ?rabes Unidos', 'United Arab Emirates', 'AE', 'ARE', '971', 1),
(61, 'Eritrea', 'Eritrea', 'ER', 'ERI', '291', 1),
(62, 'Eslovaquia', 'Slovakia', 'SK', 'SVK', '421', 1),
(63, 'Eslovenia', 'Slovenia', 'SI', 'SVN', '386', 1),
(64, 'Espa', 'Spain', 'ES', 'ESP', '34', 1),
(65, 'Estados Unidos de Am?rica', 'United States of America', 'US', 'USA', '1', 1),
(66, 'Estonia', 'Estonia', 'EE', 'EST', '372', 1),
(67, 'Etiop', 'Ethiopia', 'ET', 'ETH', '251', 1),
(68, 'Filipinas', 'Philippines', 'PH', 'PHL', '63', 1),
(69, 'Finlandia', 'Finland', 'FI', 'FIN', '358', 1),
(70, 'Fiyi', 'Fiji', 'FJ', 'FJI', '679', 1),
(71, 'Francia', 'France', 'FR', 'FRA', '33', 1),
(72, 'Gab', 'Gabon', 'GA', 'GAB', '241', 1),
(73, 'Gambia', 'Gambia', 'GM', 'GMB', '220', 1),
(74, 'Georgia', 'Georgia', 'GE', 'GEO', '995', 1),
(75, 'Ghana', 'Ghana', 'GH', 'GHA', '233', 1),
(76, 'Gibraltar', 'Gibraltar', 'GI', 'GIB', '350', 1),
(77, 'Granada', 'Grenada', 'GD', 'GRD', '1 47', 1),
(78, 'Grecia', 'Greece', 'GR', 'GRC', '30', 1),
(79, 'Groenlandia', 'Greenland', 'GL', 'GRL', '299', 1),
(80, 'Guadalupe', 'Guadeloupe', 'GP', 'GLP', '', 1),
(81, 'Guam', 'Guam', 'GU', 'GUM', '1 67', 1),
(82, 'Guatemala', 'Guatemala', 'GT', 'GTM', '502', 1),
(83, 'Guayana Francesa', 'French Guiana', 'GF', 'GUF', '', 1),
(84, 'Guernsey', 'Guernsey', 'GG', 'GGY', '', 1),
(85, 'Guinea', 'Guinea', 'GN', 'GIN', '224', 1),
(86, 'Guinea Ecuatorial', 'Equatorial Guinea', 'GQ', 'GNQ', '240', 1),
(87, 'Guinea-Bissau', 'Guinea-Bissau', 'GW', 'GNB', '245', 1),
(88, 'Guyana', 'Guyana', 'GY', 'GUY', '592', 1),
(89, 'Hait', 'Haiti', 'HT', 'HTI', '509', 1),
(90, 'Honduras', 'Honduras', 'HN', 'HND', '504', 1),
(91, 'Hong kong', 'Hong Kong', 'HK', 'HKG', '852', 1),
(92, 'Hungr', 'Hungary', 'HU', 'HUN', '36', 1),
(93, 'India', 'India', 'IN', 'IND', '91', 1),
(94, 'Indonesia', 'Indonesia', 'ID', 'IDN', '62', 1),
(95, 'Ir', 'Iran', 'IR', 'IRN', '98', 1),
(96, 'Irak', 'Iraq', 'IQ', 'IRQ', '964', 1),
(97, 'Irlanda', 'Ireland', 'IE', 'IRL', '353', 1),
(98, 'Isla Bouvet', 'Bouvet Island', 'BV', 'BVT', '', 1),
(99, 'Isla de Man', 'Isle of Man', 'IM', 'IMN', '44', 1),
(100, 'Isla de Navidad', 'Christmas Island', 'CX', 'CXR', '61', 1),
(101, 'Isla Norfolk', 'Norfolk Island', 'NF', 'NFK', '', 1),
(102, 'Islandia', 'Iceland', 'IS', 'ISL', '354', 1),
(103, 'Islas Bermudas', 'Bermuda Islands', 'BM', 'BMU', '1 44', 1),
(104, 'Islas Caim', 'Cayman Islands', 'KY', 'CYM', '1 34', 1),
(105, 'Islas Cocos (Keeling)', 'Cocos (Keeling) Islands', 'CC', 'CCK', '61', 1),
(106, 'Islas Cook', 'Cook Islands', 'CK', 'COK', '682', 1),
(107, 'Islas de ?land', '?land Islands', 'AX', 'ALA', '', 1),
(108, 'Islas Feroe', 'Faroe Islands', 'FO', 'FRO', '298', 1),
(109, 'Islas Georgias del Sur y Sandwich del Sur', 'South Georgia and the South Sandwich Islands', 'GS', 'SGS', '', 1),
(110, 'Islas Heard y McDonald', 'Heard Island and McDonald Islands', 'HM', 'HMD', '', 1),
(111, 'Islas Maldivas', 'Maldives', 'MV', 'MDV', '960', 1),
(112, 'Islas Malvinas', 'Falkland Islands (Malvinas)', 'FK', 'FLK', '500', 1),
(113, 'Islas Marianas del Norte', 'Northern Mariana Islands', 'MP', 'MNP', '1 67', 1),
(114, 'Islas Marshall', 'Marshall Islands', 'MH', 'MHL', '692', 1),
(115, 'Islas Pitcairn', 'Pitcairn Islands', 'PN', 'PCN', '870', 1),
(116, 'Islas Salom', 'Solomon Islands', 'SB', 'SLB', '677', 1),
(117, 'Islas Turcas y Caicos', 'Turks and Caicos Islands', 'TC', 'TCA', '1 64', 1),
(118, 'Islas Ultramarinas Menores de Estados Unidos', 'United States Minor Outlying Islands', 'UM', 'UMI', '', 1),
(119, 'Islas V?rgenes Brit?nicas', 'Virgin Islands', 'VG', 'VG', '1 28', 1),
(120, 'Islas V?rgenes de los Estados Unidos', 'United States Virgin Islands', 'VI', 'VIR', '1 34', 1),
(121, 'Israel', 'Israel', 'IL', 'ISR', '972', 1),
(122, 'Italia', 'Italy', 'IT', 'ITA', '39', 1),
(123, 'Jamaica', 'Jamaica', 'JM', 'JAM', '1 87', 1),
(124, 'Jap', 'Japan', 'JP', 'JPN', '81', 1),
(125, 'Jersey', 'Jersey', 'JE', 'JEY', '', 1),
(126, 'Jordania', 'Jordan', 'JO', 'JOR', '962', 1),
(127, 'Kazajist', 'Kazakhstan', 'KZ', 'KAZ', '7', 1),
(128, 'Kenia', 'Kenya', 'KE', 'KEN', '254', 1),
(129, 'Kirgizst', 'Kyrgyzstan', 'KG', 'KGZ', '996', 1),
(130, 'Kiribati', 'Kiribati', 'KI', 'KIR', '686', 1),
(131, 'Kuwait', 'Kuwait', 'KW', 'KWT', '965', 1),
(132, 'L?bano', 'Lebanon', 'LB', 'LBN', '961', 1),
(133, 'Laos', 'Laos', 'LA', 'LAO', '856', 1),
(134, 'Lesoto', 'Lesotho', 'LS', 'LSO', '266', 1),
(135, 'Letonia', 'Latvia', 'LV', 'LVA', '371', 1),
(136, 'Liberia', 'Liberia', 'LR', 'LBR', '231', 1),
(137, 'Libia', 'Libya', 'LY', 'LBY', '218', 1),
(138, 'Liechtenstein', 'Liechtenstein', 'LI', 'LIE', '423', 1),
(139, 'Lituania', 'Lithuania', 'LT', 'LTU', '370', 1),
(140, 'Luxemburgo', 'Luxembourg', 'LU', 'LUX', '352', 1),
(141, 'M?xico', 'Mexico', 'MX', 'MEX', '52', 1),
(142, 'M?naco', 'Monaco', 'MC', 'MCO', '377', 1),
(143, 'Macao', 'Macao', 'MO', 'MAC', '853', 1),
(144, 'Maced?nia', 'Macedonia', 'MK', 'MKD', '389', 1),
(145, 'Madagascar', 'Madagascar', 'MG', 'MDG', '261', 1),
(146, 'Malasia', 'Malaysia', 'MY', 'MYS', '60', 1),
(147, 'Malawi', 'Malawi', 'MW', 'MWI', '265', 1),
(148, 'Mali', 'Mali', 'ML', 'MLI', '223', 1),
(149, 'Malta', 'Malta', 'MT', 'MLT', '356', 1),
(150, 'Marruecos', 'Morocco', 'MA', 'MAR', '212', 1),
(151, 'Martinica', 'Martinique', 'MQ', 'MTQ', '', 1),
(152, 'Mauricio', 'Mauritius', 'MU', 'MUS', '230', 1),
(153, 'Mauritania', 'Mauritania', 'MR', 'MRT', '222', 1),
(154, 'Mayotte', 'Mayotte', 'YT', 'MYT', '262', 1),
(155, 'Micronesia', 'Estados Federados de', 'FM', 'FSM', '691', 1),
(156, 'Moldavia', 'Moldova', 'MD', 'MDA', '373', 1),
(157, 'Mongolia', 'Mongolia', 'MN', 'MNG', '976', 1),
(158, 'Montenegro', 'Montenegro', 'ME', 'MNE', '382', 1),
(159, 'Montserrat', 'Montserrat', 'MS', 'MSR', '1 66', 1),
(160, 'Mozambique', 'Mozambique', 'MZ', 'MOZ', '258', 1),
(161, 'Namibia', 'Namibia', 'NA', 'NAM', '264', 1),
(162, 'Nauru', 'Nauru', 'NR', 'NRU', '674', 1),
(163, 'Nepal', 'Nepal', 'NP', 'NPL', '977', 1),
(164, 'Nicaragua', 'Nicaragua', 'NI', 'NIC', '505', 1),
(165, 'Niger', 'Niger', 'NE', 'NER', '227', 1),
(166, 'Nigeria', 'Nigeria', 'NG', 'NGA', '234', 1),
(167, 'Niue', 'Niue', 'NU', 'NIU', '683', 1),
(168, 'Noruega', 'Norway', 'NO', 'NOR', '47', 1),
(169, 'Nueva Caledonia', 'New Caledonia', 'NC', 'NCL', '687', 1),
(170, 'Nueva Zelanda', 'New Zealand', 'NZ', 'NZL', '64', 1),
(171, 'Om', 'Oman', 'OM', 'OMN', '968', 1),
(172, 'Pa?ses Bajos', 'Netherlands', 'NL', 'NLD', '31', 1),
(173, 'Pakist', 'Pakistan', 'PK', 'PAK', '92', 1),
(174, 'Palau', 'Palau', 'PW', 'PLW', '680', 1),
(175, 'Palestina', 'Palestine', 'PS', 'PSE', '', 1),
(176, 'Panam', 'Panama', 'PA', 'PAN', '507', 1),
(177, 'Pap?a Nueva Guinea', 'Papua New Guinea', 'PG', 'PNG', '675', 1),
(178, 'Paraguay', 'Paraguay', 'PY', 'PRY', '595', 1),
(179, 'Per?', 'Peru', 'PE', 'PER', '51', 1),
(180, 'Polinesia Francesa', 'French Polynesia', 'PF', 'PYF', '689', 1),
(181, 'Polonia', 'Poland', 'PL', 'POL', '48', 1),
(182, 'Portugal', 'Portugal', 'PT', 'PRT', '351', 1),
(183, 'Puerto Rico', 'Puerto Rico', 'PR', 'PRI', '1', 1),
(184, 'Qatar', 'Qatar', 'QA', 'QAT', '974', 1),
(185, 'Reino Unido', 'United Kingdom', 'GB', 'GBR', '44', 1),
(186, 'Rep?blica Centroafricana', 'Central African Republic', 'CF', 'CAF', '236', 1),
(187, 'Rep?blica Checa', 'Czech Republic', 'CZ', 'CZE', '420', 1),
(188, 'Rep?blica Dominicana', 'Dominican Republic', 'DO', 'DOM', '1 80', 1),
(189, 'Reuni', 'R?union', 'RE', 'REU', '', 1),
(190, 'Ruanda', 'Rwanda', 'RW', 'RWA', '250', 1),
(191, 'Ruman', 'Romania', 'RO', 'ROU', '40', 1),
(192, 'Rusia', 'Russia', 'RU', 'RUS', '7', 1),
(193, 'Sahara Occidental', 'Western Sahara', 'EH', 'ESH', '', 1),
(194, 'Samoa', 'Samoa', 'WS', 'WSM', '685', 1),
(195, 'Samoa Americana', 'American Samoa', 'AS', 'ASM', '1 68', 1),
(196, 'San Bartolom', 'Saint Barth?lemy', 'BL', 'BLM', '590', 1),
(197, 'San Crist?bal y Nieves', 'Saint Kitts and Nevis', 'KN', 'KNA', '1 86', 1),
(198, 'San Marino', 'San Marino', 'SM', 'SMR', '378', 1),
(199, 'San Mart?n (Francia)', 'Saint Martin (French part)', 'MF', 'MAF', '1 59', 1),
(200, 'San Pedro y Miquel', 'Saint Pierre and Miquelon', 'PM', 'SPM', '508', 1),
(201, 'San Vicente y las Granadinas', 'Saint Vincent and the Grenadines', 'VC', 'VCT', '1 78', 1),
(202, 'Santa Elena', 'Ascensi?n y Trist?n de Acu', 'SH', 'SHN', '290', 1),
(203, 'Santa Luc', 'Saint Lucia', 'LC', 'LCA', '1 75', 1),
(204, 'Santo Tom? y Pr?ncipe', 'Sao Tome and Principe', 'ST', 'STP', '239', 1),
(205, 'Senegal', 'Senegal', 'SN', 'SEN', '221', 1),
(206, 'Serbia', 'Serbia', 'RS', 'SRB', '381', 1),
(207, 'Seychelles', 'Seychelles', 'SC', 'SYC', '248', 1),
(208, 'Sierra Leona', 'Sierra Leone', 'SL', 'SLE', '232', 1),
(209, 'Singapur', 'Singapore', 'SG', 'SGP', '65', 1),
(210, 'Siria', 'Syria', 'SY', 'SYR', '963', 1),
(211, 'Somalia', 'Somalia', 'SO', 'SOM', '252', 1),
(212, 'Sri lanka', 'Sri Lanka', 'LK', 'LKA', '94', 1),
(213, 'Sud?frica', 'South Africa', 'ZA', 'ZAF', '27', 1),
(214, 'Sud', 'Sudan', 'SD', 'SDN', '249', 1),
(215, 'Suecia', 'Sweden', 'SE', 'SWE', '46', 1),
(216, 'Suiza', 'Switzerland', 'CH', 'CHE', '41', 1),
(217, 'Surin', 'Suriname', 'SR', 'SUR', '597', 1),
(218, 'Svalbard y Jan Mayen', 'Svalbard and Jan Mayen', 'SJ', 'SJM', '', 1),
(219, 'Swazilandia', 'Swaziland', 'SZ', 'SWZ', '268', 1),
(220, 'Tadjikist', 'Tajikistan', 'TJ', 'TJK', '992', 1),
(221, 'Tailandia', 'Thailand', 'TH', 'THA', '66', 1),
(222, 'Taiw', 'Taiwan', 'TW', 'TWN', '886', 1),
(223, 'Tanzania', 'Tanzania', 'TZ', 'TZA', '255', 1),
(224, 'Territorio Brit?nico del Oc?ano ?ndico', 'British Indian Ocean Territory', 'IO', 'IOT', '', 1),
(225, 'Territorios Australes y Ant?rticas Franceses', 'French Southern Territories', 'TF', 'ATF', '', 1),
(226, 'Timor Oriental', 'East Timor', 'TL', 'TLS', '670', 1),
(227, 'Togo', 'Togo', 'TG', 'TGO', '228', 1),
(228, 'Tokelau', 'Tokelau', 'TK', 'TKL', '690', 1),
(229, 'Tonga', 'Tonga', 'TO', 'TON', '676', 1),
(230, 'Trinidad y Tobago', 'Trinidad and Tobago', 'TT', 'TTO', '1 86', 1),
(231, 'Tunez', 'Tunisia', 'TN', 'TUN', '216', 1),
(232, 'Turkmenist', 'Turkmenistan', 'TM', 'TKM', '993', 1),
(233, 'Turqu', 'Turkey', 'TR', 'TUR', '90', 1),
(234, 'Tuvalu', 'Tuvalu', 'TV', 'TUV', '688', 1),
(235, 'Ucrania', 'Ukraine', 'UA', 'UKR', '380', 1),
(236, 'Uganda', 'Uganda', 'UG', 'UGA', '256', 1),
(237, 'Uruguay', 'Uruguay', 'UY', 'URY', '598', 1),
(238, 'Uzbekist', 'Uzbekistan', 'UZ', 'UZB', '998', 1),
(239, 'Vanuatu', 'Vanuatu', 'VU', 'VUT', '678', 1),
(240, 'Venezuela', 'Venezuela', 'VE', 'VEN', '58', 1),
(241, 'Vietnam', 'Vietnam', 'VN', 'VNM', '84', 1),
(242, 'Wallis y Futuna', 'Wallis and Futuna', 'WF', 'WLF', '681', 1),
(243, 'Yemen', 'Yemen', 'YE', 'YEM', '967', 1),
(244, 'Yibuti', 'Djibouti', 'DJ', 'DJI', '253', 1),
(245, 'Zambia', 'Zambia', 'ZM', 'ZMB', '260', 1),
(246, 'Zimbabue', 'Zimbabwe', 'ZW', 'ZWE', '263', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_usuarios`
--

CREATE TABLE IF NOT EXISTS `lo_usuarios` (
  `us_codigousuario` varchar(13) NOT NULL,
  `us_login` varchar(20) NOT NULL,
  `us_password` varchar(255) NOT NULL,
  `us_rol` int(11) DEFAULT NULL,
  `us_estado` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `lo_usuarios`
--

INSERT INTO `lo_usuarios` (`us_codigousuario`, `us_login`, `us_password`, `us_rol`, `us_estado`) VALUES
('1US0000000001', 'CARLOSCUADRA', 'd459f0eabfd6ac680dacbfaadd1603e95faf3909de16b6db81fe9dfba53e8bce8df59db3a8ab9d0beb97cc9e81db', 2, 1),
('2US0000000001', 'juan.perez', 'd459f0eabfd6ac680dacbfaadd1603e95faf3909de16b6db81fe9dfba53e8bce8df59db3a8ab9d0beb97cc9e81db', 1, 1),
('3US0000000001', 'pedro.cuadra', 'd459f0eabfd6ac680dacbfaadd1603e95faf3909de16b6db81fe9dfba53e8bce8df59db3a8ab9d0beb97cc9e81db', 1, 1),
('4US0000000001', 'carlos.cuadra', 'd459f0eabfd6ac680dacbfaadd1603e95faf3909de16b6db81fe9dfba53e8bce8df59db3a8ab9d0beb97cc9e81db', 1, 1),
('5US0000000001', 'lesliemaria', 'd459f0eabfd6ac680dacbfaadd1603e95faf3909de16b6db81fe9dfba53e8bce8df59db3a8ab9d0beb97cc9e81db', 1, 1),
('6US0000000001', 'charlessv', 'd459f0eabfd6ac680dacbfaadd1603e95faf3909de16b6db81fe9dfba53e8bce8df59db3a8ab9d0beb97cc9e81db', 1, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `lo_clientes`
--
ALTER TABLE `lo_clientes`
 ADD PRIMARY KEY (`cl_idcliente`,`cl_idempresa`), ADD UNIQUE KEY `cl_num_documento_UNIQUE` (`cl_num_documento`), ADD UNIQUE KEY `cl_nit_UNIQUE` (`cl_nit`);

--
-- Indices de la tabla `lo_departamento`
--
ALTER TABLE `lo_departamento`
 ADD PRIMARY KEY (`de_iddepartamento`,`de_descripcion`,`de_idpais`);

--
-- Indices de la tabla `lo_detallelotes`
--
ALTER TABLE `lo_detallelotes`
 ADD PRIMARY KEY (`dt_idlote`);

--
-- Indices de la tabla `lo_detallepago`
--
ALTER TABLE `lo_detallepago`
 ADD PRIMARY KEY (`dp_idpago`,`dp_iddetpago`);

--
-- Indices de la tabla `lo_empresa`
--
ALTER TABLE `lo_empresa`
 ADD PRIMARY KEY (`em_idempresa`,`em_nombre`);

--
-- Indices de la tabla `lo_funcionarios`
--
ALTER TABLE `lo_funcionarios`
 ADD PRIMARY KEY (`fu_idfuncionario`,`fu_empresa`), ADD UNIQUE KEY `fu_email_UNIQUE` (`fu_email`);

--
-- Indices de la tabla `lo_lotes`
--
ALTER TABLE `lo_lotes`
 ADD PRIMARY KEY (`lt_idlote`,`lt_idlotificacion`,`lt_poligono`);

--
-- Indices de la tabla `lo_lotificacion`
--
ALTER TABLE `lo_lotificacion`
 ADD PRIMARY KEY (`lo_idlotificacion`,`lo_empresa`,`lo_nombre`);

--
-- Indices de la tabla `lo_municipios`
--
ALTER TABLE `lo_municipios`
 ADD PRIMARY KEY (`mu_idmunicipio`,`mu_descripcion`,`mu_iddepartamento`);

--
-- Indices de la tabla `lo_pagos`
--
ALTER TABLE `lo_pagos`
 ADD PRIMARY KEY (`pa_factura`,`pa_estado`,`pa_fecha`);

--
-- Indices de la tabla `lo_pais`
--
ALTER TABLE `lo_pais`
 ADD PRIMARY KEY (`pa_pais`,`pa_descripcionesp`,`pa_iso2`), ADD UNIQUE KEY `pa_iso_UNIQUE` (`pa_iso2`), ADD UNIQUE KEY `pa_descripcion_UNIQUE` (`pa_descripcionesp`);

--
-- Indices de la tabla `lo_usuarios`
--
ALTER TABLE `lo_usuarios`
 ADD PRIMARY KEY (`us_codigousuario`), ADD UNIQUE KEY `us_login_UNIQUE` (`us_login`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `lo_departamento`
--
ALTER TABLE `lo_departamento`
MODIFY `de_iddepartamento` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `lo_empresa`
--
ALTER TABLE `lo_empresa`
MODIFY `em_idempresa` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `lo_municipios`
--
ALTER TABLE `lo_municipios`
MODIFY `mu_idmunicipio` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT de la tabla `lo_pais`
--
ALTER TABLE `lo_pais`
MODIFY `pa_pais` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=247;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
