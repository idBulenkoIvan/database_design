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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Адаптер'),(2,'Видеоадаптер'),(3,'Центральное процессорное устройство'),(4,'Материнская плата'),(5,'Блок питания'),(6,'Встроенная клавиатура'),(7,'Дисплей'),(8,'Картридж'),(9,'Печатающая головка'),(10,'Микропроцессор принтера'),(11,'Динамик'),(12,'Датчик'),(13,'Фотоприемник');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumables`
--

DROP TABLE IF EXISTS `consumables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumables` (
  `material_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `material_name` varchar(100) NOT NULL,
  `material_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`material_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `consumables_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumables`
--

LOCK TABLES `consumables` WRITE;
/*!40000 ALTER TABLE `consumables` DISABLE KEYS */;
INSERT INTO `consumables` VALUES (3,2,'GIGABYTE INTEL ARC A380 GV-IA380GAMING OC-6GD',19890.00),(4,2,'Palit NVIDIA GeForce GT 710 PA-GT710-2GD3H',5490.00),(5,2,'GIGABYTE INTEL ARC A310 GV-IA310WF2-4GD',15790.00),(6,5,'Aerocool VX PLUS 500W',2850.00),(7,5,'Aerocool VX PLUS 600W',3500.00),(8,5,'MSI MPG A850G',19920.00),(9,5,'HP Pavilion DV5-2000',1450.00),(10,5,'Samsung R418',1450.00),(11,5,'A1466 55Wh 7.6V A1496',3645.00),(12,5,'Retina A1708 54.5Wh 11.40V A1713',6440.00),(13,1,'Wi-Fi адаптер DEXP WFA-152',350.00),(14,1,'Wi-Fi адаптер Gembird WNP-UA-007',550.00),(15,1,'Wi-Fi адаптер RITMIX RWA-150',750.00),(16,1,'Bluetooth адаптер TP-Link UB500',1099.00),(17,1,'Bluetooth адаптер DEXP AT-BT501',599.00),(20,3,'Intel Core i3-10105 OEM',11999.00),(21,3,'Intel Core i3-10105 BOX',14399.00),(22,3,'Intel Core i3-12100 BOX',15699.00),(23,3,'AMD Ryzen 7 5700G BOX',18890.00),(24,3,'Intel Pentium Gold G6405 OEM',8499.00),(25,3,'AMD Ryzen 5 2600 OEM',11499.00),(26,4,'820-00875-A',12990.00),(27,4,'661-5870',14760.00),(28,4,'820-3115-B',15500.00),(29,4,'820-2936-B',10900.00),(30,6,'Retina A1502 Late',1560.00),(31,6,'Retina Touch Bar A1706, A1707 Late',2850.00),(32,6,'Retina A1425 Late',2970.00),(33,6,'Retina A1342 Late',2300.00),(34,7,'\"23.8\" LED 30 pin 1920x1080 (FHD) IPS матовая',19530.00),(35,7,'\"15.6\" LED 30 pin 1920x1080 (FHD) IPS матовая',7740.00),(36,7,'\"15.6\" LED 30 pin 1550x1030 IPS матовая',6500.00),(37,8,'SAKURA CE285A',380.00),(38,8,'GalaPrint CB435A',405.00),(39,8,'SAKURA MLTD101S',540.00),(40,9,'HP 72 C9380A',9890.00),(41,9,'HP P2V27A',20140.00),(42,9,'HP Replacement Kit 3YP61AE',8490.00),(43,10,'Kyocera TK-320',480.00),(44,10,'Kyocera TK-331',340.00),(45,10,'HP CF217A',120.00),(46,10,'HP CE567B',150.00),(47,11,'Airpods 2 Speaker (LEFT)',1590.00),(48,11,'Airpods 2 Speaker (RIGHT)',1590.00),(49,11,'Airpods Pro Speaker (LEFT)',2450.00),(50,11,'Airpods Pro Speaker (RIGHT)',2450.00),(51,12,'Датчик температуры ЦПУ универсальный',500.00),(52,12,'Датчик Холла универсальный',300.00),(53,12,'LiDAR для iPhone универсальный',1500.00),(54,13,'Датчик пироэлектрический IRA-940ST1',700.00);
/*!40000 ALTER TABLE `consumables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumption`
--

DROP TABLE IF EXISTS `consumption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumption` (
  `material_id` int NOT NULL,
  `order_id` int NOT NULL,
  `amount` smallint NOT NULL,
  PRIMARY KEY (`material_id`,`order_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `consumption_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `consumables` (`material_id`),
  CONSTRAINT `consumption_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `ordering` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumption`
--

LOCK TABLES `consumption` WRITE;
/*!40000 ALTER TABLE `consumption` DISABLE KEYS */;
INSERT INTO `consumption` VALUES (14,10,1),(15,1,1),(30,10,1),(31,2,1),(32,1,1),(33,2,1),(52,10,1),(53,1,3);
/*!40000 ALTER TABLE `consumption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(50) NOT NULL,
  `customer_email` varchar(50) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'ЗАО \"МорГаз\"','managaer@morgaz.ru '),(2,'ОАО \"Финанс\"','finance_manager@mail.ru'),(3,'ОАО \"Телеком\"','telekom_m@mail.ru'),(4,'Иван','ivan2023@gmail.com'),(5,'Юрий','yuri_msc@mail.ru'),(6,'Степан','kaverzin_s@gmail.com'),(7,'ЗАО \"КучкаБездарей\"','manager@bezdar.ru'),(8,'Реестр-консалтинг','consalting_center@yandex.ru'),(9,'ЗАО \"ОчереднаяКучкаБездарей\"','kuchka_bezdarei@yandex.ru');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturer`
--

DROP TABLE IF EXISTS `manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manufacturer` (
  `manufacturer_id` int NOT NULL AUTO_INCREMENT,
  `manufacturer_name` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`manufacturer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturer`
--

LOCK TABLES `manufacturer` WRITE;
/*!40000 ALTER TABLE `manufacturer` DISABLE KEYS */;
INSERT INTO `manufacturer` VALUES (1,'Apple Inc.',NULL),(2,'Samsung',NULL),(3,'Dell Technologies Inc.',NULL),(4,'Lenovo',NULL),(5,'Hawlett-Packard (HP)',NULL),(6,'Acer Inc.',NULL);
/*!40000 ALTER TABLE `manufacturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordering`
--

DROP TABLE IF EXISTS `ordering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordering` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `order_date` date NOT NULL,
  `order_complete_date` date DEFAULT NULL,
  `delivery_address` text,
  `customer_id` int NOT NULL,
  `repairman_id` int DEFAULT NULL,
  `technique_id` int NOT NULL,
  `status_id` int NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `repairman_id` (`repairman_id`),
  KEY `technique_id` (`technique_id`),
  KEY `status_id` (`status_id`),
  CONSTRAINT `ordering_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `ordering_ibfk_2` FOREIGN KEY (`repairman_id`) REFERENCES `repairman` (`repairman_id`),
  CONSTRAINT `ordering_ibfk_3` FOREIGN KEY (`technique_id`) REFERENCES `technique` (`technique_id`),
  CONSTRAINT `ordering_ibfk_4` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordering`
--

LOCK TABLES `ordering` WRITE;
/*!40000 ALTER TABLE `ordering` DISABLE KEYS */;
INSERT INTO `ordering` VALUES (1,'2023-01-01',NULL,NULL,1,2,3,3),(2,'2023-02-16',NULL,NULL,3,2,4,2),(3,'2023-03-09',NULL,NULL,7,1,5,3),(4,'2023-04-12',NULL,NULL,9,1,7,3),(5,'2023-02-25','2023-03-03',NULL,4,1,14,5),(6,'2023-03-13','2023-03-17',NULL,5,1,10,5),(7,'2023-04-08','2023-05-01',NULL,6,4,15,5),(8,'2023-04-13','2023-04-24',NULL,8,4,21,5),(9,'2023-04-16','2023-04-24','Новый Арбат ул., 75, Москва, 183069',3,2,8,5),(10,'2023-05-19','2023-06-01','Гагаринский пер., 93, Москва, 148214',3,2,9,5);
/*!40000 ALTER TABLE `ordering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repair`
--

DROP TABLE IF EXISTS `repair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repair` (
  `workload_id` int NOT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`workload_id`,`order_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `repair_ibfk_1` FOREIGN KEY (`workload_id`) REFERENCES `workload` (`workload_id`),
  CONSTRAINT `repair_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `ordering` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repair`
