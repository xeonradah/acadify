-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: acadify_main
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `academic_years`
--

DROP TABLE IF EXISTS `academic_years`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academic_years` (
  `id` int NOT NULL AUTO_INCREMENT,
  `academic_year_name` varchar(20) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `academic_year_name` (`academic_year_name`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `academic_years_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_years`
--

LOCK TABLES `academic_years` WRITE;
/*!40000 ALTER TABLE `academic_years` DISABLE KEYS */;
INSERT INTO `academic_years` VALUES (1,'2025-2026','2025-10-24 04:48:11',2),(2,'2022-2023','2025-10-24 09:52:51',2);
/*!40000 ALTER TABLE `academic_years` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `resource_type` varchar(50) DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `description` text NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `status` varchar(20) NOT NULL DEFAULT 'success',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `idx_audit_log_action` (`action`),
  KEY `idx_audit_log_status` (`status`),
  KEY `idx_audit_log_created_at` (`created_at`),
  KEY `idx_audit_log_resource` (`resource_type`,`resource_id`),
  CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='System audit trail for all user actions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (1,4,'login',NULL,NULL,'User misit_demo logged in successfully','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:32:53'),(2,4,'create_student_account','Student',1,'Student account created by MIS/IT: 2022-0471 (2022-0471)','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:43:39'),(3,4,'logout',NULL,NULL,'User misit_demo logged out','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:47:37'),(4,1,'login',NULL,NULL,'User instructor_demo logged in successfully','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:47:44'),(5,1,'logout',NULL,NULL,'User instructor_demo logged out','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:50:26'),(6,4,'login',NULL,NULL,'User misit_demo logged in successfully','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:50:34'),(7,4,'create_student_account','Student',2,'Student account created by MIS/IT: 2022-0001 (2022-0001)','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:52:42'),(8,4,'logout',NULL,NULL,'User misit_demo logged out','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:54:55'),(9,1,'login',NULL,NULL,'User instructor_demo logged in successfully','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:54:58'),(10,2,'ASSIGN_SUBJECT',NULL,NULL,'Assigned subject English 1 to instructor Maria Santos for Section BSCS1A','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:55:29'),(11,2,'ASSIGN_SUBJECT',NULL,NULL,'Assigned subject KomFil to instructor Maria Santos for Section BSCS1A','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:55:59'),(12,2,'ASSIGN_SUBJECT',NULL,NULL,'Assigned subject History 1 to instructor Maria Santos for Section BSCS1A','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:56:36'),(13,2,'ASSIGN_SUBJECT',NULL,NULL,'Assigned subject CSC 1 to instructor Maria Santos for Section BSCS1A','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:57:20'),(14,2,'ASSIGN_SUBJECT',NULL,NULL,'Assigned subject CSC2 to instructor Maria Santos for Section BSCS1A','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:59:14'),(15,2,'ASSIGN_SUBJECT',NULL,NULL,'Assigned subject Math 1 to instructor Maria Santos for Section BSCS1A','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 00:59:37'),(16,2,'ASSIGN_SUBJECT',NULL,NULL,'Assigned subject P.E. 1 to instructor Maria Santos for Section BSCS1A','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:01:41'),(17,2,'ASSIGN_SUBJECT',NULL,NULL,'Assigned subject NSTP 1 to instructor Maria Santos for Section BSCS1A','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:02:08'),(18,2,'logout',NULL,NULL,'User registrar_demo logged out','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:03:46'),(19,4,'login',NULL,NULL,'User misit_demo logged in successfully','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:03:53'),(20,4,'logout',NULL,NULL,'User misit_demo logged out','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:06:17'),(21,NULL,'login_failed',NULL,NULL,'Failed login attempt for username: 2022-0471','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','failed','2025-10-26 01:06:26'),(22,1,'login',NULL,NULL,'User 2022-0471 logged in successfully','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:06:39'),(23,1,'logout',NULL,NULL,'User 2022-0471 logged out','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:12:31'),(24,2,'login',NULL,NULL,'User registrar_demo logged in successfully','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:12:34'),(25,1,'logout',NULL,NULL,'User instructor_demo logged out','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:39:52'),(26,3,'login',NULL,NULL,'User dean_demo logged in successfully','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:39:57'),(27,3,'logout',NULL,NULL,'User dean_demo logged out','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:47:47'),(28,2,'login',NULL,NULL,'User registrar_demo logged in successfully','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:48:00'),(29,2,'logout',NULL,NULL,'User registrar_demo logged out','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0','success','2025-10-26 01:48:44');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_assignment`
