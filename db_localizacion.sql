-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: db_localizacion
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu0.16.04.1

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
-- Table structure for table `Cola_Viajes`
--

DROP TABLE IF EXISTS `Cola_Viajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cola_Viajes` (
  `id_cola_Viajes` int(11) NOT NULL AUTO_INCREMENT,
  `ci_persona` varchar(45) DEFAULT NULL,
  `id_viaje` int(11) DEFAULT NULL,
  `id_estado` int(11) DEFAULT NULL,
  UNIQUE KEY `id_cola_Viajes_UNIQUE` (`id_cola_Viajes`),
  KEY `fk_Cola_Viajes_1_idx` (`ci_persona`),
  KEY `fk_Cola_Viajes_2_idx` (`id_estado`),
  KEY `fk_Cola_Viajes_3_idx` (`id_viaje`),
  CONSTRAINT `fk_Cola_Viajes_1` FOREIGN KEY (`ci_persona`) REFERENCES `Personas` (`ci`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cola_Viajes_2` FOREIGN KEY (`id_estado`) REFERENCES `Estados` (`id_estado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cola_Viajes_3` FOREIGN KEY (`id_viaje`) REFERENCES `Viajes` (`id_viaje`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cola_Viajes`
--

LOCK TABLES `Cola_Viajes` WRITE;
/*!40000 ALTER TABLE `Cola_Viajes` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cola_Viajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Estados`
--

DROP TABLE IF EXISTS `Estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Estados` (
  `id_estado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  UNIQUE KEY `id_estados_UNIQUE` (`id_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Estados`
--

LOCK TABLES `Estados` WRITE;
/*!40000 ALTER TABLE `Estados` DISABLE KEYS */;
/*!40000 ALTER TABLE `Estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Personas`
--

DROP TABLE IF EXISTS `Personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Personas` (
  `id_persona` int(11) NOT NULL AUTO_INCREMENT,
  `ci` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `id_role` int(11) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`ci`),
  UNIQUE KEY `id_persona_UNIQUE` (`id_persona`),
  KEY `fk_Personas_1_idx` (`id_role`),
  CONSTRAINT `fk_Personas_1` FOREIGN KEY (`id_role`) REFERENCES `Roles` (`id_role`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Personas`
--

LOCK TABLES `Personas` WRITE;
/*!40000 ALTER TABLE `Personas` DISABLE KEYS */;
INSERT INTO `Personas` VALUES (4,'4760748','Juan','Vargas','juan@localizacion',1,'12345');
/*!40000 ALTER TABLE `Personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Posiciones`
--

DROP TABLE IF EXISTS `Posiciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Posiciones` (
  `id_posicion` int(11) NOT NULL AUTO_INCREMENT,
  `ci_persona` varchar(45) DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `latitud` varchar(45) NOT NULL,
  `longitud` varchar(45) NOT NULL,
  UNIQUE KEY `id_posiciones_UNIQUE` (`id_posicion`),
  KEY `fk_Posiciones_1_idx` (`ci_persona`),
  CONSTRAINT `fk_Posiciones_1` FOREIGN KEY (`ci_persona`) REFERENCES `Personas` (`ci`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Posiciones`
--

LOCK TABLES `Posiciones` WRITE;
/*!40000 ALTER TABLE `Posiciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `Posiciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Posiciones_Viajes`
--

DROP TABLE IF EXISTS `Posiciones_Viajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Posiciones_Viajes` (
  `id_pos_viaje` int(11) NOT NULL AUTO_INCREMENT,
  `id_viaje` int(11) NOT NULL,
  `id_posicion` int(11) NOT NULL,
  UNIQUE KEY `id_pos_viaje_UNIQUE` (`id_pos_viaje`),
  KEY `fk_Posiciones_Viajes_1_idx` (`id_posicion`),
  KEY `fk_Posiciones_Viajes_2_idx` (`id_viaje`),
  CONSTRAINT `fk_Posiciones_Viajes_1` FOREIGN KEY (`id_posicion`) REFERENCES `Posiciones` (`id_posicion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Posiciones_Viajes_2` FOREIGN KEY (`id_viaje`) REFERENCES `Viajes` (`id_viaje`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Posiciones_Viajes`
--

LOCK TABLES `Posiciones_Viajes` WRITE;
/*!40000 ALTER TABLE `Posiciones_Viajes` DISABLE KEYS */;
/*!40000 ALTER TABLE `Posiciones_Viajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Roles` (
  `id_role` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_role`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
INSERT INTO `Roles` VALUES (1,'ROLE_USER','Usuario comun!');
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Viajes`
--

DROP TABLE IF EXISTS `Viajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Viajes` (
  `id_viaje` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_limite` date DEFAULT NULL,
  `tiempo_estimado` time DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `kilometros` int(11) DEFAULT NULL,
  UNIQUE KEY `id_viaje_UNIQUE` (`id_viaje`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Viajes`
--

LOCK TABLES `Viajes` WRITE;
/*!40000 ALTER TABLE `Viajes` DISABLE KEYS */;
/*!40000 ALTER TABLE `Viajes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-29 20:00:20