--

LOCK TABLES `repair` WRITE;
/*!40000 ALTER TABLE `repair` DISABLE KEYS */;
INSERT INTO `repair` VALUES (6,1),(12,1),(17,1),(18,1),(5,2),(6,2),(17,2),(18,2),(6,10),(12,10),(17,10),(18,10);
/*!40000 ALTER TABLE `repair` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repairman`
--

DROP TABLE IF EXISTS `repairman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repairman` (
  `repairman_id` int NOT NULL AUTO_INCREMENT,
  `repairman_name` varchar(50) NOT NULL,
  `repairman_email` varchar(50) NOT NULL,
  PRIMARY KEY (`repairman_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repairman`
--

LOCK TABLES `repairman` WRITE;
/*!40000 ALTER TABLE `repairman` DISABLE KEYS */;
INSERT INTO `repairman` VALUES (1,'Игорь','igor_2020@mail.ru'),(2,'Алексей','aleksey_msc@yandex.ru'),(3,'Герман','germ_germ@gmail.com'),(4,'Никита','nikonorov_n@yandex.ru');
/*!40000 ALTER TABLE `repairman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `status_id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(30) NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'Ожидает оплаты'),(2,'Оплачен'),(3,'Принят в работу'),(4,'Ожидает получения/доставки'),(5,'Завершен');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `technique`
--

DROP TABLE IF EXISTS `technique`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `technique` (
  `technique_id` int NOT NULL AUTO_INCREMENT,
  `type_id` int NOT NULL,
  `manufacturer_id` int NOT NULL,
  `technique_name` varchar(70) NOT NULL,
  PRIMARY KEY (`technique_id`),
  KEY `type_id` (`type_id`),
  KEY `manufacturer_id` (`manufacturer_id`),
  CONSTRAINT `technique_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `technique_type` (`type_id`),
  CONSTRAINT `technique_ibfk_2` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`manufacturer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `technique`
--

LOCK TABLES `technique` WRITE;
/*!40000 ALTER TABLE `technique` DISABLE KEYS */;
INSERT INTO `technique` VALUES (3,2,1,'MacBook Air A2681'),(4,2,1,'MacBook Pro A2485'),(5,2,1,'MacBook Pro A2780'),(6,2,2,'Galaxy Book3 360 NP730QFG-KA1IN'),(7,2,4,'IdeaPad 3 14IGL05 PQC N5030'),(8,2,4,'IdeaPad 3 15ITL6'),(9,1,1,'iMac A2115'),(10,1,1,'Mac Pro - Tower Z0W3005PP'),(11,4,5,'LASER 107A'),(12,4,5,'Smart Tank 581'),(13,7,1,'AirPods 2 A2032'),(14,7,1,'AirPods Max A2096'),(15,5,1,'iPhone 15 Pro'),(16,5,2,' Galaxy Z Flip5'),(17,6,2,'Aspire A315-56'),(18,6,2,'Aspire 5 A515-45'),(19,3,3,'E2723H'),(20,3,3,'U2422HE'),(21,3,3,'UltraSharp UP3221Q');
/*!40000 ALTER TABLE `technique` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `technique_type`
--

DROP TABLE IF EXISTS `technique_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `technique_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `technique_type` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `technique_type`
--

LOCK TABLES `technique_type` WRITE;
/*!40000 ALTER TABLE `technique_type` DISABLE KEYS */;
INSERT INTO `technique_type` VALUES (1,'ПК','Игровые ПК, ПК для профессионального дизайна и разработки, ПК для домашнего пользования'),(2,'Ноутбук','Ноутбуки для повседневного использования, ноутбуки для работы, игровые ноутбуки'),(3,'Монитор','Игровые мониторы, мониторы для дизайна и разработки'),(4,'Принтер','Принтеры для домашнего пользования, большие офисные принтеры, маленькие принтеры для ноутбука'),(5,'Мобильный телефон','Смартфоны для повседневного пользования, игровые смартфоны'),(6,'Сканер','Домашние сканеры, офисные сканеры, портативные сканеры'),(7,'Аудиооборудование','Внутриканальные наушники, наушники-вкладыши, игровые наушники, студийные наушники, беспроводные наушники');
/*!40000 ALTER TABLE `technique_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workload`
--

DROP TABLE IF EXISTS `workload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workload` (
  `workload_id` int NOT NULL AUTO_INCREMENT,
  `workload_price` decimal(10,2) NOT NULL,
  `workload_name` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`workload_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workload`
--

LOCK TABLES `workload` WRITE;
/*!40000 ALTER TABLE `workload` DISABLE KEYS */;
INSERT INTO `workload` VALUES (1,1000.00,'Замена графического процессора',NULL),(2,300.00,'Замена центрального процессорного устройства',NULL),(3,1000.00,'Замена материнской платы',NULL),(4,500.00,'Замена и настройка блока питания',NULL),(5,800.00,'Замена встроенной клавиатуры',NULL),(6,700.00,'Замена дисплея',NULL),(7,100.00,'Замена картриджа',NULL),(8,250.00,'Заправка картриджа',NULL),(9,1000.00,'Замена и настройка печатающей головки',NULL),(10,700.00,'Замена микропроцессора принтера',NULL),(11,200.00,'Замена динамика (1 шт.)',NULL),(12,450.00,'Замена и калибровка датчика',NULL),(13,700.00,'Замена фотоприемника',NULL),(14,1500.00,'Ремонт дисплея',NULL),(15,400.00,'Ремонт печатающей головки',NULL),(16,300.00,'Ремонт блока питания',NULL),(17,250.00,'Осмотр техники',NULL),(18,250.00,'Чистка устройства',NULL);
/*!40000 ALTER TABLE `workload` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
