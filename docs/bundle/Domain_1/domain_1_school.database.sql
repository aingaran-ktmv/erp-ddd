-- ============================================================================
-- DOMAIN 1: SCHOOL - DATABASE BLUEPRINT (Reference Only)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. SCHOOLS
-- ----------------------------------------------------------------------------
CREATE TABLE schools (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    school_no VARCHAR(50) UNIQUE NOT NULL,
    school_census_no VARCHAR(50) UNIQUE NULL,
    school_name_en TEXT NOT NULL,
    school_name_ta TEXT NULL,
    school_name_si TEXT NULL,
    school_type ENUM('1AB','1C','type21','type2') NOT NULL,
    school_category ENUM('national','province','private','semigovernment') NOT NULL,
    division VARCHAR(100) NULL,
    zone VARCHAR(100) NULL,
    district VARCHAR(100) NULL,
    province VARCHAR(100) NULL,
    address TEXT NULL,
    phone VARCHAR(20) NULL,
    email VARCHAR(255) NULL,
    website VARCHAR(255) NULL,
    established_year YEAR NULL,
    geo_lat DECIMAL(10,8) NULL,
    geo_lng DECIMAL(11,8) NULL,
    school_map_url TEXT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_school_no (school_no),
    INDEX idx_school_census_no (school_census_no),
    INDEX idx_school_type (school_type),
    INDEX idx_school_category (school_category),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 2. SCHOOL_VISIONS
-- ----------------------------------------------------------------------------
CREATE TABLE school_visions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    school_id BIGINT UNSIGNED NOT NULL,
    year YEAR NOT NULL,
    vision_en TEXT NULL,
    vision_ta TEXT NULL,
    vision_si TEXT NULL,
    mission_en TEXT NULL,
    mission_ta TEXT NULL,
    mission_si TEXT NULL,
    motto_en TEXT NULL,
    motto_ta TEXT NULL,
    motto_si TEXT NULL,
    logo_url TEXT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    UNIQUE KEY unique_school_year (school_id, year),
    INDEX idx_school_id (school_id),
    INDEX idx_year (year),
    FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ============================================================================
-- DOMAIN 2: MASTER - DATABASE BLUEPRINT (Reference Only)
-- ============================================================================
-- This SQL is a conceptual blueprint. Do NOT execute directly.
-- Use the Laravel migrations in ai_guide_laravel_orm.md instead.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. USERS (Laravel default)
-- ----------------------------------------------------------------------------
-- Note: The users table is provided by Laravel's default migrations.
-- All foreign keys to users(id) in this blueprint assume BIGINT UNSIGNED id.
-- No custom users table is defined here.

-- ----------------------------------------------------------------------------
-- 2. DEPARTMENTS
-- ----------------------------------------------------------------------------
CREATE TABLE departments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    department_code VARCHAR(50) UNIQUE NOT NULL,
    name ENUM('administration','curriculum','co_curricular','finance','others') NOT NULL,
    description TEXT NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_department_code (department_code),
    INDEX idx_status (status),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 3. SUBJECTS
-- ----------------------------------------------------------------------------
CREATE TABLE subjects (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    subject_code VARCHAR(50) UNIQUE NOT NULL,
    name_en VARCHAR(200) NOT NULL,
    name_ta VARCHAR(200) NULL,
    name_si VARCHAR(200) NULL,
    subject_category ENUM('core','optional','extra_curricular') NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_subject_code (subject_code),
    INDEX idx_subject_category (subject_category),
    INDEX idx_status (status),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 4. SECTIONS (Top-level org structure with self-referencing)
-- ----------------------------------------------------------------------------
CREATE TABLE sections (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    section_code VARCHAR(50) UNIQUE NOT NULL,
    parent_id BIGINT UNSIGNED NULL COMMENT 'Self-referencing for flexible hierarchy',
    name VARCHAR(100) NOT NULL,
    description TEXT NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_section_code (section_code),
    INDEX idx_parent_id (parent_id),
    INDEX idx_status (status),
    FOREIGN KEY (parent_id) REFERENCES sections(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 5. SUBSECTIONS
-- ----------------------------------------------------------------------------
CREATE TABLE subsections (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    subsection_code VARCHAR(50) UNIQUE NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    parent_id BIGINT UNSIGNED NULL COMMENT 'Self-referencing for flexible hierarchy',
    name VARCHAR(100) NOT NULL,
    description TEXT NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_subsection_code (subsection_code),
    INDEX idx_section_id (section_id),
    INDEX idx_parent_id (parent_id),
    INDEX idx_status (status),
    FOREIGN KEY (section_id) REFERENCES sections(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES subsections(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 6. GRADES
-- ----------------------------------------------------------------------------
CREATE TABLE grades (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    grade_code VARCHAR(50) UNIQUE NOT NULL,
    subsection_id BIGINT UNSIGNED NULL,
    parent_id BIGINT UNSIGNED NULL COMMENT 'Self-referencing for flexible hierarchy',
    name VARCHAR(50) NOT NULL,
    order_no INTEGER NOT NULL DEFAULT 0,
    status ENUM('active','inactive') DEFAULT 'active',
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_grade_code (grade_code),
    INDEX idx_subsection_id (subsection_id),
    INDEX idx_parent_id (parent_id),
    INDEX idx_order_no (order_no),
    INDEX idx_status (status),
    FOREIGN KEY (subsection_id) REFERENCES subsections(id) ON DELETE SET NULL,
    FOREIGN KEY (parent_id) REFERENCES grades(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 7. CLASSES
-- ----------------------------------------------------------------------------
CREATE TABLE classes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    class_code VARCHAR(50) UNIQUE NOT NULL,
    grade_id BIGINT UNSIGNED NOT NULL,
    class_name VARCHAR(100) NOT NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_class_code (class_code),
    INDEX idx_grade_id (grade_id),
    INDEX idx_status (status),
    FOREIGN KEY (grade_id) REFERENCES grades(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 8. STAFF
-- ----------------------------------------------------------------------------
CREATE TABLE staff (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    emp_no VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender ENUM('male','female','other') NOT NULL,
    dob DATE NOT NULL,
    nic_no VARCHAR(20) UNIQUE NOT NULL,
    appointed_subject_id BIGINT UNSIGNED NULL,
    type_of_appointment ENUM('permanent','temporary','contract','substitute') NOT NULL,
    photo_url TEXT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_emp_no (emp_no),
    INDEX idx_nic_no (nic_no),
    INDEX idx_appointed_subject_id (appointed_subject_id),
    INDEX idx_is_active (is_active),
    FOREIGN KEY (appointed_subject_id) REFERENCES subjects(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 9. STUDENTS
-- ----------------------------------------------------------------------------
CREATE TABLE students (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    admission_no VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender ENUM('male','female','other') NOT NULL,
    dob DATE NOT NULL,
    guardian_name VARCHAR(200) NOT NULL,
    joined_date DATE NOT NULL,
    current_class_id BIGINT UNSIGNED NULL,
    photo_url TEXT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_admission_no (admission_no),
    INDEX idx_current_class_id (current_class_id),
    FOREIGN KEY (current_class_id) REFERENCES classes(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 10. STUDENT_CLASS_HISTORY (Historical tracking)
-- ----------------------------------------------------------------------------
CREATE TABLE student_class_history (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT UNSIGNED NOT NULL,
    class_id BIGINT UNSIGNED NOT NULL,
    academic_year VARCHAR(20) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_student_id (student_id),
    INDEX idx_class_id (class_id),
    INDEX idx_academic_year (academic_year),
    INDEX idx_dates (from_date, to_date),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 11. POSTS
-- ----------------------------------------------------------------------------
CREATE TABLE posts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    post_code VARCHAR(50) UNIQUE NOT NULL,
    name ENUM('principal','deputy_principal','assistant_principal','sectional_head',
              'subject_coordinator','class_teacher','subject_incharge','club_incharge',
              'secretary','treasurer','president','vice_president') NOT NULL,
    description TEXT NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_post_code (post_code),
    INDEX idx_status (status),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 12. RESOURCES
-- ----------------------------------------------------------------------------
CREATE TABLE resources (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    resource_code VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT NULL,
    type ENUM('room','equipment','vehicle','facility','other') NOT NULL,
    location TEXT NULL,
    status ENUM('available','in_use','maintenance','retired') DEFAULT 'available',
    capacity INTEGER NULL,
    photo_url TEXT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_resource_code (resource_code),
    INDEX idx_type (type),
    INDEX idx_status (status),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 13. RESOURCE_ASSIGNMENTS (Polymorphic)
-- ----------------------------------------------------------------------------
CREATE TABLE resource_assignments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    resource_id BIGINT UNSIGNED NOT NULL,
    assignable_type VARCHAR(255) NOT NULL COMMENT 'e.g., App\\Models\\Department, App\\Models\\Classes, App\\Models\\Lab',
    assignable_id BIGINT UNSIGNED NOT NULL,
    assigned_from DATE NOT NULL,
    assigned_to DATE NULL,
    purpose TEXT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_resource_id (resource_id),
    INDEX idx_assignable (assignable_type, assignable_id),
    INDEX idx_dates (assigned_from, assigned_to),
    FOREIGN KEY (resource_id) REFERENCES resources(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 14. CLUBS
-- ----------------------------------------------------------------------------
CREATE TABLE clubs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    club_code VARCHAR(50) UNIQUE NOT NULL,
    name_en VARCHAR(200) NOT NULL,
    name_ta VARCHAR(200) NULL,
    name_si VARCHAR(200) NULL,
    job_profile TEXT NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_club_code (club_code),
    INDEX idx_status (status),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 15. CLUB_STAFF (Many-to-Many: clubs ↔ staff)
-- ----------------------------------------------------------------------------
CREATE TABLE club_staff (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    club_id BIGINT UNSIGNED NOT NULL,
    staff_id BIGINT UNSIGNED NOT NULL,
    role ENUM('coordinator','assistant','advisor') NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_club_id (club_id),
    INDEX idx_staff_id (staff_id),
    INDEX idx_dates (from_date, to_date),
    UNIQUE KEY unique_club_staff_role (club_id, staff_id, role, from_date),
    FOREIGN KEY (club_id) REFERENCES clubs(id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 16. CLUB_STUDENTS (Many-to-Many: clubs ↔ students)
-- ----------------------------------------------------------------------------
CREATE TABLE club_students (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    club_id BIGINT UNSIGNED NOT NULL,
    student_id BIGINT UNSIGNED NOT NULL,
    role ENUM('president','vice_president','secretary','treasurer','member') NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_club_id (club_id),
    INDEX idx_student_id (student_id),
    INDEX idx_dates (from_date, to_date),
    UNIQUE KEY unique_club_student_role (club_id, student_id, role, from_date),
    FOREIGN KEY (club_id) REFERENCES clubs(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 17. ROUTINES
-- ----------------------------------------------------------------------------
CREATE TABLE routines (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    routine_code VARCHAR(50) UNIQUE NOT NULL,
    name_en VARCHAR(200) NOT NULL,
    name_ta VARCHAR(200) NULL,
    name_si VARCHAR(200) NULL,
    belongs_to ENUM('administration','curriculum','co_curricular','others') NOT NULL,
    type ENUM('daily','weekly','monthly','termly','annually') NOT NULL,
    description TEXT NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_routine_code (routine_code),
    INDEX idx_belongs_to (belongs_to),
    INDEX idx_type (type),
    INDEX idx_status (status),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ============================================================================
-- END OF DOMAIN 2: MASTER BLUEPRINT
-- ============================================================================
