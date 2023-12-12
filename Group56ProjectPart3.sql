CREATE DATABASE  IF NOT EXISTS `cs336project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cs336project`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: cs336project
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `ID_Number` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(25) DEFAULT NULL,
  `account_type` varchar(25) DEFAULT 'customer',
  `username` varchar(50) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_Number`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'john','smith','customer','test','asdf');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `Aircraft_ID` varchar(6) NOT NULL,
  `Company_ID` char(2) NOT NULL,
  `Num_Seats` int DEFAULT NULL,
  PRIMARY KEY (`Aircraft_ID`),
  KEY `Company_ID` (`Company_ID`),
  CONSTRAINT `aircraft_ibfk_1` FOREIGN KEY (`Company_ID`) REFERENCES `airline` (`Company_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline` (
  `Company_ID` char(2) NOT NULL,
  `Airline_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Company_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline`
--

LOCK TABLES `airline` WRITE;
/*!40000 ALTER TABLE `airline` DISABLE KEYS */;
/*!40000 ALTER TABLE `airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `Airport_ID` char(2) NOT NULL,
  `Airport_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Airport_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `Flight_Number` int NOT NULL,
  `Company_ID` char(2) NOT NULL,
  `days_of_week` varchar(20) DEFAULT NULL,
  `departure_time` datetime DEFAULT NULL,
  `arrival_time` datetime DEFAULT NULL,
  `Flight_type` varchar(20) DEFAULT NULL,
  `From_Airport_ID` char(3) NOT NULL,
  `To_Airport_ID` char(3) NOT NULL,
  `Aircraft_ID` varchar(6) NOT NULL,
  PRIMARY KEY (`Flight_Number`,`Company_ID`),
  KEY `Company_ID` (`Company_ID`),
  KEY `To_Airport_ID` (`To_Airport_ID`),
  KEY `From_Airport_ID` (`From_Airport_ID`),
  KEY `Aircraft_ID` (`Aircraft_ID`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`Company_ID`) REFERENCES `airline` (`Company_ID`),
  CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`To_Airport_ID`) REFERENCES `airport` (`Airport_ID`),
  CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`From_Airport_ID`) REFERENCES `airport` (`Airport_ID`),
  CONSTRAINT `flight_ibfk_4` FOREIGN KEY (`Aircraft_ID`) REFERENCES `aircraft` (`Aircraft_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight_ticket`
--

DROP TABLE IF EXISTS `flight_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_ticket` (
  `Ticket_Number` int NOT NULL,
  `Total_Fare` float DEFAULT NULL,
  `Seat_Number` int DEFAULT NULL,
  `Flight_date` date DEFAULT NULL,
  `Purchase_date` date DEFAULT NULL,
  `Purchase_time` time DEFAULT NULL,
  `Booking_fee` int DEFAULT NULL,
  `ID_Number` int NOT NULL,
  `class` varchar(15) DEFAULT NULL,
  `change_fee` float DEFAULT NULL,
  PRIMARY KEY (`Ticket_Number`),
  KEY `ID_Number` (`ID_Number`),
  CONSTRAINT `flight_ticket_ibfk_1` FOREIGN KEY (`ID_Number`) REFERENCES `account` (`ID_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_ticket`
--

LOCK TABLES `flight_ticket` WRITE;
/*!40000 ALTER TABLE `flight_ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `flight_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operates_from`
--

DROP TABLE IF EXISTS `operates_from`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operates_from` (
  `Company_ID` char(2) NOT NULL,
  `Airport_ID` char(3) NOT NULL,
  PRIMARY KEY (`Company_ID`,`Airport_ID`),
  KEY `Airport_ID` (`Airport_ID`),
  CONSTRAINT `operates_from_ibfk_1` FOREIGN KEY (`Company_ID`) REFERENCES `airline` (`Company_ID`),
  CONSTRAINT `operates_from_ibfk_2` FOREIGN KEY (`Airport_ID`) REFERENCES `airport` (`Airport_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operates_from`
--

LOCK TABLES `operates_from` WRITE;
/*!40000 ALTER TABLE `operates_from` DISABLE KEYS */;
/*!40000 ALTER TABLE `operates_from` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_flights`
--

DROP TABLE IF EXISTS `ticket_flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_flights` (
  `Ticket_Number` int NOT NULL,
  `Flight_Number` int NOT NULL,
  `Company_ID` char(2) NOT NULL,
  PRIMARY KEY (`Ticket_Number`,`Flight_Number`,`Company_ID`),
  KEY `Flight_Number` (`Flight_Number`),
  KEY `Company_ID` (`Company_ID`),
  CONSTRAINT `ticket_flights_ibfk_1` FOREIGN KEY (`Ticket_Number`) REFERENCES `flight_ticket` (`Ticket_Number`),
  CONSTRAINT `ticket_flights_ibfk_2` FOREIGN KEY (`Flight_Number`) REFERENCES `flight` (`Flight_Number`),
  CONSTRAINT `ticket_flights_ibfk_3` FOREIGN KEY (`Company_ID`) REFERENCES `airline` (`Company_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_flights`
--

LOCK TABLES `ticket_flights` WRITE;
/*!40000 ALTER TABLE `ticket_flights` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waitlist`
--

DROP TABLE IF EXISTS `waitlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waitlist` (
  `ID_Number` int NOT NULL,
  `Flight_Number` int NOT NULL,
  `Company_ID` char(2) NOT NULL,
  PRIMARY KEY (`ID_Number`,`Flight_Number`,`Company_ID`),
  KEY `Flight_Number` (`Flight_Number`),
  KEY `Company_ID` (`Company_ID`),
  CONSTRAINT `waitlist_ibfk_1` FOREIGN KEY (`ID_Number`) REFERENCES `account` (`ID_Number`),
  CONSTRAINT `waitlist_ibfk_2` FOREIGN KEY (`Flight_Number`) REFERENCES `flight` (`Flight_Number`),
  CONSTRAINT `waitlist_ibfk_3` FOREIGN KEY (`Company_ID`) REFERENCES `airline` (`Company_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waitlist`
--

LOCK TABLES `waitlist` WRITE;
/*!40000 ALTER TABLE `waitlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `waitlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-16 21:28:04
