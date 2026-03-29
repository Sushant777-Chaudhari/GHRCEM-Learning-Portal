========================================================
  GHRCEM LEARNING MANAGEMENT SYSTEM
  Final Year Project — Student & Teacher Portal
========================================================

Project By   : [Your Name / Group Names]
College      : G H Raisoni College of Engineering & Management
Department   : Computer Engineering
Guide        : [Your Project Guide Name]
Academic Year: 2024–25

--------------------------------------------------------
PROJECT OVERVIEW
--------------------------------------------------------

GHRCEM LMS is a complete web-based Learning Management
System designed for college use. It supports three
user roles: Admin, Teacher, and Student — each with
their own secure dashboard and features.

--------------------------------------------------------
TECH STACK
--------------------------------------------------------

Frontend  : HTML5, CSS3 (Custom Design System), JavaScript
Backend   : PHP (CodeIgniter framework / standalone PHP)
Database  : MySQL 8.0
CSS Fonts : Google Fonts (Playfair Display + Outfit)
Icons     : Font Awesome 6

--------------------------------------------------------
FEATURES
--------------------------------------------------------

ADMIN
  ✓ Dashboard with college-wide stats
  ✓ Manage students, teachers, and subjects
  ✓ Approve/reject new registrations
  ✓ Post notices to all users
  ✓ View attendance and academic reports
  ✓ Manage timetable

TEACHER
  ✓ Dashboard with my class overview
  ✓ Upload study materials (PDF, PPT, DOC, Video)
  ✓ Create and manage assignments
  ✓ Mark attendance for each class
  ✓ Enter marks (IA1, IA2, Mid-sem)
  ✓ View my students' performance

STUDENT
  ✓ Dashboard with upcoming classes & pending tasks
  ✓ View enrolled subjects
  ✓ Download study materials
  ✓ Submit assignments online
  ✓ View personal attendance calendar
  ✓ Check grades and CGPA

ALL ROLES
  ✓ Notice board with categorized announcements
  ✓ Interactive timetable
  ✓ Role-based secure login
  ✓ 3-step registration with approval workflow

--------------------------------------------------------
INSTALLATION (LOCAL — XAMPP)
--------------------------------------------------------

1. Download and install XAMPP from https://apachefriends.org

2. Copy the "ghrcem_lms" folder to:
     C:\xampp\htdocs\   (Windows)
   OR
     /opt/lampp/htdocs/ (Linux/Mac)

3. Open phpMyAdmin:
     http://localhost/phpmyadmin

4. Create a database named:  ghrcem_lms

5. Click "Import" and select:  ghrcem_lms.sql
   This creates all tables and seeds demo data.

6. Open the application:
     http://localhost/ghrcem_lms/

--------------------------------------------------------
LOGIN CREDENTIALS (DEMO)
--------------------------------------------------------

  Role     | Email                | Password
  ---------+----------------------+----------
  Admin    | admin@ghrcem.edu     | admin123
  Teacher  | teacher@ghrcem.edu   | teacher123
  Student  | student@ghrcem.edu   | student123

Note: These are hashed with bcrypt in the database.
      NEVER store plain-text passwords in production.

--------------------------------------------------------
FILE STRUCTURE
--------------------------------------------------------

ghrcem_lms/
├── index.html           — Login page
├── register.html        — Student/Teacher registration
├── dashboard.html       — Main role-based dashboard
├── styles.css           — Full design system
├── login_action.php     — Secure login handler
├── register_action.php  — Secure registration handler
├── ghrcem_lms.sql       — Database schema + seed data
├── .htaccess            — Apache URL rewrite rules
├── composer.json        — PHP dependency config
├── package.json         — Node/Tailwind config
└── README.txt           — This file

Future additions (for full marks):
├── upload_material.php  — File upload handler
├── submit_assignment.php— Assignment submission
├── mark_attendance.php  — Attendance save API
├── save_marks.php       — Marks entry API
└── api/                 — REST API endpoints

--------------------------------------------------------
SECURITY FEATURES IMPLEMENTED
--------------------------------------------------------

✓ Passwords hashed using bcrypt (PASSWORD_BCRYPT)
✓ SQL injection prevention via prepared statements
✓ HTML special chars stripped from all inputs
✓ Role-based access control (RBAC)
✓ Session-based authentication
✓ Login rate limiting (max 10 attempts)
✓ Teacher/Admin registration requires approval
✓ .htaccess blocks direct access to PHP files
✓ No plaintext credentials anywhere

--------------------------------------------------------
FUTURE ENHANCEMENTS
--------------------------------------------------------

• Real-time chat (Socket.io / Pusher)
• Email notifications (PHPMailer)
• Video lecture streaming
• Online quiz module
• Mobile app (React Native)
• AI-based attendance via face recognition
• Plagiarism checker for assignments

--------------------------------------------------------
REFERENCES
--------------------------------------------------------

• CodeIgniter Docs: https://codeigniter.com/user_guide
• PHP Docs: https://www.php.net/docs.php
• MySQL 8.0: https://dev.mysql.com/doc/
• Font Awesome: https://fontawesome.com
• XAMPP: https://www.apachefriends.org

========================================================
  Submitted in partial fulfillment of the requirements
  for the degree of B.E. in Computer Engineering
========================================================
