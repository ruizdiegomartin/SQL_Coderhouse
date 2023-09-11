-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce_project_ruiz
-- ------------------------------------------------------
-- Server version	8.0.33

/* BACKUP realizo para el desafío de SQL. Tablas incluidas:
_product_audit, _user_audit, cart, claim, claim_type, favorite, location, product, product_category, product_variety, purchase_order sale_discount, status, user.


*/

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `_product_audit`
--

LOCK TABLES `_product_audit` WRITE;
/*!40000 ALTER TABLE `_product_audit` DISABLE KEYS */;
INSERT INTO `_product_audit` VALUES (1,30,'canasta_mimbre','2023-08-30 22:13:18','root@localhost','root@localhost','2023-08-30 22:13:18');
/*!40000 ALTER TABLE `_product_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `_user_audit`
--

LOCK TABLES `_user_audit` WRITE;
/*!40000 ALTER TABLE `_user_audit` DISABLE KEYS */;
INSERT INTO `_user_audit` VALUES (1,'test.user','email@test.com','registrado','2023-08-30 22:13:18'),(2,'test.user','email@test.com','eliminado','2023-08-30 22:13:18');
/*!40000 ALTER TABLE `_user_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,1,1,2),(2,1,3,1),(3,1,12,4),(4,3,1,1),(5,3,2,4),(6,2,12,1),(7,4,13,3),(8,4,2,1),(9,5,2,1),(10,6,13,1),(11,9,10,2),(12,11,4,5),(13,11,3,1),(14,11,6,2),(15,12,10,1),(16,12,8,2),(17,14,7,3),(18,14,11,1),(19,15,15,2);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `claim`
--

LOCK TABLES `claim` WRITE;
/*!40000 ALTER TABLE `claim` DISABLE KEYS */;
INSERT INTO `claim` VALUES (1,6,'Me rebota la tarjeta de crédito, puedo usar otro medio de pago?',8,4),(2,2,'Me mandaron un producto equivocado',10,5);
/*!40000 ALTER TABLE `claim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `claim_type`
--

LOCK TABLES `claim_type` WRITE;
/*!40000 ALTER TABLE `claim_type` DISABLE KEYS */;
INSERT INTO `claim_type` VALUES (1,'No llegó el envío'),(2,'No es el producto que solicitó'),(3,'Error en la cantidad del producto'),(4,'Producto recibido en mal estado'),(5,'Producto defectuoso'),(6,'Otro');
/*!40000 ALTER TABLE `claim_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
INSERT INTO `favorite` VALUES (1,1,1),(2,5,1),(3,3,1),(4,4,2),(5,13,5),(6,2,6),(7,4,6),(8,8,8),(9,4,9),(10,1,9),(11,1,10),(12,16,10),(13,5,10),(14,3,11),(15,18,14);
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Buenos Aires'),(2,'Ciudad Autónoma de Buenos Aires'),(3,'Catamarca'),(4,'Chaco'),(5,'Chubut'),(6,'Córdoba'),(7,'Corrientes'),(8,'Entre Ríos'),(9,'Formosa'),(10,'Jujuy'),(11,'La Pampa'),(12,'La Rioja'),(13,'Mendoza'),(14,'Misiones'),(15,'Neuquén'),(16,'Río Negro'),(17,'Salta'),(18,'San Juan'),(19,'Santa Cruz'),(20,'Santa Fe'),(21,'Santiago del Estero'),(22,'Tierra del Fuego'),(23,'Tucumán');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'vela de soja jazmín',1250,10,4,1,1),(2,'vela de soja colírio',1250,8,1,1,NULL),(3,'vela de soja eucalípto',1250,8,8,1,3),(4,'vela de soja sandía y frambuesa',1250,2,7,1,NULL),(5,'vela de soja menta y naranja',1250,15,4,1,NULL),(6,'jabon flor limón',650.5,20,2,2,5),(7,'jabon flor pitanga',650.5,16,6,2,NULL),(8,'jabon con semillas frutos rojos',850.5,10,12,2,NULL),(9,'jabon con semillas vainilla',850.5,15,13,2,NULL),(10,'difusor limón',1300,20,2,3,NULL),(11,'difusor vainilla',1300,10,13,3,1),(12,'difusor menta y naranja',1300,5,4,3,NULL),(13,'difusor sandía y frambuesa',1300,23,7,3,NULL),(14,'splash limón',1300,10,2,4,NULL),(15,'splash flynn-paff',1300,10,3,4,3),(16,'splash cher',1300,10,5,4,NULL),(17,'splash vainilla',1300,10,13,4,NULL),(18,'aromatizador cher',1000,10,5,5,NULL),(19,'aromatizador pitanga',1000,12,6,5,1),(20,'aromatizador jazmín',1000,15,10,5,NULL),(21,'sahumerio de limón',250,30,2,6,5),(22,'sahumerio de eucalípto',250,20,8,6,NULL),(23,'sahumerio de palo santo',250,27,9,6,NULL),(24,'sahumerio de jazmín',250,9,10,6,NULL),(25,'esencia de vainilla',2230,10,13,7,3),(26,'esencia de limon',2230,12,2,7,3),(27,'esencia de eucalipto',2230,12,8,7,3),(28,'base porta-sahumerio',500,20,NULL,8,NULL),(29,'test: jabon de limón',3000,10,1,2,NULL),(30,'canasta_plástico',5000,5,NULL,8,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,'velas'),(2,'jabones'),(3,'difusores'),(4,'splash'),(5,'aromatizadores'),(6,'sahumerios'),(7,'esencias'),(8,'otros');
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_variety`
--

LOCK TABLES `product_variety` WRITE;
/*!40000 ALTER TABLE `product_variety` DISABLE KEYS */;
INSERT INTO `product_variety` VALUES (1,'colírio'),(2,'limón'),(3,'flynn-paff'),(4,'menta y naranja'),(5,'cher'),(6,'pitanga'),(7,'sandía y frambuesa'),(8,'eucalípto'),(9,'palo santo'),(10,'jazmín'),(11,'colírio'),(12,'frutos rojos'),(13,'vainilla');
/*!40000 ALTER TABLE `product_variety` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `purchase_order`
--

LOCK TABLES `purchase_order` WRITE;
/*!40000 ALTER TABLE `purchase_order` DISABLE KEYS */;
INSERT INTO `purchase_order` VALUES (1,'2023-08-30 00:00:00',8950,1,5),(2,'2023-04-03 08:02:21',2500,15,4),(3,'2023-08-30 00:00:00',3001,9,5),(4,'2023-06-14 10:00:50',1300,6,3),(5,'2023-07-23 09:00:50',1701,9,5);
/*!40000 ALTER TABLE `purchase_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sale_discount`
--

LOCK TABLES `sale_discount` WRITE;
/*!40000 ALTER TABLE `sale_discount` DISABLE KEYS */;
INSERT INTO `sale_discount` VALUES (1,'Promoción bancaria',20),(2,'Promoción bancaria especial',25),(3,'Promoción del día',10),(4,'Cyber Monday',30),(5,'Liquidación',50);
/*!40000 ALTER TABLE `sale_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'Pago realizado'),(2,'Esperando pago'),(3,'Pago rechazado'),(4,'Preparando producto'),(5,'Envío realizado'),(6,'Envío fallido'),(7,'Producto devuelto'),(8,'Reclamo iniciado'),(9,'Reclamo resuelto'),(10,'Reclamo en proceso');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'diegoo.martin','aCEvX324$','diego.martin@gmail.com','Diego','Martin','Av. Rivadavia 10231',2,NULL,NULL,NULL),(2,'angeladanvers','angEL$21szx','angeladanvers@gmail.com','Angela','Danvers','Glaston 334',6,NULL,NULL,NULL),(3,'lourdessflow','38480sXs&','lourdesprincess@yahoo.com.ar','Lourdes','Gucci','Cnel. Fran Rivarte 104',12,NULL,NULL,NULL),(4,'juanb3','u324j098m5utb34','juanii_23@gmail.com','Juan','Salas','Trenquelauquen 1578',15,NULL,NULL,NULL),(5,'tomas.sali22','h097n8ar3yv3w','tomas.salii@gmail.com','Tomas','Salinas','Pasaje Rivera 558',20,NULL,NULL,NULL),(6,'giseromaa2','fj34098rtDERF','gise_roma@gmail.com','Gisell','Roma','Av. Tirufan 1234',21,NULL,NULL,NULL),(7,'maurii.30','AN98UFfsdsdSA','maurii@outlook.com','Mauricio','Lopez','Av. Roca 3422',15,NULL,NULL,NULL),(8,'camiilitaa_star','as3sazL$21szx','camiliiita@yahoo.com.ar','Camila','Solano','Gascon 748',2,NULL,NULL,NULL),(9,'rosalia77','8snfFJ8fj','rosaliaf@gmail.com','Rosalía','Fuentes','Av. Don Bosco 1889',1,NULL,NULL,NULL),(10,'jessij','a2134355324$$','jessi_j@gmail.com','Jessica','Juarez','Psje. Sinatra 343',1,NULL,NULL,NULL),(11,'lucio12','89fdkojsfHFS34$&','lucio.la12@outlook.com','Lucio','Delgado','Av. de Mayo 2523',1,NULL,NULL,NULL),(12,'delfina.prietto','a94490328FSDAFXzxx','deelfiprie@gmail.com','Delfina','Prietto','Saleberry 3334',8,NULL,NULL,NULL),(13,'nerea.lopez2','83JFjsu6&','nereaperez@hotmail.com','Nerea','Lopez','Saladillo 164',3,NULL,NULL,NULL),(14,'vanee1','a9d3sdX','vane.bocco@gmail.com','Vanesa','Bocco','Miguel Suarez 112',9,NULL,NULL,NULL),(15,'pablope','sad7878xx','perezpablo@outlook.com','Pablo','Perez','Av. De La Cruz 1230',13,NULL,NULL,NULL),(16,'julii23','a94490328FSasda21DAFXzxx','juliangomez23@gmail.com','Julian','Gomez','Av. Trujillo 723',16,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-11 11:03:24
