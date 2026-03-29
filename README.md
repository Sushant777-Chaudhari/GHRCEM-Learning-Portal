# 🎓 GHRCEM Learning Management System

> A complete web-based LMS built for G H Raisoni College of Engineering & Management — supporting Admins, Teachers, and Students through one unified platform.

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [Tech Stack](#-tech-stack)
- [Features](#-features)
- [Getting Started](#-getting-started)
- [Demo Login Credentials](#-demo-login-credentials)
- [File Structure](#-file-structure)
- [Security](#-security)
- [Future Enhancements](#-future-enhancements)
- [References](#-references)

---

## 🌐 Project Overview

**GHRCEM LMS** is a full-featured Learning Management System designed for college use. It provides three distinct portals — **Admin**, **Teacher**, and **Student** — each with a secure, role-based dashboard tailored to their needs.

| Detail | Info |
|---|---|
| 🏫 College | G H Raisoni College of Engineering & Management |
| 🖥️ Department | Computer Engineering |
| 📅 Academic Year | 2024–25 |

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Frontend | HTML5, CSS3 (Custom Design System), JavaScript |
| Backend | PHP (CodeIgniter / Standalone PHP) |
| Database | MySQL 8.0 |
| Fonts | Google Fonts — Playfair Display + Outfit |
| Icons | Font Awesome 6 |

---

## ✨ Features

### 👨‍💼 Admin
- Dashboard with college-wide statistics
- Manage students, teachers, and subjects
- Approve or reject new registrations
- Post notices to all users
- View attendance and academic reports
- Manage class timetables

### 👩‍🏫 Teacher
- Dashboard with class overview
- Upload study materials (PDF, PPT, DOC, Video)
- Create and manage assignments
- Mark attendance for each class
- Enter marks (IA1, IA2, Mid-Sem)
- View student performance

### 🎒 Student
- Dashboard with upcoming classes and pending tasks
- View enrolled subjects
- Download study materials
- Submit assignments online
- View personal attendance calendar
- Check grades and CGPA

### 🔄 All Roles
- Categorized notice board
- Interactive timetable
- Role-based secure login
- 3-step registration with approval workflow

---

## 🚀 Getting Started

### Prerequisites
- [XAMPP](https://apachefriends.org) installed on your machine

### Installation Steps

**1. Clone or download the project**
```
Place the "ghrcem_lms" folder inside your XAMPP htdocs directory:
  - Windows → C:\xampp\htdocs\
  - Linux/Mac → /opt/lampp/htdocs/
```

**2. Set up the database**
```
Open phpMyAdmin → http://localhost/phpmyadmin
Create a new database named: ghrcem_lms
Click "Import" → select the file: ghrcem_lms.sql
```
> This will create all tables and load demo seed data automatically.

**3. Launch the application**
```
http://localhost/ghrcem_lms/
```

---

## 🔑 Demo Login Credentials

| Role | Email | Password |
|---|---|---|
| 👨‍💼 Admin | admin@ghrcem.edu | admin123 |
| 👩‍🏫 Teacher | teacher@ghrcem.edu | teacher123 |
| 🎒 Student | student@ghrcem.edu | student123 |

> ⚠️ **Note:** All passwords are hashed using `bcrypt` in the database. Never store plain-text passwords in production.

---

## 📁 File Structure

```
ghrcem_lms/
│
├── index.html              → Login page
├── register.html           → Student/Teacher registration
├── dashboard.html          → Main role-based dashboard
├── styles.css              → Full design system
│
├── login_action.php        → Secure login handler
├── register_action.php     → Secure registration handler
│
├── ghrcem_lms.sql          → Database schema + seed data
├── .htaccess               → Apache URL rewrite rules
├── composer.json           → PHP dependency config
├── package.json            → Node/Tailwind config
└── README.md               → Project documentation
│
└── 📂 Planned (Future)
    ├── upload_material.php     → File upload handler
    ├── submit_assignment.php   → Assignment submission
    ├── mark_attendance.php     → Attendance save API
    ├── save_marks.php          → Marks entry API
    └── api/                    → REST API endpoints
```

---

## 🔒 Security

This project implements multiple layers of security:

| Feature | Status |
|---|---|
| Passwords hashed with `bcrypt` | ✅ |
| SQL Injection prevention via prepared statements | ✅ |
| HTML special characters stripped from all inputs | ✅ |
| Role-Based Access Control (RBAC) | ✅ |
| Session-based authentication | ✅ |
| Login rate limiting (max 10 attempts) | ✅ |
| Teacher/Admin registration requires approval | ✅ |
| `.htaccess` blocks direct access to PHP files | ✅ |
| No plain-text credentials stored anywhere | ✅ |

---

## 🔮 Future Enhancements

- 💬 Real-time chat (Socket.io / Pusher)
- 📧 Email notifications (PHPMailer)
- 🎥 Video lecture streaming
- 📝 Online quiz module
- 📱 Mobile app (React Native)
- 🤖 AI-based attendance via face recognition
- 🔍 Plagiarism checker for assignments

---

## 📚 References

- [CodeIgniter Documentation](https://codeigniter.com/user_guide)
- [PHP Documentation](https://www.php.net/docs.php)
- [MySQL 8.0 Reference](https://dev.mysql.com/doc/)
- [Font Awesome Icons](https://fontawesome.com)
- [XAMPP](https://www.apachefriends.org)

---

<p align="center">
  Submitted in partial fulfillment of the requirements for the degree of <br>
  <strong>B.E. in Computer Engineering</strong> · Academic Year 2024–25 <br>
  G H Raisoni College of Engineering & Management
</p>
