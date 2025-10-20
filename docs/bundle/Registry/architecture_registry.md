# Architecture Registry (Domains 1–5)

This registry tracks deliverables for each domain. All designs reference **Laravel 12** and **Filament 4** conventions. Filament/Laravel placement is authoritative; DDD layering complements it. See `docs/architecture.md` (Filament-first).

| Domain | Key                       | Migration file (database/migrations)                                       | Guide (docs/)                                  | Prototype (resources/views/prototypes/)              |
| ------ | ------------------------- | -------------------------------------------------------------------------- | ---------------------------------------------- | ---------------------------------------------------- |
| 1      | school                    | database/migrations/2025_xx_xx_create_schools_table.php                    | docs/domain_1_school.implementation.md         | resources/views/prototypes/domain_1_school.blade.php |
| 2      | master                    | database/migrations/2025_xx_xx_create_master_tables.php                    | docs/domain_2_master.implementation.md         | resources/views/prototypes/domain_2_master.blade.php |
| 3      | plan                      | database/migrations/2025_xx_xx_create_plan_tables.php                      | docs/domain_3_plan.implementation.md           | —                                                    |
| 4      | administration            | database/migrations/2025_xx_xx_create_administration_tables.php            | docs/domain_4_administration.implementation.md | —                                                    |
| 4b     | reporting                 | database/migrations/2025_xx_xx_create_reporting_tables.php                 | docs/domain_4_reporting.implementation.md      | —                                                    |
| 5      | curriculum_implementation | database/migrations/2025_xx_xx_create_curriculum_implementation_tables.php | docs/domain_5_curriculum.implementation.md     | —                                                    |

---

## Compliance Notes (Laravel 11 / Filament 4)

-   **File paths (authoritative, matches architecture.md):** Place migrations in `database/migrations`, models in `app/Models`, Filament resources in `app/Filament/Resources`, and prototypes in `resources/views/prototypes`.
-   **Table naming:** Use plural, snake_case for all tables (e.g., `school_visions`).
-   **YEAR columns:** Use `unsignedSmallInteger` or `integer` in migrations, not native `year`.
-   **ENUM usage:** Prefer string columns with Laravel enum casting or validation for portability.
-   **Soft deletes:** Use only `deleted_at` (softDeletes) unless a separate boolean is required for business logic.
-   **Polymorphic relations:** Always add index on `assignable_type` and `assignable_id` for morphs.
-   **Automation:** Use artisan commands for migrations, models, and Filament resources; follow Laravel’s default file placement.

### Notes

-   Domain 5 is aligned to the existing folder `app/Domains/CurriculumImplementation/` using the key `curriculum_implementation`.
-   Domain key `reporting` is tracked as 4b in the registry; if it becomes an independent code domain, create `app/Domains/Reporting/` when implementation starts.

**Generated:** 2025-10-19 02:13:04 UTC
