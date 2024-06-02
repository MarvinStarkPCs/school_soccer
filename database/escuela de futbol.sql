CREATE DATABASE IF NOT EXISTS `escuela_futbol` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `escuela_futbol`;

-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
-- Host: localhost    Database: escuela_futbol
-- ------------------------------------------------------
-- Server version    8.0.35

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

-- Table structure for table `regimen_type`
DROP TABLE IF EXISTS `regimen_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regimen_type` (
  `regimen_id` int NOT NULL,
  `regimen_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`regimen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `regimen_type`
LOCK TABLES `regimen_type` WRITE;
/*!40000 ALTER TABLE `regimen_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `regimen_type` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `regimen_eps`
DROP TABLE IF EXISTS `regimen_eps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regimen_eps` (
  `regimen_eps_id` int NOT NULL,
  `regimen_id` int DEFAULT NULL,
  `eps_id` int DEFAULT NULL,
  PRIMARY KEY (`regimen_eps_id`),
  KEY `regimen_id` (`regimen_id`),
  KEY `eps_id` (`eps_id`),
  CONSTRAINT `regimen_eps_ibfk_1` FOREIGN KEY (`regimen_id`) REFERENCES `regimen_type` (`regimen_id`),
  CONSTRAINT `regimen_eps_ibfk_2` FOREIGN KEY (`eps_id`) REFERENCES `eps` (`eps_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `regimen_eps`
LOCK TABLES `regimen_eps` WRITE;
/*!40000 ALTER TABLE `regimen_eps` DISABLE KEYS */;
/*!40000 ALTER TABLE `regimen_eps` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `categories`
DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `school_id` int DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `school_id` (`school_id`),
  CONSTRAINT `category_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `categories`
LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `departments`
DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `department_id` int NOT NULL,
  `department_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for table `citys`
DROP TABLE IF EXISTS `citys`;
CREATE TABLE `citys` (
  `city_id` int NOT NULL,
  `city_name` varchar(255) DEFAULT NULL,
  `id_department` int,
  PRIMARY KEY (`city_id`),
  KEY `id_department` (`id_department`),
  CONSTRAINT `citys_ibfk_1` FOREIGN KEY (`id_department`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `citys`
LOCK TABLES `citys` WRITE;
/*!40000 ALTER TABLE `citys` DISABLE KEYS */;
/*!40000 ALTER TABLE `citys` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `eps`
DROP TABLE IF EXISTS `eps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eps` (
  `eps_id` int NOT NULL,
  `eps_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`eps_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `eps`
LOCK TABLES `eps` WRITE;
/*!40000 ALTER TABLE `eps` DISABLE KEYS */;
/*!40000 ALTER TABLE `eps` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `students`
DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `student_id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `category_user_id` int DEFAULT NULL,
  `image_student` bit(1) DEFAULT NULL,
  `afiliation_type` int DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `city_id` (`city_id`),
  KEY `category_user_id` (`category_user_id`),
  KEY `afiliation_type` (`afiliation_type`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `citys` (`city_id`),
  CONSTRAINT `students_ibfk_2` FOREIGN KEY (`category_user_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `students_ibfk_3` FOREIGN KEY (`afiliation_type`) REFERENCES `regimen_type` (`regimen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `students`
LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `school`
DROP TABLE IF EXISTS `school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school` (
  `school_id` int NOT NULL,
  `school_name` varchar(255) DEFAULT NULL,
  `shield` bit(1) DEFAULT NULL,
  PRIMARY KEY (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `school`
LOCK TABLES `school` WRITE;
/*!40000 ALTER TABLE `school` DISABLE KEYS */;
/*!40000 ALTER TABLE `school` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `sessions`
DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int unsigned NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `sessions`
LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('N3XZzJAYC02X72ya8PSxrRZg6Jzm8HR9',1716946722,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{\"user\":1}}'),('_8KPG6O7dYk0C1AcV7BUk09hRrfVGjHN',1716913237,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),('wSX76cRDuC_WOHpOc1JeSuxtGXWvl9eY',1716913281,'{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{\"user\":1}}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `users`
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(16) NOT NULL,
  `password` varchar(60) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `users`
LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2a$10$YtXfxLw7X1.nRo53dSFLg.oy7cJYjFZDsV5V4GBelGl2ffneHS/Uu','admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-27 21:50:39




/*VOLCADO DE DATOS*/




USE `escuela_futbol`;

-- Insert data into departments
INSERT INTO `departments` (`department_id`, `department_name`) VALUES
(1, 'Antioquia'),
(2, 'Cundinamarca'),
(3, 'Valle del Cauca');

-- Insert data into citys
INSERT INTO `citys` (`city_id`, `city_name`, `id_department`) VALUES
(1, 'Medellín', 1),
(2, 'Bogotá', 2),
(3, 'Cali', 3);

-- Insert data into school
INSERT INTO `school` (`school_id`, `school_name`, `shield`) VALUES
(1, 'Escuela Futbol Antioquia', b'1'),
(2, 'Escuela Futbol Cundinamarca', b'1'),
(3, 'Escuela Futbol Valle', b'1');

-- Insert data into categories
INSERT INTO `categories` (`category_id`, `category_name`, `school_id`) VALUES
(1, 'Infantil', 1),
(2, 'Juvenil', 1),
(3, 'Infantil', 2),
(4, 'Juvenil', 2),
(5, 'Infantil', 3),
(6, 'Juvenil', 3);

-- Insert data into regimen_type
INSERT INTO `regimen_type` (`regimen_id`, `regimen_description`) VALUES
(1, 'Subsidiado'),
(2, 'Contributivo');

-- Insert data into eps
INSERT INTO `eps` (`eps_id`, `eps_description`) VALUES
(1, 'Sura'),
(2, 'Nueva EPS'),
(3, 'Sanitas');

-- Insert data into regimen_eps
INSERT INTO `regimen_eps` (`regimen_eps_id`, `regimen_id`, `eps_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3);

-- Insert data into students
INSERT INTO `students` (`student_id`, `name`, `last_name`, `date`, `city_id`, `category_user_id`, `image_student`, `afiliation_type`) VALUES
(1, 'Juan', 'Perez', '2023-01-01 00:00:00', 1, 1, b'1', 1),
(2, 'Maria', 'Gomez', '2023-01-02 00:00:00', 2, 3, b'1', 2),
(3, 'Pedro', 'Martinez', '2023-01-03 00:00:00', 3, 5, b'1', 1);

-- Insert data into sessions
INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('session_1', 1716946722, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}, "passport":{"user":1}}'),
('session_2', 1716913237, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
('session_3', 1716913281, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}, "passport":{"user":1}}');

-- Insert data into users
INSERT INTO `users` (`id`, `username`, `password`, `fullname`) VALUES
(1, 'admin', '$2a$10$YtXfxLw7X1.nRo53dSFLg.oy7cJYjFZDsV5V4GBelGl2ffneHS/Uu', 'admin');



SELECT
    s.student_id,
    s.name AS student_name,
    s.last_name,
    s.date AS registration_date,
    c.city_name,
    d.department_name,
    cat.category_name,
    sch.school_name,
    eps.eps_description,
    rt.regimen_description,
    CASE WHEN s.image_student = b'1' THEN 'Yes' ELSE 'No' END AS has_image
FROM
    students s
JOIN citys c ON s.city_id = c.city_id
JOIN departments d ON c.id_department = d.department_id
JOIN categories cat ON s.category_user_id = cat.category_id
JOIN school sch ON cat.school_id = sch.school_id
JOIN regimen_type rt ON s.afiliation_type = rt.regimen_id
LEFT JOIN regimen_eps re ON rt.regimen_id = re.regimen_id
LEFT JOIN eps ON re.eps_id = eps.eps_id
ORDER BY
    s.student_id;

