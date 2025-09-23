# Acadify - Academic Record Management System

## Overview

Acadify is a comprehensive web-based academic record management system designed for Norzagaray College. The application manages academic records, grades, and administrative functions across multiple user roles including students, instructors, registrars, deans, and MIS/IT administrators. The system provides role-based dashboards and features like grade entry, dean's list management, user administration, and academic reporting.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture
- **Template Engine**: Jinja2 templates with Flask for server-side rendering
- **CSS Framework**: Custom CSS with CSS variables for theming support
- **JavaScript**: Vanilla JavaScript for theme management and interactive features
- **Theme System**: Dark/light mode toggle with system preference detection and localStorage persistence
- **Responsive Design**: Mobile-first approach with grid-based layouts

### Backend Architecture
- **Web Framework**: Flask with blueprints pattern for modular organization
- **Authentication**: Flask-Login for session management with role-based access control
- **Password Security**: Werkzeug for password hashing and verification
- **Database ORM**: SQLAlchemy for database abstraction and model relationships
- **Session Management**: Flask sessions with configurable secret key

### Database Design
- **Primary Database**: MySQL with PyMySQL connector
- **ORM Models**: SQLAlchemy models with relationships for users, grades, subjects, and academic records
- **User Roles**: Five distinct roles (student, instructor, registrar, dean, mis_it) with different permission levels
- **Academic Structure**: Support for multiple departments (BSCS, BEED, BSHM, BSED) with year levels and semesters

### Authentication & Authorization
- **Multi-Role System**: Role-based access control with distinct dashboards for each user type
- **Session Security**: Secure session management with configurable secret keys
- **Password Policy**: Hashed password storage using Werkzeug security utilities
- **Login Flow**: Centralized login with role-based redirection

### Application Structure
- **MVC Pattern**: Clear separation of models, views (templates), and controllers (routes)
- **Dashboard System**: Role-specific dashboards with tailored functionality for each user type
- **Grade Management**: Workflow for grade entry, approval, and dean's list calculation
- **Academic Reporting**: Comprehensive reporting system for registrars and administrators

## External Dependencies

### Core Dependencies
- **Flask**: Web application framework
- **Flask-SQLAlchemy**: Database ORM integration
- **Flask-Login**: User authentication and session management
- **PyMySQL**: MySQL database connector
- **Werkzeug**: Password security and utilities

### Database
- **MySQL**: Primary database system for academic record storage
- **Database Name**: acadify_db
- **Connection**: Local MySQL instance with root access

### Frontend Libraries
- **Google Fonts**: Inter font family for typography
- **Custom CSS**: No external CSS frameworks, using custom styling with CSS variables

### Development Environment
- **Environment Variables**: SESSION_SECRET for session security configuration
- **Static Assets**: Local image assets and custom JavaScript modules
- **Template System**: Jinja2 templates with inheritance and block structure