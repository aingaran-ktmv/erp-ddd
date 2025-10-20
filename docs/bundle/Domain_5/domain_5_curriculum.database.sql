-- =========================================================
-- Domain 5: Curriculum Implementation
-- Module: daily_periods_complete
-- Purpose: Record whether a scheduled period was conducted.
-- Global standard: every table has `id` PK + audit fields.
-- =========================================================
CREATE TABLE IF NOT EXISTS daily_periods_complete (
    id               BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    class_code       VARCHAR(50) NOT NULL,              -- FK → school_class_structure(class_code)
    date             DATE NOT NULL,
    period           SMALLINT UNSIGNED NOT NULL,        -- 1..N (validated against timetable)
    is_conducted     BOOLEAN NOT NULL DEFAULT FALSE,

    -- Audit / soft-delete
    created_by       BIGINT UNSIGNED NULL,
    updated_by       BIGINT UNSIGNED NULL,
    deleted_by       BIGINT UNSIGNED NULL,
    created_at       TIMESTAMP NULL,
    updated_at       TIMESTAMP NULL,
    deleted_at       TIMESTAMP NULL,
    soft_delete      BOOLEAN NOT NULL DEFAULT FALSE,

    -- Logical uniqueness: one record per class + day + period
    UNIQUE KEY uq_dpc_class_date_period (class_code, date, period),

    -- Helpful filters
    INDEX idx_dpc_date (date),
    INDEX idx_dpc_class_date (class_code, date),

    CONSTRAINT fk_dpc_class
        FOREIGN KEY (class_code)
        REFERENCES school_class_structure(class_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
