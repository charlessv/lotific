CREATE DATABASE  IF NOT EXISTS `dblotificaciones` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dblotificaciones`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: dblotificaciones
-- ------------------------------------------------------
-- Server version	5.6.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `lo_clientes`
--

DROP TABLE IF EXISTS `lo_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_clientes` (
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
  `cl_estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`cl_idcliente`,`cl_idempresa`),
  UNIQUE KEY `cl_num_documento_UNIQUE` (`cl_num_documento`),
  UNIQUE KEY `cl_nit_UNIQUE` (`cl_nit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_clientes`
--

LOCK TABLES `lo_clientes` WRITE;
/*!40000 ALTER TABLE `lo_clientes` DISABLE KEYS */;
INSERT INTO `lo_clientes` VALUES ('0000000001',1,'Carlos','Alberto','Cuadra','Serrano','Carlos Alberto Cuadra Serrano','02672789-0','0614-260481-115-6','',12,4,1,'7450-4858','7450-4850','','carlos.cuadra@outlook.com','2015-01-22 19:24:54',1),('0000000001',5,'Leslie','Maria','Martinez','Enamorado','Leslie Maria Martinez Enamorado','21212121-2','1212-112121-211-1','',11,4,1,'1131-2312','3123-1231','','leslie.maria@hotmail.com','2015-04-10 04:52:24',1),('0000000002',1,'Juan','','Perez','','Juan  Perez ','22222222-2','2222-222222-222-2','',NULL,NULL,1,'1111-1111','1111-1111','','juan.perez@outlook.com','2015-01-22 19:36:17',1),('0000000003',1,'Juan','Alberto','Portillo','','Juan Alberto Portillo ','40404040-4','4404-040400-404-0','San Sivar',1,3,1,'3232-2332','','','juanportillo@gmail.com','2015-01-30 20:40:28',1);
/*!40000 ALTER TABLE `lo_clientes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger trggBeforeInsertLo_Clientes before insert on lo_clientes FOR EACH ROW
begin
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
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `lo_departamento`
--

DROP TABLE IF EXISTS `lo_departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_departamento` (
  `de_iddepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `de_descripcion` varchar(100) NOT NULL,
  `de_idpais` int(11) NOT NULL,
  `de_estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`de_iddepartamento`,`de_descripcion`,`de_idpais`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_departamento`
--

LOCK TABLES `lo_departamento` WRITE;
/*!40000 ALTER TABLE `lo_departamento` DISABLE KEYS */;
INSERT INTO `lo_departamento` VALUES (3,'San Salvador',1,1),(4,'San Miguel',1,1),(5,'Santa Ana',1,1);
/*!40000 ALTER TABLE `lo_departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lo_detallelotes`
--

DROP TABLE IF EXISTS `lo_detallelotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_detallelotes` (
  `dt_idlote` int(11) NOT NULL,
  `dt_poligono` varchar(2) DEFAULT NULL,
  `dt_idlotificacion` int(11) DEFAULT NULL,
  `dt_idcliente` int(11) DEFAULT NULL,
  `dt_plazo` int(11) DEFAULT NULL,
  `dt_fechaventa` datetime DEFAULT NULL,
  `dt_fechaultimopago` datetime DEFAULT NULL,
  `dt_interes` double DEFAULT NULL,
  `dt_prima` double DEFAULT NULL,
  `dt_cuota` double DEFAULT NULL,
  PRIMARY KEY (`dt_idlote`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_detallelotes`
--

LOCK TABLES `lo_detallelotes` WRITE;
/*!40000 ALTER TABLE `lo_detallelotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `lo_detallelotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lo_detallepago`
--

DROP TABLE IF EXISTS `lo_detallepago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_detallepago` (
  `dp_idpago` int(11) NOT NULL,
  `dp_iddetpago` int(11) NOT NULL,
  `dp_capital` double DEFAULT NULL,
  `dp_interes` double DEFAULT NULL,
  `dp_iva` double DEFAULT NULL,
  `dp_prima` double DEFAULT NULL,
  `dp_mora` datetime DEFAULT NULL,
  PRIMARY KEY (`dp_idpago`,`dp_iddetpago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_detallepago`
--

LOCK TABLES `lo_detallepago` WRITE;
/*!40000 ALTER TABLE `lo_detallepago` DISABLE KEYS */;
/*!40000 ALTER TABLE `lo_detallepago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lo_empresa`
--

DROP TABLE IF EXISTS `lo_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_empresa` (
  `em_idempresa` int(11) NOT NULL AUTO_INCREMENT,
  `em_nombre` varchar(100) NOT NULL,
  `em_fecharegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `em_pais` int(11) DEFAULT NULL,
  `em_departamento` int(11) DEFAULT NULL,
  `em_municipio` int(11) DEFAULT NULL,
  `em_direccion` varchar(255) DEFAULT NULL,
  `em_estado` tinyint(1) DEFAULT '1',
  `em_codigoverificacion` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`em_idempresa`,`em_nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_empresa`
--

LOCK TABLES `lo_empresa` WRITE;
/*!40000 ALTER TABLE `lo_empresa` DISABLE KEYS */;
INSERT INTO `lo_empresa` VALUES (1,'LOTIVERSA','2015-01-27 20:58:43',1,3,1,'ss',1,'19LE00036'),(2,'Provivienda','2015-01-27 21:00:55',1,3,1,'SS',1,'111PE00044'),(3,'La Alcancia S.A','2015-01-30 22:22:07',1,3,1,'Colonia Escalon',1,'215LE00060'),(4,'ProTierra','2015-01-30 22:39:04',1,3,1,'San Salvador',1,'39PE00036'),(5,'Panaderia El Rosario','2015-04-10 04:46:33',1,3,1,'Prueba',1,'420PE00080'),(6,'Lotificaciones Pamplona','2016-07-17 03:56:03',1,3,1,'Pamplona',1,'523LE00092');
/*!40000 ALTER TABLE `lo_empresa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger trggBeforeInsertLo_empresa before insert on lo_empresa FOR EACH ROW
begin
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
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `lo_funcionarios`
--

DROP TABLE IF EXISTS `lo_funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_funcionarios` (
  `fu_idfuncionario` varchar(13) NOT NULL,
  `fu_pnombre` varchar(50) NOT NULL,
  `fu_snombre` varchar(50) DEFAULT NULL,
  `fu_papellido` varchar(50) NOT NULL,
  `fu_spellido` varchar(50) DEFAULT NULL,
  `fu_numdocumento` varchar(10) DEFAULT NULL,
  `fu_empresa` int(11) NOT NULL,
  `fu_email` varchar(45) NOT NULL,
  `fu_estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`fu_idfuncionario`,`fu_empresa`),
  UNIQUE KEY `fu_email_UNIQUE` (`fu_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_funcionarios`
--

LOCK TABLES `lo_funcionarios` WRITE;
/*!40000 ALTER TABLE `lo_funcionarios` DISABLE KEYS */;
INSERT INTO `lo_funcionarios` VALUES ('1US0000000001','CARLOS','ALBERTO','CUADRA','SERRANO','33333333-3',1,'carloscuadra@gmail.com',1),('2US0000000001','Juan','','Perez','','11111111-1',2,'juanperez@gmail.com',1),('3US0000000001','Pedro','Alberto','Cuadra','Benavides','91923922-9',3,'pedro.cuadra@outlook.com',1),('4US0000000001','Carlos','','Cuadra','','40404040-4',4,'carlos.cuadra@hotmail.com',1),('5US0000000001','Leslie','Maria','Martinez','Enamorado','11111111-1',5,'leslie.enamorado@elrosario.com',1),('6US0000000001','Carlos','Alberto','Cuadra','Serrano','02672789-0',6,'carlos.cuadra@outlook.com',1);
/*!40000 ALTER TABLE `lo_funcionarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger trggBeforeInsertLo_funcionarios before insert on lo_funcionarios FOR EACH ROW
begin
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
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `lo_lotes`
--

DROP TABLE IF EXISTS `lo_lotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_lotes` (
  `lt_idlote` int(11) NOT NULL,
  `lt_idlotificacion` int(11) NOT NULL,
  `lt_poligono` varchar(3) NOT NULL,
  `lt_area` double DEFAULT '0',
  `lt_precio` double DEFAULT '0',
  `lt_estado` char(1) DEFAULT 'V',
  PRIMARY KEY (`lt_idlote`,`lt_idlotificacion`,`lt_poligono`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_lotes`
--

LOCK TABLES `lo_lotes` WRITE;
/*!40000 ALTER TABLE `lo_lotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `lo_lotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lo_lotificacion`
--

DROP TABLE IF EXISTS `lo_lotificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_lotificacion` (
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
  `lo_estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`lo_idlotificacion`,`lo_empresa`,`lo_nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_lotificacion`
--

LOCK TABLES `lo_lotificacion` WRITE;
/*!40000 ALTER TABLE `lo_lotificacion` DISABLE KEYS */;
INSERT INTO `lo_lotificacion` VALUES ('1LO0000000001',1,'Lotificación El Manguito','Juan Perez','San Salvador',1,3,1,0,NULL,1),('1LO0000000002',1,'Lotificación Las Flores','Juan Perez','San Miguel',1,4,11,0,NULL,1),('1LO0000000003',1,'Lotificación Las Dunas','Juan Perez','Chalchuapa',1,5,16,0,NULL,1),('1LO0000000004',1,'Lotificacion Santo Tomas','Juan Perez Sosa','Soyajevo',1,3,1,0,NULL,1),('1LO0000000005',1,'Lotificacion La Providencia','Juan Perez','Canton las Lomas',1,4,14,250.1,30,1),('1LO0000000006',1,'Prueba','Prueba','',NULL,NULL,NULL,NULL,NULL,1),('1LO0000000007',1,'Lotificacion la Manzana','Carlos Cuadra','Prueba',1,3,1,2000,NULL,1),('1LO0000000008',1,'Lotificacion la Manzana1','Carlos Cuadra','Prueba',1,3,3,2000,NULL,1),('1LO0000000009',1,'Prueba2','Prueba','',1,3,4,2000,NULL,1),('1LO0000000010',1,'Prueba4','prueba4','asfa',1,3,1,400,NULL,1),('1LO0000000011',1,'AFDASFD','jUAN PEREZ','',NULL,NULL,NULL,NULL,NULL,1),('2LO0000000001',2,'Lotificación El Manguito','Juan Perez','San Rafael ',1,4,14,400,100,1);
/*!40000 ALTER TABLE `lo_lotificacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger trggBeforeInsertLo_Lotificaciones before insert on lo_lotificacion FOR EACH ROW
begin
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
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `lo_municipios`
--

DROP TABLE IF EXISTS `lo_municipios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_municipios` (
  `mu_idmunicipio` int(11) NOT NULL AUTO_INCREMENT,
  `mu_descripcion` varchar(100) NOT NULL,
  `mu_iddepartamento` int(11) NOT NULL,
  `mu_estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`mu_idmunicipio`,`mu_descripcion`,`mu_iddepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_municipios`
--

LOCK TABLES `lo_municipios` WRITE;
/*!40000 ALTER TABLE `lo_municipios` DISABLE KEYS */;
INSERT INTO `lo_municipios` VALUES (1,'San Salvador',3,1),(2,'Soyapango',3,1),(3,'Ilopango',3,1),(4,'San Martin',3,1),(5,'Aguilares',3,1),(6,'San Marcos',3,1),(7,'Santo Tomas',3,1),(8,'Apopa',3,1),(9,'Mejicanos',3,1),(10,'Carolina',4,1),(11,'San Miguel',4,1),(12,'Chinameca',4,1),(13,'Lolotique',4,1),(14,'San Rafael Oriente',4,1),(15,'Metapan',5,1),(16,'Santa Ana',5,1),(17,'Coatepeque',5,1),(18,'El Congo',5,1);
/*!40000 ALTER TABLE `lo_municipios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lo_pagos`
--

DROP TABLE IF EXISTS `lo_pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_pagos` (
  `pa_idpago` int(11) NOT NULL,
  `pa_factura` varchar(15) NOT NULL,
  `pa_idcliente` int(11) DEFAULT NULL,
  `pa_fecha` datetime NOT NULL,
  `pa_valor` double DEFAULT NULL,
  `pa_estado` char(1) NOT NULL,
  PRIMARY KEY (`pa_factura`,`pa_estado`,`pa_fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_pagos`
--

LOCK TABLES `lo_pagos` WRITE;
/*!40000 ALTER TABLE `lo_pagos` DISABLE KEYS */;
/*!40000 ALTER TABLE `lo_pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lo_pais`
--

DROP TABLE IF EXISTS `lo_pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_pais` (
  `pa_pais` int(11) NOT NULL AUTO_INCREMENT,
  `pa_descripcionesp` varchar(100) NOT NULL,
  `pa_descripcioneng` varchar(100) DEFAULT NULL,
  `pa_iso2` varchar(3) NOT NULL,
  `pa_iso3` varchar(3) DEFAULT NULL,
  `pa_codigotelefono` varchar(4) DEFAULT NULL,
  `pa_estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`pa_pais`,`pa_descripcionesp`,`pa_iso2`),
  UNIQUE KEY `pa_iso_UNIQUE` (`pa_iso2`),
  UNIQUE KEY `pa_descripcion_UNIQUE` (`pa_descripcionesp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_pais`
--

LOCK TABLES `lo_pais` WRITE;
/*!40000 ALTER TABLE `lo_pais` DISABLE KEYS */;
/*!40000 ALTER TABLE `lo_pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lo_usuarios`
--

DROP TABLE IF EXISTS `lo_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_usuarios` (
  `us_codigousuario` varchar(13) NOT NULL,
  `us_login` varchar(20) NOT NULL,
  `us_password` varchar(255) NOT NULL,
  `us_rol` int(11) DEFAULT NULL,
  `us_estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`us_codigousuario`),
  UNIQUE KEY `us_login_UNIQUE` (`us_login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_usuarios`
--

LOCK TABLES `lo_usuarios` WRITE;
/*!40000 ALTER TABLE `lo_usuarios` DISABLE KEYS */;
INSERT INTO `lo_usuarios` VALUES ('1US0000000001','CARLOSCUADRA','d459f0eabfd6ac680dacbfaadd1603e95faf3909de16b6db81fe9dfba53e8bce8df59db3a8ab9d0beb97cc9e81db',2,1),('2US0000000001','juan.perez','d459f0eabfd6ac680dacbfaadd1603e95faf3909de16b6db81fe9dfba53e8bce8df59db3a8ab9d0beb97cc9e81db',1,1),('3US0000000001','pedro.cuadra','d459f0eabfd6ac680dacbfaadd1603e95faf3909de16b6db81fe9dfba53e8bce8df59db3a8ab9d0beb97cc9e81db',1,1),('4US0000000001','carlos.cuadra','d459f0eabfd6ac680dacbfaadd1603e95faf3909de16b6db81fe9dfba53e8bce8df59db3a8ab9d0beb97cc9e81db',1,1),('5US0000000001','lesliemaria','d459f0eabfd6ac680dacbfaadd1603e95faf3909de16b6db81fe9dfba53e8bce8df59db3a8ab9d0beb97cc9e81db',1,1),('6US0000000001','charlessv','d459f0eabfd6ac680dacbfaadd1603e95faf3909de16b6db81fe9dfba53e8bce8df59db3a8ab9d0beb97cc9e81db',1,1);
/*!40000 ALTER TABLE `lo_usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-25  7:16:41
