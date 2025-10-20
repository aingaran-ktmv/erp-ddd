erp-ddd/
├── app/
│ ├── Models/ (Eloquent models)
│ ├── Filament/
│ │ └── Resources/ (Filament resources, pages, relation managers)
│ ├── Domains/ (domain layering for non-Eloquent code)
│ │ ├── {Domain}/
│ │ │ ├── Policies/ (authorization policies)
│ │ │ ├── Services/ (domain services, use-cases)
│ │ │ ├── ValueObjects/ (optional)
│ │ │ └── ...
│ │ └── ...
│ ├── Providers/
│ │ ├── Filament/
│ │ │ ├── AdminPanelProvider.php
│ │ │ └── ... (other panel providers)
│ │ └── ...
│ └── ... (other default Laravel folders)
├── database/
│ ├── migrations/ (all migrations, including domain-related)
│ └── seeders/ (global or domain-related seeders)
├── resources/
│ └── views/
├── docs/
│ ├── architecture.md (this file)
│ ├── bundle/Registry/architecture*registry.md (deliverables registry)
│ └── domain*\*.implementation.md (per-domain guides, see registry)

For a domain named `School`:
app/Domains/School/
├── Policies/

Where to find the rest (by convention):

-   Migrations: `database/migrations/*create_schools_table.php`, `*create_school_visions_table.php`

## Key Principles

-   **Isolation:** Business logic for a domain is grouped under `app/Domains/{Domain}/` (services, policies, value objects). Models, migrations, and UI stay in their Laravel-default homes.
-   **Namespaces:** Use clear namespaces, e.g., `App\Domains\School\Services` for services, `App\Models` for Eloquent.
-   **Migrations:** All migrations live in `database/migrations` (per registry). Use plural, snake_case table names and follow portability rules (no native YEAR, prefer string over ENUM, add indexes for morphs, soft deletes via `deleted_at`).
-   **Models:** Place Eloquent models in `app/Models`.
-   **Filament Resources (priority):** Place resources in `app/Filament/Resources` and register/discover via panel providers. Put resource Pages under `ResourceName/Pages/` and relation managers under `ResourceName/RelationManagers/`.
-   **Policies:** Authorization logic is local to each domain in `app/Domains/{Domain}/Policies/` and mapped in AuthServiceProvider as needed.
-   **Prototypes:** UI prototypes live under `resources/views/prototypes`.
-   **Panels:** Filament panel providers are in `app/Providers/Filament/` to support multiple admin panels.
-   **Docs:** Architecture registry at `docs/bundle/Registry/architecture_registry.md` is the deliverables source of truth. Per-domain implementation guides live in `docs/domain_*.implementation.md`.

## Benefits

-   **Scalability:** Easily supports 25+ domains without clutter.
-   **Modularity:** Each domain is self-contained and can be developed/tested independently.
-   **Maintainability:** New developers or agents can quickly locate and understand domain logic.
-   **Multi-Panel Ready:** Supports multiple Filament admin panels for different user groups or business areas.

---

For concrete deliverables, follow the registry table in `docs/bundle/Registry/architecture_registry.md` and the domain-specific implementation guides in `docs/`.
