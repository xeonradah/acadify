-- =====================================================
-- ACADIFY - Complete Academic Information System
-- Database Structure v2.0
-- =====================================================
-- Description: Clean, normalized database with proper separation
-- Created: October 22, 2025
-- Updated: December 2025 - Complete structure with all tables
-- =====================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS acadify_main;
USE acadify_main;

-- =====================================================
-- CORE TABLES
-- =====================================================

-- -----------------------------------------------------
-- Table: user (Authentication and Basic Info)
-- Purpose: Login credentials for ALL users (MISIT, REGISTRAR, DEAN, INSTRUCTOR)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  
  -- Authentication
  `username` varchar(80) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL COMMENT 'instructor, registrar, dean, mis_it',
  
  -- Basic Information (All Users)
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `suffix` varchar(50) DEFAULT NULL,
  
  -- Common Fields (Applicable to All Roles)
  `department` varchar(10) DEFAULT NULL COMMENT 'For instructors/staff',
  `mobile_no` varchar(20) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `theme_preference` varchar(10) DEFAULT 'light',
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_user_role` (`role`),
  KEY `idx_user_active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Staff authentication table - student data moved to students table';

-- -----------------------------------------------------
-- Table: students (COMPLETELY INDEPENDENT Student Table)
-- Purpose: Student authentication and all student data - NO dependency on user table
-- -----------------------------------------------------
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  
  -- Authentication (Independent from User table)
  `username` varchar(80) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  
  -- Basic Information
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `suffix` varchar(50) DEFAULT NULL,
  
  -- Student Identity
  `student_id` varchar(20) NOT NULL COMMENT 'Student ID Number',
  `student_lrn` varchar(20) DEFAULT NULL COMMENT 'Learner Reference Number',
  `student_status` varchar(10) DEFAULT 'Regular' COMMENT 'New, Old, Regular, Irregular',
  
  -- Academic Information
  `department` varchar(50) NOT NULL COMMENT 'BSCS, BEED, BSHM, BSED',
  `course` varchar(100) DEFAULT NULL,
  `year_level` int NOT NULL,
  `semester` int NOT NULL,
  `section` varchar(10) DEFAULT NULL,
  `section_type` varchar(50) DEFAULT NULL COMMENT 'Block Section, Regular, Irregular',
  `academic_year` varchar(10) NOT NULL DEFAULT '2025-2026',
  `curriculum` varchar(50) DEFAULT NULL COMMENT 'e.g., BSCS 2022-2026',
  `graduating` varchar(10) DEFAULT 'No',
  
  -- Personal Information
  `gender` varchar(10) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `date_birth` varchar(20) DEFAULT NULL,
  `place_birth` varchar(50) DEFAULT NULL,
  `nationality` varchar(20) DEFAULT 'Filipino',
  `religion` varchar(50) DEFAULT NULL,
  
  -- Address Information
  `province` varchar(100) DEFAULT NULL,
  `city_municipality` varchar(100) DEFAULT NULL,
  `barangay` varchar(50) DEFAULT NULL,
  `house_no` varchar(50) DEFAULT NULL,
  
  -- Contact Information
  `mobile_no` varchar(20) DEFAULT NULL,
  
  -- Status and Tracking
  `enrollment_status` varchar(20) DEFAULT 'Active' COMMENT 'Active, Inactive, Graduated, Dropped',
  `total_units` int DEFAULT 0,
  `gwa` float DEFAULT NULL COMMENT 'General Weighted Average',
  `active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_student_id` (`student_id`),
  UNIQUE KEY `unique_student_username` (`username`),
  UNIQUE KEY `unique_student_email` (`email`),
  KEY `idx_student_department` (`department`),
  KEY `idx_student_year_level` (`year_level`),
  KEY `idx_student_section` (`section`),
  KEY `idx_student_status` (`enrollment_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='COMPLETELY INDEPENDENT student table with own authentication';

-- =====================================================
-- ACADEMIC TABLES
-- =====================================================

-- -----------------------------------------------------
-- Table: subject (Course/Subject Information)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_code` varchar(20) NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `subject_type` varchar(20) NOT NULL DEFAULT 'Academic' COMMENT 'Academic or Non Academic',
  `units` int NOT NULL,
  `department` varchar(10) NOT NULL,
  `year_level` int NOT NULL,
  `semester` int NOT NULL,
  `section` varchar(10) DEFAULT NULL,
  `academic_year` varchar(10) NOT NULL DEFAULT '2025-2026',
  `instructor_id` int DEFAULT NULL,
  `max_capacity` int DEFAULT 50 COMMENT 'Maximum number of students',
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject_code` (`subject_code`),
  KEY `instructor_id` (`instructor_id`),
  KEY `idx_subject_year_semester` (`year_level`, `semester`),
  KEY `idx_subject_department` (`department`),
  CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Course and subject information';

-- -----------------------------------------------------
-- Table: class_assignment (Instructor-Subject Assignment)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `class_assignment`;
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
  UNIQUE KEY `unique_subject_section_assignment` (`subject_id`, `school_year`, `semester`, `section`),
  KEY `instructor_id` (`instructor_id`),
  CONSTRAINT `class_assignment_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE,
  CONSTRAINT `class_assignment_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Instructor assignments to subjects with schedule details';

-- -----------------------------------------------------
-- Table: enrollment (Student Course Enrollment)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment`;
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
  `notes` text DEFAULT NULL,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_enrollment` (`student_id`, `subject_id`, `academic_year`, `semester`),
  KEY `idx_enrollment_student` (`student_id`),
  KEY `idx_enrollment_subject` (`subject_id`),
  KEY `idx_enrollment_status` (`status`),
  CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE,
  CONSTRAINT `enrollment_ibfk_3` FOREIGN KEY (`enrolled_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Student enrollment in subjects with status tracking';

-- -----------------------------------------------------
-- Table: student_enrollments (Student Enrollment per Academic Year)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `student_enrollments`;
CREATE TABLE `student_enrollments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `academic_year` varchar(20) NOT NULL,
  `semester` int NOT NULL,
  `year_level` int NOT NULL,
  `section` varchar(10) DEFAULT NULL,
  `curriculum` varchar(20) DEFAULT NULL,
  `enrollment_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT 'ACTIVE' COMMENT 'ACTIVE, DROPPED, COMPLETED',
  `enrolled_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_student_enrollment` (`student_id`, `academic_year`, `semester`),
  KEY `idx_enrollment_student` (`student_id`),
  KEY `idx_enrollment_academic_year` (`academic_year`),
  KEY `idx_enrollment_status` (`status`),
  CONSTRAINT `student_enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_enrollments_ibfk_2` FOREIGN KEY (`enrolled_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Student enrollment tracking per academic year and semester';

-- -----------------------------------------------------
-- Table: student_subjects (Many-to-Many Student-Subject Relationship)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `student_subjects`;
CREATE TABLE `student_subjects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `academic_year` varchar(20) NOT NULL,
  `semester` int NOT NULL,
  `enrollment_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT 'ENROLLED' COMMENT 'ENROLLED, DROPPED, COMPLETED',
  `enrolled_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_student_subject` (`student_id`, `subject_id`, `academic_year`, `semester`),
  KEY `idx_student_subjects_student` (`student_id`),
  KEY `idx_student_subjects_subject` (`subject_id`),
  KEY `idx_student_subjects_academic_year` (`academic_year`),
  CONSTRAINT `student_subjects_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_subjects_ibfk_3` FOREIGN KEY (`enrolled_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Many-to-many relationship between students and subjects';

-- -----------------------------------------------------
-- Table: grade (Student Grades)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grade`;
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
  `is_locked` tinyint(1) DEFAULT 0,
  `is_complete` tinyint(1) DEFAULT 0 COMMENT 'All three grades entered',
  `is_historical` tinyint(1) DEFAULT 0 COMMENT 'Imported from past records',
  `import_date` datetime DEFAULT NULL COMMENT 'When grade was imported',
  `import_source` varchar(50) DEFAULT NULL COMMENT 'CSV, Excel, Manual',
  `submitted_at` datetime DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `approved_by` int DEFAULT NULL COMMENT 'Staff user who approved the grade',
  
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  KEY `subject_id` (`subject_id`),
  KEY `approved_by` (`approved_by`),
  KEY `idx_grade_student_subject` (`student_id`, `subject_id`),
  KEY `idx_grade_approved` (`approved_at`),
  KEY `idx_grade_is_complete` (`is_complete`),
  KEY `idx_grade_is_historical` (`is_historical`),
  CONSTRAINT `grade_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grade_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grade_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Student grades with historical tracking support';

-- -----------------------------------------------------
-- Table: sections (Available Sections)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sections`;
CREATE TABLE `sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `section_name` varchar(10) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `section_name` (`section_name`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Available sections for class assignments';

-- -----------------------------------------------------
-- Table: curricula (Available Curricula)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `curricula`;
CREATE TABLE `curricula` (
  `id` int NOT NULL AUTO_INCREMENT,
  `curriculum_name` varchar(20) NOT NULL,
  `curriculum_description` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `curriculum_name` (`curriculum_name`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `curricula_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Available curricula for students';

-- -----------------------------------------------------
-- Table: academic_years (Available Academic Years)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `academic_years`;
CREATE TABLE `academic_years` (
  `id` int NOT NULL AUTO_INCREMENT,
  `academic_year_name` varchar(20) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `academic_year_name` (`academic_year_name`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `academic_years_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Available academic years';

-- =====================================================
-- ADMINISTRATIVE TABLES
-- =====================================================

-- -----------------------------------------------------
-- Table: grade_encoding_schedule (Grade Entry Periods)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grade_encoding_schedule`;
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
  KEY `idx_schedule_dates` (`start_date`, `end_date`),
  CONSTRAINT `grade_encoding_schedule_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Manages grade encoding periods with time restrictions';

-- -----------------------------------------------------
-- Table: encoding_exception (Grade Entry Exceptions)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `encoding_exception`;
CREATE TABLE `encoding_exception` (
  `id` int NOT NULL AUTO_INCREMENT,
  `instructor_id` int NOT NULL,
  `academic_year` varchar(10) NOT NULL,
  `semester` int NOT NULL,
  `grading_period` varchar(20) NOT NULL COMMENT 'all, prelim, midterm, final',
  `expiration_date` datetime NOT NULL,
  `reason` text,
  `granted_by` int NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `revoked_at` datetime DEFAULT NULL,
  
  PRIMARY KEY (`id`),
  KEY `instructor_id` (`instructor_id`),
  KEY `granted_by` (`granted_by`),
  KEY `idx_instructor_active` (`instructor_id`, `is_active`),
  KEY `idx_academic_period` (`academic_year`, `semester`, `grading_period`),
  CONSTRAINT `encoding_exception_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `encoding_exception_ibfk_2` FOREIGN KEY (`granted_by`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Special permissions for instructors to encode after schedule closure';

-- =====================================================
-- TRACKING AND AUDIT TABLES
-- =====================================================

-- -----------------------------------------------------
-- Table: audit_log (System Activity Logging)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `audit_log`;
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
  KEY `idx_audit_log_resource` (`resource_type`, `resource_id`),
  CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='System audit trail for all user actions';

-- -----------------------------------------------------
-- Table: deans_list_record (Academic Excellence Tracking)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `deans_list_record`;
CREATE TABLE `deans_list_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL COMMENT 'References students.id (independent table)',
  `semester` int NOT NULL,
  `academic_year` varchar(10) NOT NULL,
  `gwa` float NOT NULL COMMENT 'General Weighted Average',
  `rank` int DEFAULT NULL,
  `total_units` int NOT NULL,
  `qualified` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  KEY `idx_deans_list_qualified` (`qualified`),
  KEY `idx_deans_list_rank` (`rank`),
  CONSTRAINT `deans_list_record_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='Dean\'s List academic achievers tracking';

-- -----------------------------------------------------
-- Table: notification (User Notifications)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(50) DEFAULT 'info' COMMENT 'info, success, warning, error',
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `idx_notification_read` (`is_read`),
  KEY `idx_notification_created` (`created_at`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
COMMENT='User notification system';

-- =====================================================
-- DEMO DATA (Optional - for testing)
-- =====================================================

-- Insert Demo Users (STAFF ONLY - No Students)
INSERT INTO `user` (username, email, password_hash, role, first_name, last_name, department, active) VALUES
('instructor_demo', 'instructor@norzagaray.edu.ph', 'scrypt:32768:8:1$IXbbilOkSlNozIbi$e4d66917cb670762e86c7f65d36a42bbfafa072cba0e35ed54ac2a92919b4afc1c93343c90a1219f6bf178a3c4fe1c332ba5c58c1665762a568cf110f13532a1', 'instructor', 'Maria', 'Santos', 'BSCS', 1),
('registrar_demo', 'registrar@norzagaray.edu.ph', 'scrypt:32768:8:1$kav2UChQC1r7XgpR$1a29c0988b6449814eb7a2647cc00936c0bf0d309a90df88613a5526e33ea25300c520722063048842c2a5ce3779b4a2d7ded7b83f202c07fc9a85377dfd8e53', 'registrar', 'Roberto', 'Garcia', NULL, 1),
('dean_demo', 'dean@norzagaray.edu.ph', 'scrypt:32768:8:1$OPVTNCMrKkMyKH8d$ef1f5c6e88cfdc43356c35b741d41ce3c0c5f837d1cce5a4cac4a9cf6a40e7aefc649c8e11d8177eb75e5a901fedffbef918be61f8fb3d7ac4ecd0372ddaa855', 'dean', 'Elizabeth', 'Reyes', NULL, 1),
('misit_demo', 'misit@norzagaray.edu.ph', 'scrypt:32768:8:1$dcyurA6czi7POoaP$442be24dcc6857e4cc7f893fe257a5e9ef081728a44259f54838932827cda233fa0640af1d31ea444ba0ebf5a111b9803d14f92dc4432f57ae30a8715d5b0810', 'mis_it', 'Carlos', 'Lopez', NULL, 1);

-- Insert Demo Student Record (COMPLETELY INDEPENDENT - No user_id)
INSERT INTO `students` (username, email, password_hash, first_name, last_name, student_id, department, year_level, semester, academic_year, student_status, enrollment_status, active) VALUES
('student_demo', 'student@norzagaray.edu.ph', 'scrypt:32768:8:1$hQcT3Mi0lWkNki80$6e0652d05bef8660408787a501aa9e5f133510ff33fbd08813cf23f0951bf37df52e42f02037b448a2e6d711f3ed658b938e97d4f92948b6f20802e4e9f90b43', 'Juan', 'Dela Cruz', '2021-0001', 'BSCS', 3, 1, '2025-2026', 'Old', 'Active', 1);

-- =====================================================
-- INDEXES FOR PERFORMANCE
-- =====================================================

-- Additional composite indexes for common queries
CREATE INDEX idx_enrollment_lookup ON enrollment(student_id, academic_year, semester, status);
CREATE INDEX idx_grade_lookup ON grade(student_id, subject_id, academic_year, semester);
CREATE INDEX idx_student_academic ON students(department, year_level, semester, academic_year);

-- =====================================================
-- DATABASE INFORMATION
-- =====================================================

/*
DATABASE: acadify_main (v2.0 - COMPLETE STRUCTURE)
PURPOSE: Complete Academic Information System for Norzagaray College

MIGRATION STATUS: ✅ PRODUCTION READY

FEATURES:
✅ Complete independence between User and Student tables
✅ Clean user table - ONLY staff authentication (MIS/IT, Registrar, Dean, Instructor)
✅ Complete student data in dedicated students table with own authentication
✅ Proper enrollment tracking system (references students table)
✅ Subject offering and capacity management
✅ Grade encoding with schedule management
✅ Historical grade import support
✅ Bulk import functionality (CSV) - creates independent student records
✅ Audit logging for all actions
✅ Dean's List tracking (references students table)
✅ Multi-role support (student, instructor, registrar, dean, mis_it)
✅ Section management
✅ Curriculum management
✅ Academic year management

TABLE STRUCTURE:

CORE TABLES:
1. user - Staff authentication (instructor, registrar, dean, mis_it)
2. students - Student authentication and data (INDEPENDENT)

ACADEMIC TABLES:
3. subject - Course/subject information
4. class_assignment - Instructor-subject assignments
5. enrollment - Student course enrollments
6. student_enrollments - Student enrollment per academic year
7. student_subjects - Many-to-many student-subject relationship
8. grade - Student grades with historical tracking
9. sections - Available sections
10. curricula - Available curricula
11. academic_years - Available academic years

ADMINISTRATIVE TABLES:
12. grade_encoding_schedule - Grade encoding periods
13. encoding_exception - Grade entry exceptions

TRACKING TABLES:
14. audit_log - System activity logging
15. deans_list_record - Dean's List tracking
16. notification - User notifications

TOTAL: 16 tables

FOREIGN KEY RELATIONSHIPS:
✅ enrollment.student_id → students.id
✅ grade.student_id → students.id
✅ deans_list_record.student_id → students.id
✅ class_assignment.instructor_id → user.id
✅ subject.instructor_id → user.id
✅ All staff-related tables reference user.id

LOGIN METHODS:
✅ Staff (User table): Username + password
✅ Students (Students table): Username OR Student ID + password
✅ Flask-Login handles both with prefixed IDs (user_X, student_Y)

DEMO ACCOUNTS:
STAFF (User table):
- instructor_demo / instructor123
- registrar_demo / registrar123  
- dean_demo / dean123
- misit_demo / misit123

STUDENTS (Students table - independent):
- student_demo / student123 (can also login with: 2021-00001)

STATUS: ✅ PRODUCTION READY
VERSION: 2.0
UPDATED: December 2025
CREATED BY: MIS/IT Department
*/
