/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.5.29-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: nwdb
-- ------------------------------------------------------
-- Server version	12.2.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `buses`
--

DROP TABLE IF EXISTS `buses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `buses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_bus` varchar(50) NOT NULL,
  `capacidad` int(11) NOT NULL DEFAULT 45,
  `estado` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buses`
--

LOCK TABLES `buses` WRITE;
/*!40000 ALTER TABLE `buses` DISABLE KEYS */;
INSERT INTO `buses` VALUES (1,'BUS-001',45,1),(2,'BUS-002',45,1),(3,'BUS-003',45,1),(4,'BUS-004',45,1),(5,'BUS-005',45,1),(6,'BUS-006',45,1);
/*!40000 ALTER TABLE `buses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrito`
--

DROP TABLE IF EXISTS `carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usercod` bigint(20) NOT NULL,
  `horario_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `tipo_asiento` varchar(20) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usercod` (`usercod`),
  KEY `horario_id` (`horario_id`),
  CONSTRAINT `1` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`),
  CONSTRAINT `2` FOREIGN KEY (`horario_id`) REFERENCES `horarios_viaje` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito`
--

LOCK TABLES `carrito` WRITE;
/*!40000 ALTER TABLE `carrito` DISABLE KEYS */;
/*!40000 ALTER TABLE `carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usercod` bigint(20) NOT NULL,
  `fecha` datetime NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `estado` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usercod` (`usercod`),
  CONSTRAINT `1` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (9,1,'2026-04-16 09:50:45',750.00,'pagado'),(10,1,'2026-04-16 10:31:40',550.00,'pagado'),(11,1,'2026-04-16 10:38:30',750.00,'pagado');
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_compra`
--

DROP TABLE IF EXISTS `detalle_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compra_id` int(11) NOT NULL,
  `horario_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `tipo_asiento` varchar(20) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `compra_id` (`compra_id`),
  KEY `horario_id` (`horario_id`),
  CONSTRAINT `1` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`),
  CONSTRAINT `2` FOREIGN KEY (`horario_id`) REFERENCES `horarios_viaje` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_compra`
--

LOCK TABLES `detalle_compra` WRITE;
/*!40000 ALTER TABLE `detalle_compra` DISABLE KEYS */;
INSERT INTO `detalle_compra` VALUES (11,9,3,'2026-04-17','Semi cama',250.00,3),(12,10,1,'2026-04-17','Cama',350.00,1),(13,10,1,'2026-04-21','Normal',200.00,1),(14,11,1,'2026-04-23','Semi cama',250.00,3);
/*!40000 ALTER TABLE `detalle_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funciones`
--

DROP TABLE IF EXISTS `funciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `funciones` (
  `fncod` varchar(255) NOT NULL,
  `fndsc` varchar(255) DEFAULT NULL,
  `fnest` char(3) DEFAULT NULL,
  `fntyp` char(3) DEFAULT NULL,
  PRIMARY KEY (`fncod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funciones`
--

LOCK TABLES `funciones` WRITE;
/*!40000 ALTER TABLE `funciones` DISABLE KEYS */;
INSERT INTO `funciones` VALUES ('Admin_Dashboard','Dashboard Admin','ACT','CTR'),('Checkout_Accept','PayPal Accept','ACT','CTR'),('Checkout_Add','Agregar al carrito','ACT','CTR'),('Checkout_Checkout','Ver carrito','ACT','CTR'),('Checkout_Confirm','Confirmar compra','ACT','CTR'),('Checkout_Error','PayPal Error','ACT','CTR'),('Checkout_Remove','Eliminar del carrito','ACT','CTR'),('Checkout_Success','Compra exitosa','ACT','CTR'),('Checkout_Update','Actualizar carrito','ACT','CTR'),('Compra_Historial','Historial de Compras','ACT','TRN'),('Mantenimientos_Buses_Bus','CRUD Buses','ACT','PRG'),('Mantenimientos_Buses_Formulario','Formulario Buses','ACT','CTR'),('Mantenimientos_Buses_Listado','Listado Buses','ACT','CTR'),('Mantenimientos_Compras_Compra','CRUD Compras','ACT','PRG'),('Mantenimientos_Compras_Detalle','Detalle de Compra Admin','ACT','CTR'),('Mantenimientos_Compras_Listado','Listado Compras','ACT','CTR'),('Mantenimientos_Roles_Formulario','Formulario Roles','ACT','CTR'),('Mantenimientos_Roles_Listado','Listado Roles','ACT','CTR'),('Mantenimientos_Roles_Rol','CRUD Roles','ACT','PRG'),('Mantenimientos_Rutas_Formulario','Formulario Rutas','ACT','CTR'),('Mantenimientos_Rutas_Listado','Listado Rutas','ACT','CTR'),('Mantenimientos_Rutas_Ruta','CRUD Rutas','ACT','PRG'),('Mantenimientos_Usuarios_Formulario','Formulario Usuarios','ACT','CTR'),('Mantenimientos_Usuarios_Listado','Listado Usuarios','ACT','CTR'),('Mantenimientos_Usuarios_Usuario','CRUD Usuarios','ACT','PRG'),('Mantenimientos_Viajes_Formulario','Formulario Viajes','ACT','CTR'),('Mantenimientos_Viajes_Listado','Listado Viajes','ACT','CTR'),('Mantenimientos_Viajes_Viaje','CRUD Viajes','ACT','PRG'),('Menu_Admin_Dashboard','Menu Dashboard','ACT','MNU'),('Menu_Checkout','Acceso al carrito','ACT','MNU'),('Menu_Compra_Historial','Menú Mi Historial','ACT','TRN'),('Menu_Mantenimiento_Buses','Menu Mantenimiento Buses','ACT','MNU'),('Menu_Mantenimiento_Compras','Menu Gestion de Compras','ACT','MNU'),('Menu_Mantenimiento_Roles','Menu_Mantenimiento_Roles','ACT','MNU'),('Menu_Mantenimiento_Rutas','Menu Mantenimiento Rutas','ACT','MNU'),('Menu_Mantenimiento_Usuarios','Menu_Mantenimiento_Usuarios','ACT','MNU'),('Menu_Mantenimiento_Viajes','Menu Mantenimiento Viajes','ACT','MNU'),('Menu_Mantenimientos_Compras','Menú Compras Admin','ACT','MNU'),('Menu_PaymentCheckout','Menu_PaymentCheckout','ACT','MNU'),('Private_MiPerfil','Acceso a Mi Perfil','ACT',NULL);
/*!40000 ALTER TABLE `funciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funciones_roles`
--

DROP TABLE IF EXISTS `funciones_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `funciones_roles` (
  `rolescod` varchar(128) NOT NULL,
  `fncod` varchar(255) NOT NULL,
  `fnrolest` char(3) DEFAULT NULL,
  `fnexp` datetime DEFAULT NULL,
  PRIMARY KEY (`rolescod`,`fncod`),
  KEY `rol_funcion_key_idx` (`fncod`),
  CONSTRAINT `funcion_rol_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`),
  CONSTRAINT `rol_funcion_key` FOREIGN KEY (`fncod`) REFERENCES `funciones` (`fncod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funciones_roles`
--

LOCK TABLES `funciones_roles` WRITE;
/*!40000 ALTER TABLE `funciones_roles` DISABLE KEYS */;
INSERT INTO `funciones_roles` VALUES ('admin','Admin_Dashboard','ACT','2030-01-01 00:00:00'),('admin','Checkout_Accept','ACT','2030-01-01 00:00:00'),('admin','Checkout_Add','ACT','2030-01-01 00:00:00'),('admin','Checkout_Checkout','ACT','2030-01-01 00:00:00'),('admin','Checkout_Confirm','ACT','2030-01-01 00:00:00'),('admin','Checkout_Error','ACT','2030-01-01 00:00:00'),('admin','Checkout_Remove','ACT','2030-01-01 00:00:00'),('admin','Checkout_Success','ACT','2030-01-01 00:00:00'),('admin','Checkout_Update','ACT','2030-01-01 00:00:00'),('admin','Compra_Historial','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Buses_Bus','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Buses_Formulario','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Buses_Listado','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Compras_Compra','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Compras_Detalle','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Compras_Listado','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Roles_Formulario','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Roles_Listado','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Roles_Rol','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Rutas_Formulario','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Rutas_Listado','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Rutas_Ruta','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Usuarios_Formulario','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Usuarios_Listado','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Usuarios_Usuario','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Viajes_Formulario','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Viajes_Listado','ACT','2030-01-01 00:00:00'),('admin','Mantenimientos_Viajes_Viaje','ACT','2030-01-01 00:00:00'),('admin','Menu_Admin_Dashboard','ACT','2030-01-01 00:00:00'),('admin','Menu_Checkout','ACT','2030-01-01 00:00:00'),('admin','Menu_Compra_Historial','ACT','2030-01-01 00:00:00'),('admin','Menu_Mantenimiento_Buses','ACT','2030-01-01 00:00:00'),('admin','Menu_Mantenimiento_Compras','ACT','2030-01-01 00:00:00'),('admin','Menu_Mantenimiento_Roles','ACT','2030-01-01 00:00:00'),('admin','Menu_Mantenimiento_Rutas','ACT','2030-01-01 00:00:00'),('admin','Menu_Mantenimiento_Usuarios','ACT','2030-01-01 00:00:00'),('admin','Menu_Mantenimiento_Viajes','ACT','2030-01-01 00:00:00'),('admin','Menu_Mantenimientos_Compras','ACT','2030-01-01 00:00:00'),('admin','Menu_PaymentCheckout','ACT','2030-01-01 00:00:00'),('admin','Private_MiPerfil','ACT','2030-01-01 00:00:00'),('cliente','Checkout_Accept','ACT','2030-01-01 00:00:00'),('cliente','Checkout_Add','ACT','2030-01-01 00:00:00'),('cliente','Checkout_Checkout','ACT','2030-01-01 00:00:00'),('cliente','Checkout_Confirm','ACT','2030-01-01 00:00:00'),('cliente','Checkout_Error','ACT','2030-01-01 00:00:00'),('cliente','Checkout_Remove','ACT','2030-01-01 00:00:00'),('cliente','Checkout_Success','ACT','2030-01-01 00:00:00'),('cliente','Checkout_Update','ACT','2030-01-01 00:00:00'),('cliente','Compra_Historial','ACT','2030-01-01 00:00:00'),('cliente','Menu_Checkout','ACT','2030-01-01 00:00:00'),('cliente','Menu_Compra_Historial','ACT','2030-01-01 00:00:00'),('cliente','Private_MiPerfil','ACT','2030-01-01 00:00:00');
/*!40000 ALTER TABLE `funciones_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horarios_viaje`
--

DROP TABLE IF EXISTS `horarios_viaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `horarios_viaje` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ruta_id` int(11) NOT NULL,
  `bus_id` int(11) NOT NULL,
  `hora` time NOT NULL,
  `estado` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `ruta_id` (`ruta_id`),
  KEY `bus_id` (`bus_id`),
  CONSTRAINT `1` FOREIGN KEY (`ruta_id`) REFERENCES `rutas` (`id`),
  CONSTRAINT `2` FOREIGN KEY (`bus_id`) REFERENCES `buses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horarios_viaje`
--

LOCK TABLES `horarios_viaje` WRITE;
/*!40000 ALTER TABLE `horarios_viaje` DISABLE KEYS */;
INSERT INTO `horarios_viaje` VALUES (1,1,1,'08:00:00',1),(2,2,2,'10:00:00',1),(3,3,3,'06:00:00',1),(4,4,4,'14:00:00',1),(5,5,5,'07:30:00',1),(6,6,6,'15:00:00',1),(7,7,1,'05:45:00',1),(8,8,2,'13:30:00',1),(9,9,3,'09:00:00',1),(10,10,4,'16:00:00',1),(11,11,5,'07:00:00',1),(12,12,6,'17:00:00',1);
/*!40000 ALTER TABLE `horarios_viaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compra_id` int(11) NOT NULL,
  `metodo` varchar(50) NOT NULL DEFAULT 'PAYPAL',
  `estado` varchar(30) NOT NULL,
  `paypal_order_id` varchar(100) DEFAULT NULL,
  `paypal_capture_id` varchar(100) DEFAULT NULL,
  `payer_nombre` varchar(150) DEFAULT NULL,
  `payer_email` varchar(150) DEFAULT NULL,
  `payer_id` varchar(100) DEFAULT NULL,
  `monto` decimal(10,2) NOT NULL,
  `moneda` varchar(10) DEFAULT 'USD',
  `direccion` text DEFAULT NULL,
  `json_response` longtext DEFAULT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `compra_id` (`compra_id`),
  CONSTRAINT `1` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` VALUES (2,9,'PAYPAL','COMPLETED','3T317481NF153971T','4BV63942GY668692R','John Doe','sb-4u8yj50622553@personal.example.com','7K6QT6QC8M62W',750.00,'L.','Free Trade Zone, Tegucigalpa, HN','{\"id\":\"3T317481NF153971T\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"sb-4u8yj50622553@personal.example.com\",\"account_id\":\"7K6QT6QC8M62W\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"John\",\"surname\":\"Doe\"},\"address\":{\"country_code\":\"HN\"}}},\"purchase_units\":[{\"reference_id\":\"ORD-1-1776333025\",\"shipping\":{\"name\":{\"full_name\":\"John Doe\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Tegucigalpa\",\"admin_area_1\":\"TEGUCIGALPA\",\"postal_code\":\"12345\",\"country_code\":\"HN\"}},\"payments\":{\"captures\":[{\"id\":\"4BV63942GY668692R\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"750.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"750.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"37.05\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"712.95\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/4BV63942GY668692R\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/4BV63942GY668692R\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/3T317481NF153971T\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2026-04-16T09:50:43Z\",\"update_time\":\"2026-04-16T09:50:43Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"John\",\"surname\":\"Doe\"},\"email_address\":\"sb-4u8yj50622553@personal.example.com\",\"payer_id\":\"7K6QT6QC8M62W\",\"address\":{\"country_code\":\"HN\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/3T317481NF153971T\",\"rel\":\"self\",\"method\":\"GET\"}]}','2026-04-16 09:50:45'),(3,10,'PAYPAL','COMPLETED','02E51422FG834761T','0JB22555GR6226824','John Doe','sb-4u8yj50622553@personal.example.com','7K6QT6QC8M62W',700.00,'L.','Free Trade Zone, Tegucigalpa, HN','{\"id\":\"02E51422FG834761T\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"sb-4u8yj50622553@personal.example.com\",\"account_id\":\"7K6QT6QC8M62W\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"John\",\"surname\":\"Doe\"},\"address\":{\"country_code\":\"HN\"}}},\"purchase_units\":[{\"reference_id\":\"ORD-1-1776335481\",\"shipping\":{\"name\":{\"full_name\":\"John Doe\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Tegucigalpa\",\"admin_area_1\":\"TEGUCIGALPA\",\"postal_code\":\"12345\",\"country_code\":\"HN\"}},\"payments\":{\"captures\":[{\"id\":\"0JB22555GR6226824\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"700.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"700.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"34.60\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"665.40\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/0JB22555GR6226824\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/0JB22555GR6226824\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/02E51422FG834761T\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2026-04-16T10:31:39Z\",\"update_time\":\"2026-04-16T10:31:39Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"John\",\"surname\":\"Doe\"},\"email_address\":\"sb-4u8yj50622553@personal.example.com\",\"payer_id\":\"7K6QT6QC8M62W\",\"address\":{\"country_code\":\"HN\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/02E51422FG834761T\",\"rel\":\"self\",\"method\":\"GET\"}]}','2026-04-16 10:31:41'),(4,11,'PAYPAL','COMPLETED','7XL62186FN709620M','5Y512275TW2300103','John Doe','sb-4u8yj50622553@personal.example.com','7K6QT6QC8M62W',750.00,'L.','Free Trade Zone, Tegucigalpa, HN','{\"id\":\"7XL62186FN709620M\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"sb-4u8yj50622553@personal.example.com\",\"account_id\":\"7K6QT6QC8M62W\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"John\",\"surname\":\"Doe\"},\"address\":{\"country_code\":\"HN\"}}},\"purchase_units\":[{\"reference_id\":\"ORD-1-1776335897\",\"shipping\":{\"name\":{\"full_name\":\"John Doe\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Tegucigalpa\",\"admin_area_1\":\"TEGUCIGALPA\",\"postal_code\":\"12345\",\"country_code\":\"HN\"}},\"payments\":{\"captures\":[{\"id\":\"5Y512275TW2300103\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"750.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"750.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"37.05\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"712.95\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/5Y512275TW2300103\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/5Y512275TW2300103\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/7XL62186FN709620M\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2026-04-16T10:38:29Z\",\"update_time\":\"2026-04-16T10:38:29Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"John\",\"surname\":\"Doe\"},\"email_address\":\"sb-4u8yj50622553@personal.example.com\",\"payer_id\":\"7K6QT6QC8M62W\",\"address\":{\"country_code\":\"HN\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/7XL62186FN709620M\",\"rel\":\"self\",\"method\":\"GET\"}]}','2026-04-16 10:38:30');
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `rolescod` varchar(128) NOT NULL,
  `rolesdsc` varchar(45) DEFAULT NULL,
  `rolesest` char(3) DEFAULT NULL,
  PRIMARY KEY (`rolescod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('admin','Administrador del sistema','ACT'),('cliente','Cliente del sistema','ACT');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_usuarios`
--

DROP TABLE IF EXISTS `roles_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_usuarios` (
  `usercod` bigint(10) NOT NULL,
  `rolescod` varchar(128) NOT NULL,
  `roleuserest` char(3) DEFAULT NULL,
  `roleuserfch` datetime DEFAULT NULL,
  `roleuserexp` datetime DEFAULT NULL,
  PRIMARY KEY (`usercod`,`rolescod`),
  KEY `rol_usuario_key_idx` (`rolescod`),
  CONSTRAINT `rol_usuario_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`),
  CONSTRAINT `usuario_rol_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_usuarios`
--

LOCK TABLES `roles_usuarios` WRITE;
/*!40000 ALTER TABLE `roles_usuarios` DISABLE KEYS */;
INSERT INTO `roles_usuarios` VALUES (1,'admin','ACT','2026-04-12 01:12:40','2030-01-01 00:00:00'),(2,'admin','INA','2026-04-16 22:38:29','2030-01-01 00:00:00'),(2,'cliente','ACT','2026-04-16 22:38:34','2030-01-01 00:00:00');
/*!40000 ALTER TABLE `roles_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rutas`
--

DROP TABLE IF EXISTS `rutas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `origen` varchar(100) NOT NULL,
  `destino` varchar(100) NOT NULL,
  `estado` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutas`
--

LOCK TABLES `rutas` WRITE;
/*!40000 ALTER TABLE `rutas` DISABLE KEYS */;
INSERT INTO `rutas` VALUES (1,'Tegucigalpa','Choluteca',1),(2,'Choluteca','Tegucigalpa',1),(3,'Tegucigalpa','San Pedro Sula',1),(4,'San Pedro Sula','Tegucigalpa',1),(5,'Tegucigalpa','Copán',1),(6,'Copán','Tegucigalpa',1),(7,'Tegucigalpa','La Ceiba',1),(8,'La Ceiba','Tegucigalpa',1),(9,'Tegucigalpa','Comayagua',1),(10,'Comayagua','Tegucigalpa',1),(11,'Tegucigalpa','Danlí',1),(12,'Danlí','Tegucigalpa',1);
/*!40000 ALTER TABLE `rutas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `usercod` bigint(10) NOT NULL AUTO_INCREMENT,
  `useremail` varchar(80) DEFAULT NULL,
  `username` varchar(80) DEFAULT NULL,
  `userpswd` varchar(128) DEFAULT NULL,
  `userfching` datetime DEFAULT NULL,
  `userpswdest` char(3) DEFAULT NULL,
  `userpswdexp` datetime DEFAULT NULL,
  `userest` char(3) DEFAULT NULL,
  `useractcod` varchar(128) DEFAULT NULL,
  `userpswdchg` varchar(128) DEFAULT NULL,
  `usertipo` char(3) DEFAULT NULL,
  PRIMARY KEY (`usercod`),
  UNIQUE KEY `useremail_UNIQUE` (`useremail`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'admin@admin.com','Mario Martinez','$2y$10$Z0p44.LgYFfFPyJLinibFe0IGI/LIzj3PR3hfftULIs9FKwWgk5aO','2026-04-12 01:32:09','ACT','2026-07-10 00:00:00','ACT','a787a8a9709537d2965b1dcfa8a0d40c9b8632530c2693b104ad0cb97d9b5ccb','2026-04-12 01:32:09','PBL'),(2,'dpez991@gmail.com','David López','$2y$10$eLFyzH96ycXo7F7WWWBwu.ZlnAgz.iHZGPVVn5p.DJBtYF1ZPaCtK','2026-04-12 01:41:31','ACT','2026-07-10 00:00:00','ACT','588d0b23cd3aca78b8afdf5e6d150f50b27d3312c20b539607b42e6330f479c2','2026-04-15 07:28:19','PBL');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viajes`
--

DROP TABLE IF EXISTS `viajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `viajes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `horario_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `asientos_disponibles` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `horario_id` (`horario_id`),
  CONSTRAINT `1` FOREIGN KEY (`horario_id`) REFERENCES `horarios_viaje` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viajes`
--

LOCK TABLES `viajes` WRITE;
/*!40000 ALTER TABLE `viajes` DISABLE KEYS */;
INSERT INTO `viajes` VALUES (1,1,'2026-04-16',41),(2,2,'2026-04-16',44),(3,3,'2026-04-16',45),(4,4,'2026-04-16',45),(5,5,'2026-04-16',45),(6,6,'2026-04-16',45),(7,7,'2026-04-16',45),(8,8,'2026-04-16',45),(9,9,'2026-04-16',45),(10,10,'2026-04-16',45),(11,11,'2026-04-16',45),(12,12,'2026-04-16',45),(17,1,'2026-04-17',38),(18,2,'2026-04-23',42),(19,3,'2026-04-17',42),(20,1,'2026-04-21',44),(21,1,'2026-04-23',42);
/*!40000 ALTER TABLE `viajes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-16 22:48:48