--

DROP TABLE IF EXISTS `class_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_assignment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_id` int NOT NULL,
  `instructor_id` int NOT NULL,
  `school_year` varchar(20) NOT NULL,
  `semester` int NOT NULL,
  `section` varchar(10) DEFAULT NULL,
  `schedule_time` varchar(50) DEFAULT NULL COMMENT 'e.g., 8:00 AM - 11:00 AM',
  `schedule_day` varchar(20) DEFAULT NULL COMMENT 'Monday, Tuesday, etc.',
  `room` varchar(20) DEFAULT NULL,
  `subject_type` varchar(20) DEFAULT 'Lecture' COMMENT 'Lecture or Laboratory',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_class_assignment` (`subject_id`,`instructor_id`,`school_year`,`semester`,`section`),
  UNIQUE KEY `unique_subject_section_assignment` (`subject_id`,`school_year`,`semester`,`section`),
  KEY `instructor_id` (`instructor_id`),
  KEY `idx_class_assignment_instructor` (`instructor_id`,`subject_id`,`school_year`,`semester`),
  CONSTRAINT `class_assignment_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE,
  CONSTRAINT `class_assignment_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Instructor assignments to subjects with schedule details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_assignment`
--

LOCK TABLES `class_assignment` WRITE;
/*!40000 ALTER TABLE `class_assignment` DISABLE KEYS */;
INSERT INTO `class_assignment` VALUES (3,9,1,'2022-2023',1,'BSCS1A','2:00 PM - 5:00 PM','Tuesday','EB301','Lecture','2025-10-26 00:55:29'),(4,14,1,'2022-2023',1,'BSCS1A','10:00 AM - 1:00 PM','Wednesday','EB302','Lecture','2025-10-26 00:55:59'),(5,11,1,'2022-2023',1,'BSCS1A','2:00 PM - 5:00 PM','Thursday','EB302','Lecture','2025-10-26 00:56:36'),(6,12,1,'2022-2023',1,'BSCS1A','10:00 AM - 1:00 PM','Saturday','CLA','Laboratory','2025-10-26 00:57:20'),(7,22,1,'2022-2023',1,'BSCS1A','7:00 AM - 10:00 AM','Friday','CLA','Laboratory','2025-10-26 00:59:14'),(8,10,1,'2022-2023',1,'BSCS1A','9:00 AM - 12:00 PM','Wednesday','EB302','Lecture','2025-10-26 00:59:37'),(9,15,1,'2022-2023',1,'BSCS1A','7:00 AM - 10:00 AM','Saturday','GYM','Lecture','2025-10-26 01:01:41'),(10,16,1,'2022-2023',1,'BSCS1A','9:00 AM - 12:00 PM','Monday','EB301','Lecture','2025-10-26 01:02:08');
/*!40000 ALTER TABLE `class_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curricula`
--

DROP TABLE IF EXISTS `curricula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curricula` (
  `id` int NOT NULL AUTO_INCREMENT,
  `curriculum_name` varchar(20) NOT NULL,
  `curriculum_description` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `curriculum_name` (`curriculum_name`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `curricula_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curricula`
--

LOCK TABLES `curricula` WRITE;
/*!40000 ALTER TABLE `curricula` DISABLE KEYS */;
INSERT INTO `curricula` VALUES (1,'BSCS 2022-2026','','2025-10-24 04:49:14',2);
/*!40000 ALTER TABLE `curricula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum_subjects`
--

DROP TABLE IF EXISTS `curriculum_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curriculum_subjects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `curriculum` varchar(20) NOT NULL,
  `year_level` int NOT NULL,
  `semester` int NOT NULL,
  `subject_id` int NOT NULL,
  `is_core` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_curriculum_subject` (`curriculum`,`year_level`,`semester`,`subject_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `curriculum_subjects_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum_subjects`
--

LOCK TABLES `curriculum_subjects` WRITE;
/*!40000 ALTER TABLE `curriculum_subjects` DISABLE KEYS */;
INSERT INTO `curriculum_subjects` VALUES (17,'BSCS 2022-2026',2,2,5,1,'2025-10-24 02:55:35');
/*!40000 ALTER TABLE `curriculum_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deans_list_record`
--

DROP TABLE IF EXISTS `deans_list_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deans_list_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL COMMENT 'References students.id (independent table)',
  `semester` int NOT NULL,
  `academic_year` varchar(10) NOT NULL,
  `gwa` float NOT NULL COMMENT 'General Weighted Average',
  `rank` int DEFAULT NULL,
  `total_units` int NOT NULL,
  `qualified` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  KEY `idx_deans_list_qualified` (`qualified`),
  KEY `idx_deans_list_rank` (`rank`),
  CONSTRAINT `deans_list_record_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Dean''s List academic achievers tracking';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deans_list_record`
--

LOCK TABLES `deans_list_record` WRITE;
/*!40000 ALTER TABLE `deans_list_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `deans_list_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encoding_exception`
--

DROP TABLE IF EXISTS `encoding_exception`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encoding_exception` (
  `id` int NOT NULL AUTO_INCREMENT,
  `instructor_id` int NOT NULL,
  `academic_year` varchar(10) NOT NULL,
  `semester` int NOT NULL,
  `grading_period` varchar(20) NOT NULL COMMENT 'all, prelim, midterm, final',
  `expiration_date` datetime NOT NULL,
  `reason` text,
  `granted_by` int NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `revoked_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instructor_id` (`instructor_id`),
  KEY `granted_by` (`granted_by`),
  KEY `idx_instructor_active` (`instructor_id`,`is_active`),
  KEY `idx_academic_period` (`academic_year`,`semester`,`grading_period`),
  CONSTRAINT `encoding_exception_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `encoding_exception_ibfk_2` FOREIGN KEY (`granted_by`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Special permissions for instructors to encode after schedule closure';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encoding_exception`
--

LOCK TABLES `encoding_exception` WRITE;
/*!40000 ALTER TABLE `encoding_exception` DISABLE KEYS */;
/*!40000 ALTER TABLE `encoding_exception` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment`
--

DROP TABLE IF EXISTS `enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL COMMENT 'References students.id (independent table)',
  `subject_id` int NOT NULL,
  `academic_year` varchar(10) NOT NULL,
  `semester` int NOT NULL,
  `enrollment_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT 'Active' COMMENT 'Active, Dropped, Completed',
  `enrolled_by` int DEFAULT NULL COMMENT 'Who enrolled the student (staff user)',
  `dropped_date` datetime DEFAULT NULL,
  `completion_date` datetime DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_enrollment` (`student_id`,`subject_id`,`academic_year`,`semester`),
  KEY `idx_enrollment_student` (`student_id`),
  KEY `idx_enrollment_subject` (`subject_id`),
  KEY `idx_enrollment_status` (`status`),
  KEY `enrollment_ibfk_3` (`enrolled_by`),
  KEY `idx_enrollment_lookup` (`student_id`,`academic_year`,`semester`,`status`),
  CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE,
  CONSTRAINT `enrollment_ibfk_3` FOREIGN KEY (`enrolled_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Student enrollment in subjects with status tracking';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grade`
--

DROP TABLE IF EXISTS `grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grade` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL COMMENT 'References students.id (independent table)',
  `subject_id` int NOT NULL,
  `prelim_grade` float DEFAULT NULL,
  `midterm_grade` float DEFAULT NULL,
  `final_grade` float DEFAULT NULL,
  `final_average` float DEFAULT NULL,
  `equivalent_grade` float DEFAULT NULL COMMENT 'GPA equivalent (1.00-5.00)',
  `remarks` varchar(20) DEFAULT NULL COMMENT 'Excellent, Outstanding, etc.',
  `semester` int NOT NULL,
  `academic_year` varchar(10) NOT NULL,
  `is_locked` tinyint(1) DEFAULT '0',
  `is_complete` tinyint(1) DEFAULT '0' COMMENT 'All three grades entered',
  `is_historical` tinyint(1) DEFAULT '0' COMMENT 'Imported from past records',
  `import_date` datetime DEFAULT NULL COMMENT 'When grade was imported',
  `import_source` varchar(50) DEFAULT NULL COMMENT 'CSV, Excel, Manual',
  `submitted_at` datetime DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `approved_by` int DEFAULT NULL COMMENT 'Staff user who approved the grade',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  KEY `subject_id` (`subject_id`),
  KEY `approved_by` (`approved_by`),
  KEY `idx_grade_student_subject` (`student_id`,`subject_id`),
  KEY `idx_grade_approved` (`approved_at`),
  KEY `idx_grade_is_complete` (`is_complete`),
  KEY `idx_grade_is_historical` (`is_historical`),
  KEY `idx_grade_lookup` (`student_id`,`subject_id`,`academic_year`,`semester`),
  CONSTRAINT `grade_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grade_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grade_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Student grades with historical tracking support';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grade`
--

LOCK TABLES `grade` WRITE;
/*!40000 ALTER TABLE `grade` DISABLE KEYS */;
INSERT INTO `grade` VALUES (1,1,9,98,85,88,90.33,1.75,'Very Good',1,'2022-2023',0,1,0,NULL,NULL,NULL,NULL,NULL,'2025-10-26 09:04:48'),(2,1,14,98,88,99,95,1.25,'Outstanding',1,'2022-2023',0,1,0,NULL,NULL,NULL,NULL,NULL,'2025-10-26 09:05:02'),(3,1,11,98,85,99,94,1.5,'Superior',1,'2022-2023',0,1,0,NULL,NULL,NULL,NULL,NULL,'2025-10-26 09:05:13'),(4,1,12,98,99,92,96.33,1.25,'Outstanding',1,'2022-2023',0,1,0,NULL,NULL,NULL,NULL,NULL,'2025-10-26 09:05:23'),(5,1,22,98,99,99,98.67,1,'Excellent',1,'2022-2023',0,1,0,NULL,NULL,NULL,NULL,NULL,'2025-10-26 09:05:34'),(6,1,10,95,99,99,97.67,1.25,'Outstanding',1,'2022-2023',0,1,0,NULL,NULL,NULL,NULL,NULL,'2025-10-26 09:05:45'),(7,1,15,95,99,88,94,1.5,'Superior',1,'2022-2023',0,1,0,NULL,NULL,NULL,NULL,NULL,'2025-10-26 09:05:58'),(8,1,16,98,85,99,94,1.5,'Superior',1,'2022-2023',0,1,0,NULL,NULL,NULL,NULL,NULL,'2025-10-26 09:06:08');
/*!40000 ALTER TABLE `grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grade_encoding_schedule`
--

DROP TABLE IF EXISTS `grade_encoding_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grade_encoding_schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `academic_year` varchar(10) NOT NULL,
  `semester` int NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `department` varchar(10) DEFAULT NULL COMMENT 'Specific department or NULL for all',
  `grading_period` varchar(20) DEFAULT 'all' COMMENT 'all, prelim, midterm, final',
  `status` varchar(20) NOT NULL DEFAULT 'upcoming' COMMENT 'upcoming, active, completed',
  `created_by` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `idx_schedule_status` (`status`),
  KEY `idx_schedule_dates` (`start_date`,`end_date`),
  CONSTRAINT `grade_encoding_schedule_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Manages grade encoding periods with time restrictions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grade_encoding_schedule`
--

LOCK TABLES `grade_encoding_schedule` WRITE;
/*!40000 ALTER TABLE `grade_encoding_schedule` DISABLE KEYS */;
INSERT INTO `grade_encoding_schedule` VALUES (1,'2025-2026',1,'2025-10-24 00:00:00','2025-10-25 00:00:00',NULL,NULL,'BSCS','all','completed',4,'2025-10-23 03:04:49','2025-10-25 10:44:59'),(2,'2022-2023',1,'2025-10-24 00:00:00','2025-10-25 00:00:00',NULL,NULL,'BSCS','all','completed',4,'2025-10-24 10:26:25','2025-10-25 10:45:03'),(3,'2022-2023',1,'2025-10-26 00:00:00','2025-10-27 00:00:00',NULL,NULL,'BSCS','all','active',4,'2025-10-25 10:45:24','2025-10-26 01:04:24');
/*!40000 ALTER TABLE `grade_encoding_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(50) DEFAULT 'info' COMMENT 'info, success, warning, error',
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `idx_notification_read` (`is_read`),
  KEY `idx_notification_created` (`created_at`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='User notification system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `section_name` varchar(10) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `section_name` (`section_name`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,'BSCS2A','2025-10-24 04:24:15',2),(2,'BSCS1A','2025-10-24 09:53:15',2),(3,'BSCS4A','2025-10-24 14:13:31',2),(4,'BSCS4B','2025-10-25 10:04:46',2);
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_enrollments`
--

DROP TABLE IF EXISTS `student_enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_enrollments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `academic_year` varchar(20) NOT NULL,
  `semester` int NOT NULL,
  `year_level` int NOT NULL,
  `section` varchar(10) DEFAULT NULL,
  `curriculum` varchar(20) DEFAULT NULL,
  `enrollment_date` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `enrolled_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_student_enrollment` (`student_id`,`academic_year`,`semester`),
  KEY `enrolled_by` (`enrolled_by`),
  CONSTRAINT `student_enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `student_enrollments_ibfk_2` FOREIGN KEY (`enrolled_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_enrollments`
--

LOCK TABLES `student_enrollments` WRITE;
/*!40000 ALTER TABLE `student_enrollments` DISABLE KEYS */;
INSERT INTO `student_enrollments` VALUES (1,1,'2025-2026',1,4,'BSCS4A','BSCS 2022-2026','2025-10-26 00:46:03','ACTIVE',2,'2025-10-26 00:46:03','2025-10-26 00:46:03'),(2,2,'2022-2023',1,1,'BSCS1A','BSCS 2022-2026','2025-10-26 00:53:59','ACTIVE',2,'2025-10-26 00:53:59','2025-10-26 00:53:59');
/*!40000 ALTER TABLE `student_enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_subjects`
--

DROP TABLE IF EXISTS `student_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_subjects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `academic_year` varchar(20) NOT NULL,
  `semester` int NOT NULL,
  `enrollment_date` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `enrolled_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_student_subject` (`student_id`,`subject_id`,`academic_year`,`semester`),
  KEY `subject_id` (`subject_id`),
  KEY `enrolled_by` (`enrolled_by`),
  CONSTRAINT `student_subjects_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `student_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`),
  CONSTRAINT `student_subjects_ibfk_3` FOREIGN KEY (`enrolled_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_subjects`
--

LOCK TABLES `student_subjects` WRITE;
/*!40000 ALTER TABLE `student_subjects` DISABLE KEYS */;
INSERT INTO `student_subjects` VALUES (9,1,9,'2025-2026',1,'2025-10-26 01:03:18','ENROLLED',2,'2025-10-26 01:03:18','2025-10-26 01:03:18'),(10,1,10,'2025-2026',1,'2025-10-26 01:03:18','ENROLLED',2,'2025-10-26 01:03:18','2025-10-26 01:03:18'),(11,1,11,'2025-2026',1,'2025-10-26 01:03:18','ENROLLED',2,'2025-10-26 01:03:18','2025-10-26 01:03:18'),(12,1,12,'2025-2026',1,'2025-10-26 01:03:18','ENROLLED',2,'2025-10-26 01:03:18','2025-10-26 01:03:18'),(13,1,13,'2025-2026',1,'2025-10-26 01:03:18','ENROLLED',2,'2025-10-26 01:03:18','2025-10-26 01:03:18'),(14,1,14,'2025-2026',1,'2025-10-26 01:03:18','ENROLLED',2,'2025-10-26 01:03:18','2025-10-26 01:03:18'),(15,1,15,'2025-2026',1,'2025-10-26 01:03:18','ENROLLED',2,'2025-10-26 01:03:18','2025-10-26 01:03:18'),(16,1,16,'2025-2026',1,'2025-10-26 01:03:18','ENROLLED',2,'2025-10-26 01:03:18','2025-10-26 01:03:18'),(17,1,22,'2025-2026',1,'2025-10-26 01:03:18','ENROLLED',2,'2025-10-26 01:03:18','2025-10-26 01:03:18');
/*!40000 ALTER TABLE `student_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `suffix` varchar(50) DEFAULT NULL,
  `student_id` varchar(20) NOT NULL COMMENT 'Student ID Number',
  `student_lrn` varchar(20) DEFAULT NULL COMMENT 'Learner Reference Number',
  `student_status` varchar(10) DEFAULT 'Regular' COMMENT 'New, Old, Regular, Irregular',
  `department` varchar(50) NOT NULL COMMENT 'BSCS, BEED, BSHM, BSED',
  `course` varchar(100) DEFAULT NULL,
  `year_level` int NOT NULL,
  `semester` int NOT NULL,
  `section` varchar(10) DEFAULT NULL,
  `section_type` varchar(50) DEFAULT NULL COMMENT 'Block Section, Regular, Irregular',
  `academic_year` varchar(20) NOT NULL DEFAULT '2025-2026',
  `curriculum` varchar(20) DEFAULT NULL,
  `graduating` varchar(10) DEFAULT 'No',
  `gender` varchar(10) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `date_birth` varchar(20) DEFAULT NULL,
  `place_birth` varchar(50) DEFAULT NULL,
  `nationality` varchar(20) DEFAULT 'Filipino',
  `religion` varchar(50) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `city_municipality` varchar(100) DEFAULT NULL,
  `barangay` varchar(50) DEFAULT NULL,
  `house_no` varchar(50) DEFAULT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  `enrollment_status` varchar(20) DEFAULT 'Active' COMMENT 'Active, Inactive, Graduated, Dropped',
  `total_units` int DEFAULT '0',
  `gwa` float DEFAULT NULL COMMENT 'General Weighted Average',
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_student_id` (`student_id`),
  UNIQUE KEY `unique_student_username` (`username`),
  UNIQUE KEY `unique_student_email` (`email`),
  KEY `idx_student_department` (`department`),
  KEY `idx_student_year_level` (`year_level`),
  KEY `idx_student_section` (`section`),
  KEY `idx_student_status` (`enrollment_status`),
  KEY `idx_student_academic` (`department`,`year_level`,`semester`,`academic_year`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='COMPLETELY INDEPENDENT student table with own authentication';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'2022-0471','markjhunramirez2@gmail.com','scrypt:32768:8:1$LqbmWVWg5I2ws11u$82db3216f19eef2d9f3f8c9fe65d36510f05a6f3763116de870ebee30cf0e67eaf429e734e8e9a910791522ef351802f3b11175f5cf0af7de849356edaaece45','Mark Jhun','Ababa','Ramirez','','2022-0471',NULL,'Regular','BSCS','Bachelor of Science in Computer Science',4,1,'BSCS4A','Block Section','2025-2026','BSCS 2022-2026','No','Male',22,'2003-10-25','Norzagaray Bulacan','Filipino','Born Again','Bulacan','Norzagaray','Bigte','0143 Upper Street','09677195989','ENROLLED',0,NULL,1,'2025-10-26 00:43:39','2025-10-26 00:46:03'),(2,'2022-0001','jared@gmail.com','scrypt:32768:8:1$ipCkhnon3k67etSp$cc1290233c10ce0108d7f14d0d9830e576bb5b182728ff1000e336cef4f0e100c64ad70319624cc7b5beab31aef92fc2286f812be9956f5541724a51536bfe1b','Jared','Languido','Diasanta','','2022-0001',NULL,'Regular','BSCS','Bachelor of Science in Computer Science',1,1,'BSCS1A','Block Section','2022-2023','BSCS 2022-2026','No','Male',17,'2007-04-14','Norzagaray Bulacan','Filipino','Born Again','Bulacan','Norzagaray','Bigte','0149 Upper Street','09787854575','ENROLLED',0,NULL,1,'2025-10-26 00:52:42','2025-10-26 00:53:59');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_code` varchar(20) NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `subject_type` varchar(20) DEFAULT NULL,
  `units` int NOT NULL,
  `department` varchar(10) NOT NULL,
  `year_level` int NOT NULL,
  `semester` int NOT NULL,
  `section` varchar(10) DEFAULT NULL,
  `academic_year` varchar(10) NOT NULL DEFAULT '2025-2026',
  `instructor_id` int DEFAULT NULL,
  `max_capacity` int DEFAULT '50' COMMENT 'Maximum number of students',
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject_code` (`subject_code`),
  KEY `instructor_id` (`instructor_id`),
  KEY `idx_subject_year_semester` (`year_level`,`semester`),
  KEY `idx_subject_department` (`department`),
  CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Course and subject information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES (4,'SE102','Software Engineering 2','Academic',3,'BSCS',4,1,'','2025-2026',5,50),(5,'OS101','Operating System','Academic',3,'BSCS',2,2,NULL,'2025-2026',1,50),(6,'ENVSCI','Environmental Science','Non Academic',3,'BSCS',2,2,NULL,'2025-2026',1,50),(7,'WEBDEV101','Web Development','Academic',3,'BSCS',2,2,NULL,'2025-2026',NULL,50),(8,'PE4','Team Sports and Recreational Activities','Non Academic',3,'BSCS',2,2,NULL,'2025-2026',NULL,50),(9,'English 1','Purposive Communication','Academic',3,'BSCS',1,1,NULL,'2025-2026',1,50),(10,'Math 1','Mathematics in the Modern World','Academic',3,'BSCS',1,1,NULL,'2025-2026',1,50),(11,'History 1','Readings in Philippine History','Academic',3,'BSCS',1,1,NULL,'2025-2026',1,50),(12,'CSC 1','Introduction to Computing','Academic',3,'BSCS',1,1,NULL,'2025-2026',1,50),(13,'Hum 1','Art Appriciation','Non Academic',3,'BSCS',1,1,NULL,'2025-2026',1,50),(14,'KomFil','Kontekstwalikadong Komunikasyon sa Pilipino','Non Academic',3,'BSCS',1,1,NULL,'2025-2026',1,50),(15,'P.E. 1','Physical Education','Non Academic',2,'BSCS',1,1,NULL,'2025-2026',1,50),(16,'NSTP 1','National Service Training Program 1','Non Academic',3,'BSCS',1,1,NULL,'2025-2026',1,50),(17,'AL102','Automa Theory and Formal Languages','Academic',3,'BSCS',4,1,NULL,'2025-2026',5,50),(18,'FRELEC103','Robotics','Academic',3,'BSCS',4,1,NULL,'2025-2026',5,50),(19,'FL101','Foreign Language','Non Academic',3,'BSCS',4,1,NULL,'2025-2026',5,50),(20,'THS101','CS Thesis Writing 1','Academic',3,'BSCS',4,1,NULL,'2025-2026',5,50),(21,'NC102','Network and Communication','Academic',3,'BSCS',4,1,NULL,'2025-2026',5,50),(22,'CSC2','Programming Fundamentals','Academic',3,'BSCS',1,1,NULL,'2025-2026',1,50);
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL COMMENT 'student, instructor, registrar, dean, mis_it',
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `suffix` varchar(50) DEFAULT NULL,
  `department` varchar(10) DEFAULT NULL COMMENT 'For instructors/staff',
  `mobile_no` varchar(20) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `theme_preference` varchar(10) DEFAULT 'light',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_user_role` (`role`),
  KEY `idx_user_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Clean user authentication table - student data moved to students table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'instructor_demo','instructor@norzagaray.edu.ph','scrypt:32768:8:1$IXbbilOkSlNozIbi$e4d66917cb670762e86c7f65d36a42bbfafa072cba0e35ed54ac2a92919b4afc1c93343c90a1219f6bf178a3c4fe1c332ba5c58c1665762a568cf110f13532a1','instructor','Maria',NULL,'Santos',NULL,'BSCS',NULL,1,'2025-10-23 10:48:41','light'),(2,'registrar_demo','registrar@norzagaray.edu.ph','scrypt:32768:8:1$kav2UChQC1r7XgpR$1a29c0988b6449814eb7a2647cc00936c0bf0d309a90df88613a5526e33ea25300c520722063048842c2a5ce3779b4a2d7ded7b83f202c07fc9a85377dfd8e53','registrar','Roberto',NULL,'Garcia',NULL,NULL,NULL,1,'2025-10-23 10:48:41','light'),(3,'dean_demo','dean@norzagaray.edu.ph','scrypt:32768:8:1$OPVTNCMrKkMyKH8d$ef1f5c6e88cfdc43356c35b741d41ce3c0c5f837d1cce5a4cac4a9cf6a40e7aefc649c8e11d8177eb75e5a901fedffbef918be61f8fb3d7ac4ecd0372ddaa855','dean','Elizabeth',NULL,'Reyes',NULL,NULL,NULL,1,'2025-10-23 10:48:41','light'),(4,'misit_demo','misit@norzagaray.edu.ph','scrypt:32768:8:1$dcyurA6czi7POoaP$442be24dcc6857e4cc7f893fe257a5e9ef081728a44259f54838932827cda233fa0640af1d31ea444ba0ebf5a111b9803d14f92dc4432f57ae30a8715d5b0810','mis_it','Carlos',NULL,'Lopez',NULL,NULL,NULL,1,'2025-10-23 10:48:41','light'),(5,'jerimylumibao@acadify.com','jerimylumibao@norzagaray.edu','scrypt:32768:8:1$T21icTI9HUPyRj1z$9fd8d19877c1c5a34fc3c4b6cced09e00f7bf4f3602f856a1dc9cdf251e3e4f1dbcb95769a0330c07a7381f261fd87a9d315a684edf684d9fb71abe8de7681f4','instructor','Jerimy','Santiago','Lumibao',NULL,'BSCS',NULL,1,'2025-10-23 03:04:18','light');
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

-- Dump completed on 2025-10-26 10:10:55
