-- ============================================================================
-- DOMAIN 4: ADMINISTRATION - DATABASE BLUEPRINT (Reference Only)
-- ============================================================================
-- Do NOT execute directly. Use the Laravel migrations in administration.md.
-- All audit foreign keys reference Laravel's default users(id).
-- References to staff, subjects, classes, and posts use id-based FKs.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. SUBJECT_GROUPS (assign_subject_group)
-- ----------------------------------------------------------------------------
CREATE TABLE subject_groups (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    group_code VARCHAR(50) UNIQUE NOT NULL,
    group_name VARCHAR(200) NOT NULL,
    year YEAR NOT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_subject_groups_year (year),
    INDEX idx_subject_groups_code (group_code),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 2. SUBJECT_PERIODS (assign_subject_period)
-- ----------------------------------------------------------------------------
CREATE TABLE subject_periods (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    subject_id BIGINT UNSIGNED NOT NULL,
    year YEAR NOT NULL,
    period_per_week TINYINT UNSIGNED NOT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    UNIQUE KEY unique_subject_year (subject_id, year),
    INDEX idx_subject_periods_subject_id (subject_id),
    INDEX idx_subject_periods_year (year),
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 3. PERIOD_TIME_SLOTS (assign_period_time_slot)
-- ----------------------------------------------------------------------------
CREATE TABLE period_time_slots (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    period_code VARCHAR(50) UNIQUE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    year YEAR NOT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_period_time_slots_year (year),
    INDEX idx_period_time_slots_code (period_code),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 4. STAFF_PINS (assign_employee)
-- ----------------------------------------------------------------------------
CREATE TABLE staff_pins (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    staff_id BIGINT UNSIGNED NOT NULL,
    year YEAR NOT NULL,
    pin VARCHAR(100) NOT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    UNIQUE KEY unique_staff_year (staff_id, year),
    INDEX idx_staff_pins_staff_id (staff_id),
    INDEX idx_staff_pins_year (year),
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 5. STAFF_DUTIES (assign_duty)
-- ----------------------------------------------------------------------------
CREATE TABLE staff_duties (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    staff_id BIGINT UNSIGNED NOT NULL,
    duty_code VARCHAR(50) UNIQUE NOT NULL,
    post_id BIGINT UNSIGNED NOT NULL,
    from_date DATE NULL,
    to_date DATE NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_staff_duties_staff_id (staff_id),
    INDEX idx_staff_duties_post_id (post_id),
    INDEX idx_staff_duties_dates (from_date, to_date),
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 6. CLASS_SUBJECTS (assign_subject_class)
-- ----------------------------------------------------------------------------
CREATE TABLE class_subjects (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    class_id BIGINT UNSIGNED NOT NULL,
    subject_id BIGINT UNSIGNED NOT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    UNIQUE KEY unique_class_subject (class_id, subject_id),
    INDEX idx_class_subjects_class_id (class_id),
    INDEX idx_class_subjects_subject_id (subject_id),
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 7. CLASS_TEACHERS (assign_class_teacher)
-- ----------------------------------------------------------------------------
CREATE TABLE class_teachers (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    staff_id BIGINT UNSIGNED NOT NULL,
    class_id BIGINT UNSIGNED NOT NULL,
    year YEAR NOT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    UNIQUE KEY unique_class_year (class_id, year),
    INDEX idx_class_teachers_staff_id (staff_id),
    INDEX idx_class_teachers_class_id (class_id),
    INDEX idx_class_teachers_year (year),
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 8. TEACHER_SUBJECT_CLASSES (assign_teacher_subject_class)
-- ----------------------------------------------------------------------------
CREATE TABLE teacher_subject_classes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    staff_id BIGINT UNSIGNED NOT NULL,
    subject_id BIGINT UNSIGNED NOT NULL,
    class_id BIGINT UNSIGNED NOT NULL,
    year YEAR NOT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    UNIQUE KEY unique_teacher_subject_class_year (staff_id, subject_id, class_id, year),
    INDEX idx_tsc_staff_id (staff_id),
    INDEX idx_tsc_subject_id (subject_id),
    INDEX idx_tsc_class_id (class_id),
    INDEX idx_tsc_year (year),
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 9. TIMETABLES (timetable)
-- ----------------------------------------------------------------------------
CREATE TABLE timetables (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    class_id BIGINT UNSIGNED NOT NULL,
    subject_id BIGINT UNSIGNED NOT NULL,
    period_time_slot_id BIGINT UNSIGNED NOT NULL,
    week_day TINYINT UNSIGNED NOT NULL COMMENT '1=Mon ... 7=Sun',
    staff_id BIGINT UNSIGNED NOT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    UNIQUE KEY unique_timetable_slot (class_id, week_day, period_time_slot_id),
    INDEX idx_timetables_class_id (class_id),
    INDEX idx_timetables_subject_id (subject_id),
    INDEX idx_timetables_staff_id (staff_id),
    INDEX idx_timetables_week_day (week_day),
    INDEX idx_timetables_period_slot (period_time_slot_id),
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE RESTRICT,
    FOREIGN KEY (period_time_slot_id) REFERENCES period_time_slots(id) ON DELETE RESTRICT,
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 10. EVENTS (event)
-- ----------------------------------------------------------------------------
CREATE TABLE events (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    event_code VARCHAR(50) UNIQUE NOT NULL,
    description TEXT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    responsibility VARCHAR(200) NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_events_code (event_code),
    INDEX idx_events_date (event_date),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 11. DAILY_SUBSTITUTIONS (daily_substitution)
-- ----------------------------------------------------------------------------
CREATE TABLE daily_substitutions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    sub_date DATE NOT NULL,
    class_id BIGINT UNSIGNED NOT NULL,
    period_no TINYINT UNSIGNED NOT NULL,
    original_staff_id BIGINT UNSIGNED NOT NULL,
    substitute_staff_id BIGINT UNSIGNED NOT NULL,
    reason TEXT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    UNIQUE KEY unique_substitution_slot (sub_date, class_id, period_no),
    INDEX idx_daily_subs_date (sub_date),
    INDEX idx_daily_subs_class_id (class_id),
    INDEX idx_daily_subs_period_no (period_no),
    INDEX idx_daily_subs_original_staff (original_staff_id),
    INDEX idx_daily_subs_substitute_staff (substitute_staff_id),
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
    FOREIGN KEY (original_staff_id) REFERENCES staff(id) ON DELETE RESTRICT,
    FOREIGN KEY (substitute_staff_id) REFERENCES staff(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ============================================================================
-- END OF DOMAIN 4: ADMINISTRATION BLUEPRINT
-- ============================================================================
