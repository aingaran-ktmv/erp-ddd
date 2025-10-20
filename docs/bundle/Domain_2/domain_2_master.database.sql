-- ============================================================================
-- DOMAIN 3: PLAN - DATABASE BLUEPRINT (Reference Only)
-- ============================================================================
-- This SQL is a conceptual blueprint. Do NOT execute directly.
-- Use the Laravel migrations in plan.md instead.
-- All audit foreign keys reference Laravel's default users(id).
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. KPIS
-- ----------------------------------------------------------------------------
CREATE TABLE kpis (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    kpi_code VARCHAR(50) UNIQUE NOT NULL,
    name_en VARCHAR(200) NOT NULL,
    name_ta VARCHAR(200) NULL,
    name_si VARCHAR(200) NULL,
    unit VARCHAR(50) NOT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_kpi_code (kpi_code),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 2. DATA_SOURCES
-- ----------------------------------------------------------------------------
CREATE TABLE data_sources (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    data_source_code VARCHAR(50) UNIQUE NOT NULL,
    name_en VARCHAR(200) NOT NULL,
    name_ta VARCHAR(200) NULL,
    name_si VARCHAR(200) NULL,
    description TEXT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_data_source_code (data_source_code),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 3. RISKS
-- ----------------------------------------------------------------------------
CREATE TABLE risks (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    risk_code VARCHAR(50) UNIQUE NOT NULL,
    name_en VARCHAR(200) NOT NULL,
    name_ta VARCHAR(200) NULL,
    name_si VARCHAR(200) NULL,
    category VARCHAR(100) NULL,
    description TEXT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_risk_code (risk_code),
    INDEX idx_risk_category (category),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 4. THRUST_AREAS
-- ----------------------------------------------------------------------------
CREATE TABLE thrust_areas (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    title_en VARCHAR(200) NOT NULL,
    title_ta VARCHAR(200) NULL,
    title_si VARCHAR(200) NULL,
    description TEXT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_thrust_area_code (code),
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 5. COMPONENTS
-- ----------------------------------------------------------------------------
CREATE TABLE components (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    thrust_area_id BIGINT UNSIGNED NOT NULL,
    code VARCHAR(50) UNIQUE NOT NULL,
    title_en VARCHAR(200) NOT NULL,
    title_ta VARCHAR(200) NULL,
    title_si VARCHAR(200) NULL,
    description TEXT NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_component_code (code),
    INDEX idx_component_thrust_area_id (thrust_area_id),
    FOREIGN KEY (thrust_area_id) REFERENCES thrust_areas(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 6. IMPACTS
-- ----------------------------------------------------------------------------
CREATE TABLE impacts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    component_id BIGINT UNSIGNED NOT NULL,
    code VARCHAR(50) UNIQUE NOT NULL,
    title_en VARCHAR(200) NOT NULL,
    title_ta VARCHAR(200) NULL,
    title_si VARCHAR(200) NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_impact_code (code),
    INDEX idx_impact_component_id (component_id),
    FOREIGN KEY (component_id) REFERENCES components(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 7. OUTCOMES
-- ----------------------------------------------------------------------------
CREATE TABLE outcomes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    impact_id BIGINT UNSIGNED NOT NULL,
    kpi_id BIGINT UNSIGNED NULL,
    data_source_id BIGINT UNSIGNED NULL,
    risk_id BIGINT UNSIGNED NULL,
    code VARCHAR(50) UNIQUE NOT NULL,
    title_en VARCHAR(200) NOT NULL,
    title_ta VARCHAR(200) NULL,
    title_si VARCHAR(200) NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_outcome_code (code),
    INDEX idx_outcome_impact_id (impact_id),
    INDEX idx_outcome_kpi_id (kpi_id),
    INDEX idx_outcome_data_source_id (data_source_id),
    INDEX idx_outcome_risk_id (risk_id),
    FOREIGN KEY (impact_id) REFERENCES impacts(id) ON DELETE CASCADE,
    FOREIGN KEY (kpi_id) REFERENCES kpis(id) ON DELETE SET NULL,
    FOREIGN KEY (data_source_id) REFERENCES data_sources(id) ON DELETE SET NULL,
    FOREIGN KEY (risk_id) REFERENCES risks(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 8. OUTPUTS
-- ----------------------------------------------------------------------------
CREATE TABLE outputs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    outcome_id BIGINT UNSIGNED NOT NULL,
    kpi_id BIGINT UNSIGNED NULL,
    data_source_id BIGINT UNSIGNED NULL,
    risk_id BIGINT UNSIGNED NULL,
    code VARCHAR(50) UNIQUE NOT NULL,
    title_en VARCHAR(200) NOT NULL,
    title_ta VARCHAR(200) NULL,
    title_si VARCHAR(200) NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_output_code (code),
    INDEX idx_output_outcome_id (outcome_id),
    INDEX idx_output_kpi_id (kpi_id),
    INDEX idx_output_data_source_id (data_source_id),
    INDEX idx_output_risk_id (risk_id),
    FOREIGN KEY (outcome_id) REFERENCES outcomes(id) ON DELETE CASCADE,
    FOREIGN KEY (kpi_id) REFERENCES kpis(id) ON DELETE SET NULL,
    FOREIGN KEY (data_source_id) REFERENCES data_sources(id) ON DELETE SET NULL,
    FOREIGN KEY (risk_id) REFERENCES risks(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 9. ACTIVITIES
-- ----------------------------------------------------------------------------
CREATE TABLE activities (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    output_id BIGINT UNSIGNED NOT NULL,
    kpi_id BIGINT UNSIGNED NULL,
    data_source_id BIGINT UNSIGNED NULL,
    risk_id BIGINT UNSIGNED NULL,
    code VARCHAR(50) UNIQUE NOT NULL,
    title_en VARCHAR(200) NOT NULL,
    title_ta VARCHAR(200) NULL,
    title_si VARCHAR(200) NULL,
    expense_code VARCHAR(50) NULL,
    income_code VARCHAR(50) NULL,
    responsibility VARCHAR(200) NULL,
    created_by BIGINT UNSIGNED NULL,
    updated_by BIGINT UNSIGNED NULL,
    deleted_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    INDEX idx_activity_code (code),
    INDEX idx_activity_output_id (output_id),
    INDEX idx_activity_kpi_id (kpi_id),
    INDEX idx_activity_data_source_id (data_source_id),
    INDEX idx_activity_risk_id (risk_id),
    FOREIGN KEY (output_id) REFERENCES outputs(id) ON DELETE CASCADE,
    FOREIGN KEY (kpi_id) REFERENCES kpis(id) ON DELETE SET NULL,
    FOREIGN KEY (data_source_id) REFERENCES data_sources(id) ON DELETE SET NULL,
    FOREIGN KEY (risk_id) REFERENCES risks(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ============================================================================
-- END OF DOMAIN 3: PLAN BLUEPRINT
-- ============================================================================
