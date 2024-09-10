-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: invitaciones_boda
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `asistencias`
--

DROP TABLE IF EXISTS `asistencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_invitacion` int NOT NULL,
  `fecha_hora` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Table ''invitaciones_boda.asistencias'' doesn''t exist in engine';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencias`
--

LOCK TABLES `asistencias` WRITE;
/*!40000 ALTER TABLE `asistencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `asistencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boda`
--

DROP TABLE IF EXISTS `boda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boda` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `cantidad_invitados` int NOT NULL,
  `nombre_novia` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nombre_novio` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mensaje_bienvenida` text COLLATE utf8mb4_general_ci,
  `code` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12102025 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Table ''invitaciones_boda.boda'' doesn''t exist in engine';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boda`
--

LOCK TABLES `boda` WRITE;
/*!40000 ALTER TABLE `boda` DISABLE KEYS */;
INSERT INTO `boda` VALUES (12102024,'2024-10-12',200,'Lisbeth','Isaac','Queremos que seas parte de este día especial.','IL12');
/*!40000 ALTER TABLE `boda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hora` time DEFAULT NULL,
  `lugar_nombre` text COLLATE utf8mb4_general_ci,
  `direccion` text COLLATE utf8mb4_general_ci,
  `maps` text COLLATE utf8mb4_general_ci,
  `id_boda` int DEFAULT NULL,
  `tipo` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Table ''invitaciones_boda.evento'' doesn''t exist in engine';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (1,'13:00:00','Salon del Reino de los Testigos de Jehová',NULL,NULL,12102024,'Discurso Biblico'),(2,'17:30:00','Luxor Eventos & Convenciones','Av. Pairumani, Esq. Calle 1',NULL,12102024,'Recepción');
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invitaciones`
--

DROP TABLE IF EXISTS `invitaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invitaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(4) COLLATE utf8mb4_general_ci NOT NULL,
  `id_boda` int NOT NULL,
  `estado` enum('pendiente','confirmado','rechazado') COLLATE utf8mb4_general_ci DEFAULT 'pendiente',
  `nombre` text COLLATE utf8mb4_general_ci,
  `contacto` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `invitado` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Table ''invitaciones_boda.invitaciones'' doesn''t exist in engine';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invitaciones`
--

LOCK TABLES `invitaciones` WRITE;
/*!40000 ALTER TABLE `invitaciones` DISABLE KEYS */;
INSERT INTO `invitaciones` VALUES (5,'EL11',12102024,'pendiente','Flia. Ugarte','',0),(6,'ES11',12102024,'pendiente','Flia. Ugarte',NULL,0),(7,'EN11',12102024,'pendiente','Flia. Ugarte',NULL,0),(8,'FJ33',12102024,'pendiente','Flia. Ugarte',NULL,0),(9,'DE11',12102024,'pendiente','Flia. Ugarte',NULL,0),(10,'RE11',12102024,'pendiente','Flia. Ugarte',NULL,0),(11,'JA41',12102024,'pendiente','Flia. Amurrio',NULL,0),(12,'JK21',12102024,'pendiente','Flia. Mendoza',NULL,0),(13,'MV11',12102024,'pendiente','Flia. Crespo',NULL,0),(14,'MS11',12102024,'pendiente','Flia. Alanes',NULL,0),(15,'AD31',12102024,'pendiente','Flia. Alanes','68541055',0),(16,'HA31',12102024,'pendiente','Flia. Mamani',NULL,0),(17,'PJ11',12102024,'pendiente','Patricia y Jesus',NULL,0),(18,'PS21',12102024,'pendiente','Flia. Alanes',NULL,0),(19,'FF11',12102024,'pendiente','Flia. Quiroz',NULL,0),(20,'FR11',12102024,'pendiente','Francisca',NULL,0),(21,'SF11',12102024,'pendiente','Flia. Mamani',NULL,0),(22,'AE11',12102024,'pendiente','Flia. Mamani',NULL,0),(23,'RA11',12102024,'pendiente','Flia. Mamani',NULL,0),(24,'CM11',12102024,'pendiente','Flia. Mamani',NULL,0),(25,'AR11',12102024,'pendiente','Ariel',NULL,0),(26,'FN11',12102024,'pendiente','Flia. Vargas',NULL,0),(27,'EF11',12102024,'pendiente','Flia. Cabrera',NULL,0),(28,'SD11',12102024,'pendiente','Samuel y Deysi',NULL,0),(29,'JT31',12102024,'pendiente','Flia. Ramos',NULL,0),(30,'LA11',12102024,'pendiente','Flia. Escalera',NULL,0),(31,'PI11',12102024,'pendiente','Flia. Benegas',NULL,0),(32,'AJ21',12102024,'pendiente','Flia. Figueroa',NULL,0),(33,'DY21',12102024,'pendiente','Flia. Ruiz',NULL,0),(34,'JJ11',12102024,'pendiente','Flia. Arrosquipa',NULL,0),(35,'NC31',12102024,'pendiente','Flia. Guzman',NULL,0),(36,'MI31',12102024,'pendiente','Flia. Velasco',NULL,0),(37,'MR16',12102024,'pendiente','Marina',NULL,0),(38,'MA24',12102024,'pendiente','Maria',NULL,0),(39,'MQ11',12102024,'pendiente','Miqueas',NULL,0),(40,'EV11',12102024,'pendiente','Edgar y Virginia',NULL,0),(41,'LW21',12102024,'pendiente','Flia. Ugarte',NULL,0),(42,'TF11',12102024,'pendiente','Flia. Terceros',NULL,0),(43,'VP11',12102024,'pendiente','Flia. Villca',NULL,0),(44,'AV11',12102024,'pendiente','Flia. Aranda',NULL,0),(45,'AN11',12102024,'pendiente','Anghy',NULL,0),(46,'VR21',12102024,'pendiente','Flia. Ricaldez',NULL,0),(47,'JI11',12102024,'pendiente','Flia. Moreira',NULL,0),(48,'ER11',12102024,'pendiente','Flia. Gomez',NULL,0),(49,'MC21',12102024,'pendiente','Flia. Michel',NULL,0),(50,'RE12',12102024,'pendiente','Ruth Escalera',NULL,0),(51,'RM11',12102024,'pendiente','Rodrigo Muruchi',NULL,0),(52,'MA12',12102024,'pendiente','Flia. OKragly',NULL,0),(53,'RK11',12102024,'pendiente','Flia. Benitez',NULL,0),(54,'GC11',12102024,'pendiente','Grover',NULL,0),(55,'IM31',12102024,'pendiente','Flia. Herrera','77404206',0),(56,'OM31',12102024,'confirmado','Flia. Mareño','73788142',1),(57,'MR32',12102024,'pendiente','Flia. Mareño',NULL,0),(58,'NH21',12102024,'pendiente','Flia. Mareño',NULL,0),(59,'CR21',12102024,'pendiente','Flia. Solis',NULL,0),(60,'DA11',12102024,'confirmado','Daniel','67486877',0),(61,'RQ21',12102024,'pendiente','Flia. Requena',NULL,0),(62,'DK11',12102024,'pendiente','Flia. Ovando',NULL,0),(63,'TE11',12102024,'pendiente','Teofilo',NULL,0),(64,'GM21',12102024,'pendiente','Flia. Flores',NULL,0),(65,'AV21',12102024,'pendiente','Flia. Salazar',NULL,0),(66,'HW31',12102024,'pendiente','Flia. Huaywa',NULL,0),(67,'FC11',12102024,'pendiente','Felicidad Cruz',NULL,0),(68,'IL21',12102024,'pendiente','Flia. Inochea',NULL,0),(69,'FA11',12102024,'pendiente','Flia. Moller',NULL,0),(70,'LJ11',12102024,'pendiente','Flia. Ramos',NULL,0),(71,'EJ21',12102024,'pendiente','Flia. Guzman',NULL,0),(72,'MM32',12102024,'pendiente','Flia. Rioja','60765243',1),(73,'NO11',12102024,'pendiente','Flia. Contreras','60340944',1),(74,'HM21',12102024,'pendiente','Flia. Mamani',NULL,0),(75,'ME11',12102024,'pendiente','Flia. Tribeño',NULL,0),(76,'AW21',12102024,'pendiente','Flia. Jallaza',NULL,0),(77,'CO11',12102024,'pendiente','Corina',NULL,0),(78,'LU11',12102024,'pendiente','Luciana',NULL,0),(79,'EM11',12102024,'pendiente','Esther Mamani',NULL,0),(80,'AR23',12102024,'pendiente','Flia. Adriazola',NULL,0),(81,'MH11',12102024,'pendiente','Martha Herrera',NULL,0),(82,'LA21',12102024,'pendiente','Flia. Herrera',NULL,0),(83,'AJ12',12102024,'pendiente','Flia. Mendoza',NULL,0),(84,'AM11',12102024,'pendiente','Ana y Monica',NULL,0),(85,'AE21',12102024,'pendiente','Flia. Mareño',NULL,0),(86,'JU11',12102024,'pendiente','Judith',NULL,0),(94,'ER47',12102024,'pendiente','Flia. Alanes',NULL,0),(95,'FC44',12102024,'pendiente','Flia. Cruz',NULL,0),(96,'MR61',12102024,'pendiente','Flia. Miranda',NULL,0),(97,'AL86',12102024,'pendiente','Ailin Berdugo',NULL,0),(98,'MY78',12102024,'pendiente','Myroslava',NULL,0),(99,'SF34',12102024,'pendiente','Flia. Salinas',NULL,0),(100,'GR63',12102024,'pendiente','Flia. Giordano',NULL,0),(101,'DS11',12102024,'pendiente','David Soto',NULL,0);
/*!40000 ALTER TABLE `invitaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `id_invitacion` int DEFAULT NULL,
  `tipo` enum('principal','reserva') COLLATE utf8mb4_general_ci DEFAULT 'principal',
  `estado` enum('pendiente','confirmado','rechazado') COLLATE utf8mb4_general_ci DEFAULT 'pendiente',
  `id_boda` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Table ''invitaciones_boda.personas'' doesn''t exist in engine';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (10,'Edwin',5,'principal','pendiente',12102024),(11,'Lizeth',5,'principal','pendiente',12102024),(12,'Eloy',6,'principal','pendiente',12102024),(13,'Sonia',6,'principal','pendiente',12102024),(14,'Esteban',7,'principal','pendiente',12102024),(15,'Nora',7,'principal','pendiente',12102024),(16,'Felix',8,'principal','pendiente',12102024),(17,'Jacinta',8,'principal','pendiente',12102024),(18,'Isabel',8,'principal','pendiente',12102024),(19,'Neida',8,'principal','pendiente',12102024),(20,'Veimar',8,'principal','pendiente',12102024),(21,'Alexander',8,'principal','pendiente',12102024),(22,'Diego',9,'principal','pendiente',12102024),(23,'Eli',9,'principal','pendiente',12102024),(24,'Roberto',10,'principal','pendiente',12102024),(25,'Elena',10,'principal','pendiente',12102024),(26,'Javier',11,'principal','pendiente',12102024),(27,'Arminda',11,'principal','pendiente',12102024),(28,'Daniela',11,'principal','pendiente',12102024),(29,'Joaquin',11,'principal','pendiente',12102024),(30,'Cesar',11,'principal','pendiente',12102024),(31,'Jose L.',12,'principal','pendiente',12102024),(32,'Florinda',12,'principal','pendiente',12102024),(33,'Keyli',12,'principal','pendiente',12102024),(34,'Mario',13,'principal','pendiente',12102024),(35,'Victoria',13,'principal','pendiente',12102024),(36,'Martin',14,'principal','pendiente',12102024),(37,'Sabina',14,'principal','pendiente',12102024),(38,'Alejo',15,'principal','pendiente',12102024),(39,'Delia',15,'principal','pendiente',12102024),(41,'Ailed',15,'principal','pendiente',12102024),(42,'Hilarion',16,'principal','pendiente',12102024),(43,'Ana',16,'principal','pendiente',12102024),(44,'Melinda',16,'principal','pendiente',12102024),(45,'Anabel',16,'principal','pendiente',12102024),(46,'Patricia',17,'principal','pendiente',12102024),(47,'Jesus',17,'principal','pendiente',12102024),(48,'Paulina',18,'principal','pendiente',12102024),(49,'Sonia',18,'principal','pendiente',12102024),(50,'Jhoselin',18,'principal','pendiente',12102024),(51,'Fortunato',19,'principal','pendiente',12102024),(52,'Fernanda',19,'principal','pendiente',12102024),(53,'Francisca',20,'principal','pendiente',12102024),(54,'Silverio',21,'principal','pendiente',12102024),(55,'Francisca',21,'principal','pendiente',12102024),(56,'Alfredo',22,'principal','pendiente',12102024),(57,'Elisa',22,'principal','pendiente',12102024),(58,'Ronald',23,'principal','pendiente',12102024),(59,'Adelia',23,'principal','pendiente',12102024),(60,'Carlos',24,'principal','pendiente',12102024),(61,'Maria',24,'principal','pendiente',12102024),(62,'Ariel',25,'principal','pendiente',12102024),(63,'Faigo',26,'principal','pendiente',12102024),(64,'Noemi',26,'principal','pendiente',12102024),(65,'Ernesto',27,'principal','pendiente',12102024),(66,'Flora',27,'principal','pendiente',12102024),(67,'Samuel',28,'principal','pendiente',12102024),(68,'Deysi',28,'principal','pendiente',12102024),(69,'Jose',29,'principal','pendiente',12102024),(70,'Julia',29,'principal','pendiente',12102024),(71,'Evelin',29,'principal','pendiente',12102024),(72,'Thiago',29,'principal','pendiente',12102024),(73,'Luis',30,'principal','pendiente',12102024),(74,'Andrea',30,'principal','pendiente',12102024),(75,'Pablo',31,'principal','pendiente',12102024),(76,'Iris',31,'principal','pendiente',12102024),(77,'Alvaro',32,'principal','pendiente',12102024),(78,'Dani',32,'principal','pendiente',12102024),(79,'Josue',32,'principal','pendiente',12102024),(80,'Daniel',33,'principal','pendiente',12102024),(81,'Yhanil',33,'principal','pendiente',12102024),(82,'Thiago',33,'principal','pendiente',12102024),(83,'Julia',34,'principal','pendiente',12102024),(84,'Jimena',34,'principal','pendiente',12102024),(85,'Nino',35,'principal','pendiente',12102024),(86,'Jeane',35,'principal','pendiente',12102024),(87,'Camila',35,'principal','pendiente',12102024),(88,'Alejandra',35,'principal','pendiente',12102024),(89,'Mirian',36,'principal','pendiente',12102024),(90,'Jhaquelin',36,'principal','pendiente',12102024),(91,'Iris',36,'principal','pendiente',12102024),(92,'Abigail',36,'principal','pendiente',12102024),(93,'Marina',37,'principal','pendiente',12102024),(94,'Maria',38,'principal','pendiente',12102024),(95,'Miqueas',39,'principal','pendiente',12102024),(96,'Edgar',40,'principal','pendiente',12102024),(97,'Virginia',40,'principal','pendiente',12102024),(101,'Franklin',42,'principal','pendiente',12102024),(102,'Evelin',42,'principal','pendiente',12102024),(103,'David',43,'principal','pendiente',12102024),(104,'Pamela',43,'principal','pendiente',12102024),(105,'Eduardo',44,'principal','pendiente',12102024),(106,'Victoria',44,'principal','pendiente',12102024),(107,'Anghy',45,'principal','pendiente',12102024),(108,'Victor',46,'principal','pendiente',12102024),(109,'Nirsa',46,'principal','pendiente',12102024),(110,'Ruby',46,'principal','pendiente',12102024),(111,'Juan J.',47,'principal','pendiente',12102024),(112,'Ivon',47,'principal','pendiente',12102024),(113,'Edwin',48,'principal','pendiente',12102024),(114,'Roxana',48,'principal','pendiente',12102024),(115,'Marcelo',49,'principal','pendiente',12102024),(116,'Claudia',49,'principal','pendiente',12102024),(117,'Hija',49,'principal','pendiente',12102024),(118,'Ruth E.',50,'principal','pendiente',12102024),(119,'Rodrigo M.',51,'principal','pendiente',12102024),(120,'Milosz',52,'principal','pendiente',12102024),(121,'Ana',52,'principal','pendiente',12102024),(122,'Rodrigo',53,'principal','pendiente',12102024),(123,'Karol',53,'principal','pendiente',12102024),(124,'Grover',54,'principal','pendiente',12102024),(125,'Casilda',54,'principal','pendiente',12102024),(127,'Mary',55,'principal','pendiente',12102024),(128,'Ariel',55,'principal','pendiente',12102024),(129,'Joel',55,'principal','pendiente',12102024),(130,'Eric',55,'principal','pendiente',12102024),(131,'Orlando',56,'principal','confirmado',12102024),(132,'Marlene',56,'principal','confirmado',12102024),(133,'Josias',56,'principal','confirmado',12102024),(134,'Carolina',56,'principal','confirmado',12102024),(135,'Rosa',57,'principal','pendiente',12102024),(136,'Edith',57,'principal','pendiente',12102024),(137,'Norberto',58,'principal','pendiente',12102024),(138,'Hilda',58,'principal','pendiente',12102024),(139,'Basti',58,'principal','pendiente',12102024),(140,'Calixto',59,'principal','pendiente',12102024),(141,'Rosmeri',59,'principal','pendiente',12102024),(142,'Eunice',59,'principal','pendiente',12102024),(143,'Daniel',60,'principal','confirmado',12102024),(144,'Arturo',61,'principal','pendiente',12102024),(145,'Rosario',61,'principal','pendiente',12102024),(146,'Denis',62,'principal','pendiente',12102024),(147,'Karen',62,'principal','pendiente',12102024),(148,'Teofilo',63,'principal','pendiente',12102024),(149,'Gonzalo',64,'principal','pendiente',12102024),(150,'Martha',64,'principal','pendiente',12102024),(151,'Rocio',64,'principal','pendiente',12102024),(152,'Abel',65,'principal','pendiente',12102024),(153,'Vanesa',65,'principal','pendiente',12102024),(154,'Milena',65,'principal','pendiente',12102024),(155,'Francisco',66,'principal','pendiente',12102024),(156,'Beatriz',66,'principal','pendiente',12102024),(157,'Franz',66,'principal','pendiente',12102024),(158,'Brian',66,'principal','pendiente',12102024),(159,'Felicidad',67,'principal','pendiente',12102024),(160,'Ines',68,'principal','pendiente',12102024),(161,'Lizbeth',68,'principal','pendiente',12102024),(162,'Juan',68,'principal','pendiente',12102024),(163,'Femin',69,'principal','pendiente',12102024),(164,'Alicia',69,'principal','pendiente',12102024),(165,'Limbert',70,'principal','pendiente',12102024),(166,'July',70,'principal','pendiente',12102024),(167,'Elizabeth',71,'principal','pendiente',12102024),(168,'Joel',71,'principal','pendiente',12102024),(169,'Meguni',71,'principal','pendiente',12102024),(170,'Miriam',72,'principal','pendiente',12102024),(171,'Manuel',72,'principal','pendiente',12102024),(172,'Hijo 1',72,'principal','pendiente',12102024),(173,'Hijo 2',72,'principal','pendiente',12102024),(174,'Hijo 3',72,'principal','pendiente',12102024),(175,'Noemi',73,'principal','pendiente',12102024),(176,'Hugo',74,'principal','pendiente',12102024),(177,'Magdiel',74,'principal','pendiente',12102024),(178,'Jhoelma',74,'principal','pendiente',12102024),(179,'Miguel',75,'principal','pendiente',12102024),(180,'Edith',75,'principal','pendiente',12102024),(181,'Audia',76,'principal','pendiente',12102024),(182,'Wara',76,'principal','pendiente',12102024),(183,'Yara',76,'principal','pendiente',12102024),(184,'Corina',77,'principal','pendiente',12102024),(185,'Luciana',78,'principal','pendiente',12102024),(186,'Esther M.',79,'principal','pendiente',12102024),(187,'Paola',80,'principal','pendiente',12102024),(188,'Walber',80,'principal','pendiente',12102024),(189,'Hija',80,'principal','pendiente',12102024),(190,'Hija',80,'principal','pendiente',12102024),(191,'Martha',81,'principal','pendiente',12102024),(192,'Lidia',82,'principal','pendiente',12102024),(193,'Ariel',82,'principal','pendiente',12102024),(194,'Madelen',82,'principal','pendiente',12102024),(195,'Ana',83,'principal','pendiente',12102024),(196,'Jose',83,'principal','pendiente',12102024),(197,'Ana',84,'principal','pendiente',12102024),(198,'Monica',84,'principal','pendiente',12102024),(199,'Angel',85,'principal','pendiente',12102024),(200,'Esposa',85,'principal','pendiente',12102024),(201,'Judith',86,'principal','pendiente',12102024),(210,'Wendy',41,'principal','pendiente',12102024),(224,'Eduar',41,'principal','pendiente',12102024),(226,'Lucia',41,'principal','pendiente',12102024),(227,'Esperanza',73,'principal','pendiente',12102024);
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int unsigned NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('5JRuQi6V3C2s9NIsNxh15Y5AlVkVhLxV',1725999978,'{\"cookie\":{\"originalMaxAge\":3600000,\"expires\":\"2024-09-10T20:24:15.226Z\",\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":12102024},\"flash\":{}}'),('MRYPYj4m-YmI2WbApr8bETd2Nw-T0Cxi',1726000074,'{\"cookie\":{\"originalMaxAge\":3600000,\"expires\":\"2024-09-10T20:21:34.604Z\",\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":12102024},\"flash\":{}}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-10 21:40:40
