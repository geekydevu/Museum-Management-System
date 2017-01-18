-- MySQL dump 10.13  Distrib 5.7.15, for Linux (x86_64)
--
-- Host: localhost    Database: museum
-- ------------------------------------------------------
-- Server version	5.7.13-0ubuntu0.16.04.2

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
-- Table structure for table `ARTIFACT`
--

DROP TABLE IF EXISTS `ARTIFACT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ARTIFACT` (
  `Accession_number` int(11) NOT NULL AUTO_INCREMENT,
  `Dept_ID` int(11) DEFAULT NULL,
  `Title` varchar(30) NOT NULL DEFAULT 'Unnamed',
  `Date_acquired` date DEFAULT NULL,
  `Number_of_copies` int(11) DEFAULT '1',
  `Description` varchar(100) DEFAULT NULL,
  `Artist_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Accession_number`),
  KEY `Dept_ID` (`Dept_ID`),
  KEY `Artist_ID` (`Artist_ID`),
  CONSTRAINT `ARTIFACT_ibfk_2` FOREIGN KEY (`Dept_ID`) REFERENCES `DEPARTMENT` (`Dept_ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ARTIFACT_ibfk_3` FOREIGN KEY (`Artist_ID`) REFERENCES `ARTIST` (`Artist_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ARTIFACT`
--

LOCK TABLES `ARTIFACT` WRITE;
/*!40000 ALTER TABLE `ARTIFACT` DISABLE KEYS */;
INSERT INTO `ARTIFACT` VALUES (201,3,'Corner Chair','2012-03-03',1,'Pure French Silk',1),(202,5,'Evening Dress','1977-05-08',2,'',1),(203,10,'Covered Goblet','2000-12-12',1,'Blown and engraved glass',2),(204,10,'Lotiform Chalice','2005-08-08',89,'Said to be from Middle Egypt, Tuna el-Gebel region; From Egypt',2),(205,1,'Island of the Dead','2011-09-21',9,'Oil on wood painting',3),(206,12,'Monumental vase','2010-11-08',0,NULL,4),(207,2,'Head of a goddess','1966-03-01',8,'quartzite',5),(208,13,'Armchair','1968-09-21',4,'Mahogany, tooled and painted leather',5),(209,4,'Evening Dress','1976-12-21',0,'Pure French Silk ',5),(210,11,'Carthusian Potriat','1966-09-25',2,NULL,6),(215,5,'Wallet','2000-12-12',5,'Very good wallet',11),(216,13,'M-19','1959-09-09',4,'Historical',12);
/*!40000 ALTER TABLE `ARTIFACT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ARTIST`
--

DROP TABLE IF EXISTS `ARTIST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ARTIST` (
  `Artist_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(30) NOT NULL,
  `Nationality` varchar(20) NOT NULL DEFAULT 'India',
  `Begin_date` date DEFAULT NULL,
  `End_date` date DEFAULT '2100-12-31',
  `Phone` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`Artist_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ARTIST`
--

LOCK TABLES `ARTIST` WRITE;
/*!40000 ALTER TABLE `ARTIST` DISABLE KEYS */;
INSERT INTO `ARTIST` VALUES (1,'Robert Adamson','American','1981-02-03','2011-04-18',0),(2,'James C. Annan','Chinese','1999-12-31','0000-00-00',9821320911),(3,'Thomas Annan','Japanese','1945-11-23','2000-04-04',7824261816),(4,'David Brewster','French','1967-08-12','2000-04-01',9876543278),(5,'Lady Elizabeth','England','1972-03-17','2009-04-04',8631232811),(6,'David Octavious','England','2003-02-02','0000-00-00',0),(7,'Sushma Ingals','Indian','2011-04-18','0000-00-00',8987656715),(8,'Edward William','England','2000-04-04','0000-00-00',9456462693),(9,'Hill Adamson','Colombian','1923-10-10','1967-08-12',0),(10,'Patrick Byrne','Portugese','1967-05-17','2003-02-02',9123492726),(11,'Devang','Indian','1996-08-12','2016-10-21',9621633895),(12,'Pablo Escobar','Columbian','1959-09-18','2100-12-31',8987321182);
/*!40000 ALTER TABLE `ARTIST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DEPARTMENT`
--

DROP TABLE IF EXISTS `DEPARTMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DEPARTMENT` (
  `Dept_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(30) NOT NULL,
  `Opening_time` time DEFAULT NULL,
  `Closing_time` time DEFAULT NULL,
  PRIMARY KEY (`Dept_ID`,`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DEPARTMENT`
--

LOCK TABLES `DEPARTMENT` WRITE;
/*!40000 ALTER TABLE `DEPARTMENT` DISABLE KEYS */;
INSERT INTO `DEPARTMENT` VALUES (1,'American Decorative Arts ','08:00:00','22:00:00'),(2,'Ancient Near Eastern Art ','10:00:00','16:30:00'),(3,'Arms and Armor','09:30:00','15:30:00'),(4,'Arts of Africa and Oceania','08:00:00','22:00:00'),(5,'Asian Art ','08:00:00','22:00:00'),(6,'Costume Institute','09:30:00','15:30:00'),(7,'Drawings and Painting','09:30:00','15:30:00'),(8,'Egyptian Art','09:30:00','15:30:00'),(9,'Europian Paintings','10:00:00','16:30:00'),(10,'Islamic Arts ','11:30:00','13:00:00'),(11,'Medival Arts ','12:30:00','17:45:00'),(12,'Musical Instruments','07:00:00','23:30:00'),(13,'Photographs','12:00:00','16:00:00'),(17,'Music Collection','10:00:00','18:00:00'),(18,'Computer Science','12:00:00','12:10:00'),(19,'sdfgfdf','12:00:00','10:00:00');
/*!40000 ALTER TABLE `DEPARTMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EMPLOYEE`
--

DROP TABLE IF EXISTS `EMPLOYEE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EMPLOYEE` (
  `Emp_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Dept_ID` int(11) DEFAULT NULL,
  `Name` varchar(30) NOT NULL,
  `Date_of_birth` date NOT NULL DEFAULT '1950-01-01',
  `Sex` char(1) NOT NULL DEFAULT 'M',
  `Designation` varchar(40) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Emp_ID`),
  KEY `Dept_ID` (`Dept_ID`),
  CONSTRAINT `EMPLOYEE_ibfk_2` FOREIGN KEY (`Dept_ID`) REFERENCES `DEPARTMENT` (`Dept_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMPLOYEE`
--

LOCK TABLES `EMPLOYEE` WRITE;
/*!40000 ALTER TABLE `EMPLOYEE` DISABLE KEYS */;
INSERT INTO `EMPLOYEE` VALUES (101,3,'Arjun Rathee','1996-03-12','M','Head_of_Department','31, Arya Nagar, Agra'),(102,5,'Ayush Mehta','1946-03-12','M','Sweeper','21, Khao Gali, Agra'),(103,8,'Lovely Khanna','1956-05-12','F','Accountant','Arjun Nagar, Agra'),(104,10,'Lovish Tyagi','1966-01-14','M','Head_of_Department','Sector-56, Noida'),(105,10,'Pablo Escobar','0000-00-00','M','Ticket_manager','22, Wall Street, Noida'),(106,10,'Jon Snow','1996-04-12','M','Guide','Sector-2, Noida'),(107,1,'Lady Stonehart','0000-00-00','F','Head_of_Department','87 RamaPlaza Delhi'),(108,1,'Samwell Tarly','1976-03-21','M','Accountant','20 Juhu Colony, Delhi'),(109,12,'Steve S.','0000-00-00','M','Guide','44, Khao Gali, Delhi'),(110,13,'Millind M.','1996-08-09','M','Guide','54, Ram Gali , Kolkata'),(111,2,'Narendra Pratap','1989-03-23','M','Head_of_Department','24 RamGali Kolkata'),(112,13,'Aman Gupta','0000-00-00','M','Guide','22, Ram Gali , Kolkata'),(113,4,'Deepak Yadav','2001-03-20','M','Accountant','34,RajoriGarden, Hyderabad'),(114,4,'Kanika Khandelwal','1976-02-18','F','Head_of_Department','64,RajoriGarden, Hyderabad'),(115,11,'Shweta Arora','0000-00-00','F','Ticket_manager','3,RajoriGarden, Hyderabad'),(116,17,'Devang Kulshreshtha','1996-08-12','M','Software Engineer','IIT BHU Varanasi'),(117,5,'Mayank Kulshreshtha','1991-08-18','M','Part','Khargar,'),(118,5,'Vaishali Kulshreshtha','1991-08-18','M','Part','Khargar,'),(119,8,'Divyam Goyal','2000-09-09','M','Coder(Competitive)','Jaipur');
/*!40000 ALTER TABLE `EMPLOYEE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EMPLOYEECONTACT`
--

DROP TABLE IF EXISTS `EMPLOYEECONTACT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EMPLOYEECONTACT` (
  `Emp_ID` int(11) NOT NULL,
  `Phone` decimal(12,0) NOT NULL,
  PRIMARY KEY (`Emp_ID`,`Phone`),
  CONSTRAINT `EMPLOYEECONTACT_ibfk_1` FOREIGN KEY (`Emp_ID`) REFERENCES `EMPLOYEE` (`Emp_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMPLOYEECONTACT`
--

LOCK TABLES `EMPLOYEECONTACT` WRITE;
/*!40000 ALTER TABLE `EMPLOYEECONTACT` DISABLE KEYS */;
INSERT INTO `EMPLOYEECONTACT` VALUES (101,9324262925),(101,9345676542),(102,8453647348),(103,7324934642),(104,9327348234),(105,8234313433),(105,9342393732),(106,9342341323),(107,7342423423),(108,7693478673),(109,9465475698),(110,9577687346),(111,7984568435),(111,8594735434),(112,9453454222),(113,8976857321),(114,9864862322),(115,8328428423),(115,9946536224),(117,7873291011),(118,7873291011),(118,7879167693),(119,8974322628);
/*!40000 ALTER TABLE `EMPLOYEECONTACT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LIKE_GROUP`
--

DROP TABLE IF EXISTS `LIKE_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LIKE_GROUP` (
  `Visitor_ID` int(11) NOT NULL,
  `Dept_ID` int(11) NOT NULL,
  PRIMARY KEY (`Visitor_ID`,`Dept_ID`),
  KEY `Dept_ID` (`Dept_ID`),
  CONSTRAINT `LIKE_GROUP_ibfk_1` FOREIGN KEY (`Visitor_ID`) REFERENCES `VISITOR` (`Visitor_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `LIKE_GROUP_ibfk_2` FOREIGN KEY (`Dept_ID`) REFERENCES `DEPARTMENT` (`Dept_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LIKE_GROUP`
--

LOCK TABLES `LIKE_GROUP` WRITE;
/*!40000 ALTER TABLE `LIKE_GROUP` DISABLE KEYS */;
INSERT INTO `LIKE_GROUP` VALUES (7,1),(2,2),(9,5),(7,6),(12,6),(3,7),(12,10),(2,12),(2,13),(3,13);
/*!40000 ALTER TABLE `LIKE_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TICKET`
--

DROP TABLE IF EXISTS `TICKET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TICKET` (
  `Visitor_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Type` varchar(2) NOT NULL,
  `Number_of_tickets` int(11) NOT NULL DEFAULT '1',
  `Feedback` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Visitor_ID`,`Date`,`Type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TICKET`
--

LOCK TABLES `TICKET` WRITE;
/*!40000 ALTER TABLE `TICKET` DISABLE KEYS */;
INSERT INTO `TICKET` VALUES (1,'2016-10-27','N',2,'Very nice and cheap rates.'),(1,'2016-10-29','S',2,NULL),(1,'2016-11-22','N',2,''),(1,'2016-11-24','N',2,''),(1,'2016-12-12','N',1,'Very good collection of paintings'),(1,'2016-12-12','S',1,NULL),(1,'2016-12-31','S',2,''),(2,'2016-11-11','N',1,NULL),(4,'2016-10-28','N',3,NULL),(17,'2016-10-27','N',5,NULL);
/*!40000 ALTER TABLE `TICKET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VISIT`
--

DROP TABLE IF EXISTS `VISIT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VISIT` (
  `Visit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Visitor_ID` int(11) NOT NULL,
  `Feedback` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Visit_ID`),
  KEY `Visitor_ID` (`Visitor_ID`),
  CONSTRAINT `VISIT_ibfk_1` FOREIGN KEY (`Visitor_ID`) REFERENCES `VISITOR` (`Visitor_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VISIT`
--

LOCK TABLES `VISIT` WRITE;
/*!40000 ALTER TABLE `VISIT` DISABLE KEYS */;
INSERT INTO `VISIT` VALUES (3,2,'Very suffocated museum'),(4,3,'Very bad management system'),(5,4,'American arts were very fascnating !!'),(6,5,'Very expensive to visit'),(7,6,'Very suffocated museum'),(8,7,'Arts of Oceania and South Africa were very fascnating !!'),(9,8,'No collection in the costume institute'),(10,8,'Very expensive to visit'),(11,8,'Very suffocated museum'),(12,9,'Very diverse and big museum'),(13,10,'Very good selected collections'),(14,11,'Medival arts were very fascnating !!'),(15,11,'Very suffocated museum'),(16,12,'Islamic arts were very fascnating !!'),(17,13,'No relevant artworks in Asian Arts department'),(18,14,'Very expensive to visit'),(19,15,'Very original and old musical instruments'),(20,15,'Very suffocated museum'),(21,16,'Museum is very costly !!');
/*!40000 ALTER TABLE `VISIT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VISITOR`
--

DROP TABLE IF EXISTS `VISITOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VISITOR` (
  `Visitor_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  `Nationality` varchar(20) NOT NULL DEFAULT 'India',
  `Phone` decimal(12,0) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `Email` varchar(50) NOT NULL,
  PRIMARY KEY (`Visitor_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VISITOR`
--

LOCK TABLES `VISITOR` WRITE;
/*!40000 ALTER TABLE `VISITOR` DISABLE KEYS */;
INSERT INTO `VISITOR` VALUES (1,'Devang Kulshreshtha','Indian',7879167693,'IIIT','devang@gmail.com'),(2,'Mayank Agarwal','Pakistan ',9821320911,'IIIT HYDERABAD D.G. Hostel','Mayank.Agarwal.cse14@iitbhu.ac.in'),(3,'Apoorva Srivastava','America',7824261816,'IIIT HYDERABAD D.G. Hostel','Apoorva.Srivastava.cse14@iitbhu.ac.in'),(4,'Vaishali Sharma','France',7879167693,'IIT MADRAS Tansa Hostel','Vaishali.Sharma.cse14@iitbhu.ac.in'),(5,'Manansh Kulshreshtha','Indian',8449065782,'IIT MADRAS Tansa Hostel','Manansh.Kulshreshtha.cse14@iitbhu.ac.in'),(6,'Himangi Mehta','Colombia',7777666654,'IIT KHARAGPUR Tansa Hostel','Himangi.Mehta.cse14@iitbhu.ac.in'),(7,'Vayam Kumar','Germany',9876546796,'IIT KHARAGPUR Tansa Hostel','Vayam.Kumar.cse14@iitbhu.ac.in'),(8,'Yuvanshi Chaudhary','Indian',8652924629,'IIT KHARAGPUR Tansa Hostel','Yuvanshi.Chaudhary.cse14@iitbhu.ac.in'),(9,'Nitin Sharma','Germany',9826191361,'IIT KANPUR Ramanjaun Hostel','Nitin.Sharma.cse14@iitbhu.ac.in'),(10,'Shivani Kumar','Canada',8631232811,'IIT KANPUR Ramanjaun Hostel','Shivani.Kumar.cse14@iitbhu.ac.in'),(11,'Vibha Mathur','South Korea',9874281567,'IIT KANPUR Ramanjaun Hostel','Vibha.Mathur.cse14@iitbhu.ac.in'),(12,'Sagar Verma','India',8987656715,'IIT KANPUR Ramanjaun Hostel','Sagar.Verma.cse14@iitbhu.ac.in'),(13,'Amol Agarwal','Indian',9456462693,'IIT BHU Varanasi','Amol.Agarwal.cse14@iitbhu.ac.in'),(14,'Utkarsh Dubey','Canada',8765945612,'IIT BHU Varanasi','Utkarsh.Dubey.cse14@iitbhu.ac.in'),(15,'Shriyansh Singh Seng','Indian',9123492726,'IIT BHU Varanasi','Shriyansh.Singh.cse14@iitbhu.ac.in'),(16,'Arpit Chaudhary','Indain',9045881240,'Mathura Road','Arpit.Chaudhary.cse14@iitbhu.ac.in'),(17,'Deepak Yadav','Indian',7878654009,'Rajori Garden, New Delhi','Deepak.Yadav.cse14@iitbhu.ac.in'),(18,'Prateek Thakur','Indian',7822163110,'801,arya','prtk.pthakur@gmail.com'),(19,'shubham chaudharyyo','Indian',8544449999,'jodhpur','shubham@gmail.com');
/*!40000 ALTER TABLE `VISITOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add group',4,'add_group'),(11,'Can change group',4,'change_group'),(12,'Can delete group',4,'delete_group'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$30000$0b16QvIn4Hit$oKOgBpPKnDvybZS0Zg2/1ZCShtr1U1925FQ/LiDKHW0=','2016-10-21 10:37:26.810930',1,'deju','','','devang.kulshreshtha.cse14@itbhu.ac.in',1,1,'2016-10-19 18:37:30.131862'),(6,'pbkdf2_sha256$30000$j6YfbbtUalPd$NiN3XND/uuMIKZUIgipjKlGQJkhAMTwxV51DDSv5LpQ=','2016-10-22 10:05:11.337234',0,'Devang','','','Admin',0,1,'2016-10-20 15:01:35.357776'),(25,'pbkdf2_sha256$30000$EXSJvcJBhgMR$iPSiKfzVvXE2uMMnHrVFUzq3blVrBPtGaL8WwTfA1as=','2016-10-22 10:40:42.249371',0,'Devang Kulshreshtha','','','Visitor',0,1,'2016-10-21 11:26:35.897520'),(26,'pbkdf2_sha256$30000$tnUh1I0AQFzF$IKCzhecTY9+l79C09TswHwdLD9/rZ2sfPMAsk4Gwobk=','2016-10-21 12:56:59.540090',0,'Mayank Agarwal','','','Visitor',0,1,'2016-10-21 11:26:36.190616'),(27,'pbkdf2_sha256$30000$vficAjw0TO8j$ulpAb/nOdtiASkYvMACMHGcFgzEeoZK5lg83v5fGrCc=',NULL,0,'Apoorva Srivastava','','','Visitor',0,1,'2016-10-21 11:26:36.499333'),(28,'pbkdf2_sha256$30000$wCAuwb9wnrPU$/DiNWzyAEPGmZHII/W89lQ78VW/b0n9mNsuI6qKNbrQ=','2016-10-21 12:57:54.028948',0,'Vaishali Sharma','','','Visitor',0,1,'2016-10-21 11:26:36.776894'),(29,'pbkdf2_sha256$30000$lSNGzHYP8nLH$xn8aZuBT6qr89FeL/TEeJ/s/gAgzKO9qOhl5cHgWtUw=',NULL,0,'Manansh Kulshreshtha','','','Visitor',0,1,'2016-10-21 11:26:37.058891'),(30,'pbkdf2_sha256$30000$ryODHjVHdx39$C6IRYhVUiYy+0IQGdOPynHq+QbGsNvtyjdq8oDd7hg8=',NULL,0,'Himangi Mehta','','','Visitor',0,1,'2016-10-21 11:26:37.332215'),(31,'pbkdf2_sha256$30000$qCuagHwaJ6tu$A+alK0qKf6MaRFxylxnRS4VaLZ8n6145dBcj575NvQs=',NULL,0,'Vayam Kumar','','','Visitor',0,1,'2016-10-21 11:26:37.622809'),(32,'pbkdf2_sha256$30000$eyZ7E8qDeASZ$iBkLe+dKttc2hEsAo4hXNjByfphUdDmLQ6hwI6QD3pI=',NULL,0,'Yuvanshi Chaudhary','','','Visitor',0,1,'2016-10-21 11:26:37.931319'),(33,'pbkdf2_sha256$30000$cX4OIGbscWK8$1HhjTAPniYpCaJMzvVtl28IRmW7XP45ZO90tFwhYRSY=',NULL,0,'Nitin Sharma','','','Visitor',0,1,'2016-10-21 11:26:38.237777'),(34,'pbkdf2_sha256$30000$56wg65rDkdED$L0NfYCwfPaP3riTjwz2YkWO1R9RYT+/AUt/5eoiKkHY=',NULL,0,'Shivani Kumar','','','Visitor',0,1,'2016-10-21 11:26:38.521517'),(35,'pbkdf2_sha256$30000$qqxGwltv3jV2$VuSxbdltKsrYHzL8s4g5nFqKM9WklK3RjVJgN1AWYCA=',NULL,0,'Vibha Mathur','','','Visitor',0,1,'2016-10-21 11:26:38.811295'),(36,'pbkdf2_sha256$30000$ro39YxnB5GTw$xAm1fgehmCE5QZSNJJ+8XsB0RAhfElzztmw6Kz6mPDk=',NULL,0,'Sagar Verma','','','Visitor',0,1,'2016-10-21 11:26:39.103055'),(37,'pbkdf2_sha256$30000$WkHK43tJhPfy$jME+m6mF8ifxi/CS8fs47QU/m7lAMlFy6ehAthbIpDE=',NULL,0,'Amol Agarwal','','','Visitor',0,1,'2016-10-21 11:26:39.390200'),(38,'pbkdf2_sha256$30000$aTwNUqLhV7HB$o5T+nCNiW1hXkNihYQQfnyjfjQ+r+wj6+MlYSIuY5l8=',NULL,0,'Utkarsh Dubey','','','Visitor',0,1,'2016-10-21 11:26:39.676556'),(39,'pbkdf2_sha256$30000$YdWrKmJDaFDt$2OOKmiceZh4C+pi6lSSrURnnF5EcCQrZIgxtNoOcF6k=',NULL,0,'Shriyansh Singh Seng','','','Visitor',0,1,'2016-10-21 11:26:39.954831'),(40,'pbkdf2_sha256$30000$MEUt6s8etqPD$3a2RFwfTNJ7SYXWLmfbJzfLIWzFwYENkCrvlYUgjUxw=',NULL,0,'Arpit Chaudhary','','','Visitor',0,1,'2016-10-21 11:26:40.232629'),(41,'pbkdf2_sha256$30000$RVIafYHMR0CT$fTUn23NcXXYV0d7KJFGehrnGG4jeWTSDoxIJoU0zrxQ=','2016-10-22 10:04:50.955099',0,'Deepak Yadav','','','Visitor',0,1,'2016-10-21 11:30:02.919412'),(42,'pbkdf2_sha256$30000$Lb3vpsa2ca3q$7DE4ugoOsNrFv8TlTqVlQ5DmKxxSflD48Ee/bJBBeJ8=',NULL,0,'Prateek Thakur','','','Visitor',0,1,'2016-10-21 17:49:19.770001');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2016-10-20 13:46:05.087982','2','Devang',3,'',3,1),(2,'2016-10-20 13:57:36.695799','4','Devang',3,'',3,1),(3,'2016-10-20 15:01:17.789430','5','Devang',3,'',3,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(4,'auth','group'),(2,'auth','permission'),(3,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-10-19 18:36:08.397834'),(2,'auth','0001_initial','2016-10-19 18:36:16.596400'),(3,'admin','0001_initial','2016-10-19 18:36:18.326077'),(4,'admin','0002_logentry_remove_auto_add','2016-10-19 18:36:18.460907'),(5,'contenttypes','0002_remove_content_type_name','2016-10-19 18:36:20.452589'),(6,'auth','0002_alter_permission_name_max_length','2016-10-19 18:36:20.586916'),(7,'auth','0003_alter_user_email_max_length','2016-10-19 18:36:20.754061'),(8,'auth','0004_alter_user_username_opts','2016-10-19 18:36:20.874768'),(9,'auth','0005_alter_user_last_login_null','2016-10-19 18:36:21.447348'),(10,'auth','0006_require_contenttypes_0002','2016-10-19 18:36:21.469629'),(11,'auth','0007_alter_validators_add_error_messages','2016-10-19 18:36:21.540665'),(12,'auth','0008_alter_user_username_max_length','2016-10-19 18:36:21.904366'),(13,'sessions','0001_initial','2016-10-19 18:36:22.450394');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('zix3gfga4zsp4nzwhjtet8bjhx4d88hw','NzM1NGZiOGVhYmQ3NGI4YjMyYjg5MjI2ZmJjYmMzNjM1OTkzYjIxZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwNzE1Y2QwNGRiZWJjMGFkMjAyOTVjM2RmZmM3YjdlMGQwMmQzOGEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2016-11-04 17:49:12.947688');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-22 16:39:10
