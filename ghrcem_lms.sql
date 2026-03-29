-- ============================================================
-- GHRCEM Learning Management System — Database Schema
-- Database: ghrcem_lms
-- ============================================================

CREATE DATABASE IF NOT EXISTS ghrcem_lms DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ghrcem_lms;

-- ─── USERS TABLE ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(120) NOT NULL,
    email           VARCHAR(180) NOT NULL UNIQUE,
    password        VARCHAR(255) NOT NULL,
    role            ENUM('admin','teacher','student') NOT NULL DEFAULT 'student',
    department      VARCHAR(100),
    year_designation VARCHAR(60),
    roll_no         VARCHAR(30),
    mobile          VARCHAR(15),
    profile_photo   VARCHAR(255) DEFAULT NULL,
    is_approved     TINYINT(1) DEFAULT 0,
    status          ENUM('active','inactive','pending','suspended') DEFAULT 'pending',
    last_login      DATETIME DEFAULT NULL,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role),
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- ─── SUBJECTS TABLE ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS subjects (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(150) NOT NULL,
    code        VARCHAR(20) NOT NULL UNIQUE,
    department  VARCHAR(100),
    year        ENUM('FE','SE','TE','BE') NOT NULL,
    semester    TINYINT,
    credits     TINYINT DEFAULT 4,
    teacher_id  INT,
    description TEXT,
    is_active   TINYINT(1) DEFAULT 1,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (teacher_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_dept (department),
    INDEX idx_year (year)
) ENGINE=InnoDB;

-- ─── STUDENT-SUBJECT ENROLLMENT ────────────────────────────
CREATE TABLE IF NOT EXISTS enrollments (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    student_id  INT NOT NULL,
    subject_id  INT NOT NULL,
    enrolled_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_enrollment (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ─── STUDY MATERIALS ───────────────────────────────────────
CREATE TABLE IF NOT EXISTS materials (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    subject_id   INT NOT NULL,
    teacher_id   INT NOT NULL,
    title        VARCHAR(200) NOT NULL,
    description  TEXT,
    file_name    VARCHAR(255),
    file_path    VARCHAR(500),
    file_size    INT,                  -- in bytes
    file_type    VARCHAR(50),          -- pdf, doc, ppt, video, zip
    download_count INT DEFAULT 0,
    is_active    TINYINT(1) DEFAULT 1,
    created_at   DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_subject (subject_id)
) ENGINE=InnoDB;

-- ─── ASSIGNMENTS ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS assignments (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    subject_id   INT NOT NULL,
    teacher_id   INT NOT NULL,
    title        VARCHAR(200) NOT NULL,
    instructions TEXT,
    file_path    VARCHAR(500) DEFAULT NULL,
    max_marks    INT DEFAULT 25,
    due_date     DATETIME NOT NULL,
    status       ENUM('active','closed','draft') DEFAULT 'active',
    created_at   DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ─── ASSIGNMENT SUBMISSIONS ─────────────────────────────────
CREATE TABLE IF NOT EXISTS submissions (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    assignment_id INT NOT NULL,
    student_id    INT NOT NULL,
    file_path     VARCHAR(500),
    remarks       TEXT,
    marks_obtained DECIMAL(5,2) DEFAULT NULL,
    feedback      TEXT,
    submitted_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    graded_at     DATETIME DEFAULT NULL,
    UNIQUE KEY uq_submission (assignment_id, student_id),
    FOREIGN KEY (assignment_id) REFERENCES assignments(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ─── ATTENDANCE ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS attendance (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    student_id  INT NOT NULL,
    subject_id  INT NOT NULL,
    teacher_id  INT NOT NULL,
    date        DATE NOT NULL,
    status      ENUM('present','absent','late') DEFAULT 'absent',
    remarks     VARCHAR(200) DEFAULT NULL,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_attendance (student_id, subject_id, date),
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_date (date),
    INDEX idx_student (student_id)
) ENGINE=InnoDB;

-- ─── MARKS / GRADES ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS marks (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    student_id   INT NOT NULL,
    subject_id   INT NOT NULL,
    semester     TINYINT,
    ia1_marks    DECIMAL(5,2) DEFAULT 0,
    ia2_marks    DECIMAL(5,2) DEFAULT 0,
    midsem_marks DECIMAL(5,2) DEFAULT 0,
    endsem_marks DECIMAL(5,2) DEFAULT 0,
    total_marks  DECIMAL(5,2) GENERATED ALWAYS AS (ia1_marks + ia2_marks + midsem_marks) STORED,
    grade        VARCHAR(5),
    grade_points DECIMAL(3,1),
    is_published TINYINT(1) DEFAULT 0,
    updated_at   DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_marks (student_id, subject_id, semester),
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ─── NOTICES ───────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS notices (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(300) NOT NULL,
    body        TEXT,
    posted_by   INT NOT NULL,
    type        ENUM('general','exam','event','academic','placement','holiday','finance') DEFAULT 'general',
    is_important TINYINT(1) DEFAULT 0,
    visible_to  SET('student','teacher','admin') DEFAULT 'student,teacher,admin',
    expires_at  DATETIME DEFAULT NULL,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (posted_by) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ─── TIMETABLE ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS timetable (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    subject_id  INT NOT NULL,
    teacher_id  INT NOT NULL,
    department  VARCHAR(100),
    year        ENUM('FE','SE','TE','BE'),
    day_of_week ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'),
    start_time  TIME,
    end_time    TIME,
    room        VARCHAR(50),
    type        ENUM('Lecture','Lab','Tutorial','Guidance') DEFAULT 'Lecture',
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ─── ACTIVITY LOG ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS activity_log (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT,
    action      VARCHAR(50),
    details     TEXT,
    ip_address  VARCHAR(45),
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_user (user_id),
    INDEX idx_action (action),
    INDEX idx_created (created_at)
) ENGINE=InnoDB;

-- ============================================================
-- SEED DATA — Demo Users
-- Passwords are bcrypt hashes of: admin123 / teacher123 / student123
-- ============================================================

INSERT INTO users (name, email, password, role, department, is_approved, status) VALUES
('Dr. R. K. Sharma',   'admin@ghrcem.edu',   '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin',   'Administration', 1, 'active'),
('Prof. S. Kulkarni',  'teacher@ghrcem.edu', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'teacher', 'Computer Engineering', 1, 'active'),
('Rahul Patil',        'student@ghrcem.edu', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'student', 'Computer Engineering', 1, 'active');

-- Seed Subjects
INSERT INTO subjects (name, code, department, year, semester, credits, teacher_id) VALUES
('Data Structures & Algorithms', 'CS301', 'Computer Engineering', 'SE', 3, 4, 2),
('Computer Networks',            'CS401', 'Computer Engineering', 'TE', 5, 4, 2),
('Database Management Systems',  'CS302', 'Computer Engineering', 'SE', 3, 3, 2),
('Operating Systems',            'CS303', 'Computer Engineering', 'SE', 4, 4, 2),
('Software Engineering',         'CS501', 'Computer Engineering', 'BE', 7, 4, 2);

-- Seed Notices
INSERT INTO notices (title, body, posted_by, type, is_important) VALUES
('Mid-Semester Examination Schedule Released', 'The mid-semester examination for all branches will be held from Nov 18–22, 2024. Please check your respective schedule.', 1, 'exam', 1),
('Cultural Fest Registration — Resonance 2024', 'Registration for Resonance 2024 is now open. Last date: Nov 15, 2024.', 1, 'event', 0),
('Industry Visit — Infosys Pune on 15th Nov', 'Eligible final year students should register for the Infosys campus visit. Contact placement cell.', 1, 'placement', 0);
