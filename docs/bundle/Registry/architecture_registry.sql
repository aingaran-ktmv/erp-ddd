-- Architecture Registry (Domains 1–5)
-- Purpose: Track domain deliverables and versions.
CREATE TABLE IF NOT EXISTS architecture_registry (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    domain_no INT NOT NULL,
    domain_key VARCHAR(50) NOT NULL,
    title VARCHAR(150) NOT NULL,
    sql_path VARCHAR(255) NULL,
    md_path VARCHAR(255) NULL,
    html_path VARCHAR(255) NULL,
    version VARCHAR(50) NOT NULL DEFAULT 'v1',
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    UNIQUE KEY uq_domain_version (domain_no, version)
);

-- Seed current entries
INSERT INTO architecture_registry (domain_no, domain_key, title, sql_path, md_path, html_path, version, created_at, updated_at) VALUES
(1,'school','Domain 1 – School','Domain_1/domain_1_school.database.sql','Domain_1/domain_1_school.implementation.md','Domain_1/domain_1_school.prototype.html','v1','2025-10-19 02:13:04 UTC','2025-10-19 02:13:04 UTC'),
(2,'master','Domain 2 – Master','Domain_2/domain_2_master.database.sql','Domain_2/domain_2_master.implementation.md','Domain_2/domain_2_master.prototype.html','v1','2025-10-19 02:13:04 UTC','2025-10-19 02:13:04 UTC'),
(3,'plan','Domain 3 – Plan','Domain_3/domain_3_plan.database.sql','Domain_3/domain_3_plan.implementation.md',NULL,'v1','2025-10-19 02:13:04 UTC','2025-10-19 02:13:04 UTC'),
(4,'administration','Domain 4 – Administration','Domain_4/domain_4_administration.database.sql','Domain_4/domain_4_administration.implementation.md',NULL,'v1','2025-10-19 02:13:04 UTC','2025-10-19 02:13:04 UTC'),
(4,'reporting','Domain 4 – Reporting','Domain_4/domain_4_reporting.database.sql','Domain_4/domain_4_reporting.implementation.md',NULL,'v1','2025-10-19 02:13:04 UTC','2025-10-19 02:13:04 UTC'),
(5,'curriculum','Domain 5 – Curriculum','Domain_5/domain_5_curriculum.database.sql','Domain_5/domain_5_curriculum.implementation.md',NULL,'v1','2025-10-19 02:13:04 UTC','2025-10-19 02:13:04 UTC')
ON DUPLICATE KEY UPDATE updated_at=VALUES(updated_at);
