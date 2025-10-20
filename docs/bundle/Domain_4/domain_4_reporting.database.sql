-- =========================================================
-- Domain 4: Reporting
-- Purpose: store report definitions, schedules, and execution logs
-- Standards: id PK + audit fields; references Filament 4 / Laravel 11.
-- =========================================================

CREATE TABLE IF NOT EXISTS report_definitions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(100) NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT NULL,
    sql_text LONGTEXT NOT NULL,             -- safe parameterized SQL or view name
    format ENUM('table','chart','export') DEFAULT 'table',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    soft_delete BOOLEAN NOT NULL DEFAULT FALSE,

    UNIQUE KEY uq_report_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS report_schedules (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    report_id BIGINT UNSIGNED NOT NULL,
    cron VARCHAR(100) NOT NULL,             -- e.g. '0 6 * * *'
    channel ENUM('email','storage') DEFAULT 'storage',
    target VARCHAR(255) NULL,               -- email(s) or storage path
    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    soft_delete BOOLEAN NOT NULL DEFAULT FALSE,

    INDEX idx_rs_report_id (report_id),
    CONSTRAINT fk_rs_report FOREIGN KEY (report_id) REFERENCES report_definitions(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS report_runs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    report_id BIGINT UNSIGNED NOT NULL,
    ran_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('success','failed') NOT NULL,
    message TEXT NULL,
    output_path VARCHAR(255) NULL,          -- optional saved CSV/XLSX path

    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    soft_delete BOOLEAN NOT NULL DEFAULT FALSE,

    INDEX idx_rr_report_id (report_id),
    CONSTRAINT fk_rr_report FOREIGN KEY (report_id) REFERENCES report_definitions(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Example analytical view (consumes Domain 5 conducted data)
CREATE OR REPLACE VIEW vw_daily_periods_conducted_rate AS
SELECT class_code, date,
       SUM(CASE WHEN is_conducted THEN 1 ELSE 0 END) AS periods_conducted,
       COUNT(*) AS periods_total,
       ROUND(SUM(CASE WHEN is_conducted THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0) * 100, 2) AS completion_rate
FROM daily_periods_complete
GROUP BY class_code, date;
