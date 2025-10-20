# Domain 15: Reporting Engine - Detailed Migration & Model Instructions

Purpose

- Centralized PDF reporting engine with reusable templates and sections, definition-level data sourcing, and async job orchestration.
- Universal standards: audit trail (created_by, updated_by, deleted_by), timestamps, softDeletes, FKs to users(id).

---

## Step 1: Create Report Templates Migration

```bash
php artisan make:migration create_report_templates_table
```

```php
// Create the report_templates table with the following schema:
// - id: big integer unsigned, auto-increment, primary key
// - template_code: string(50), unique, not nullable (business key)
// - name: string(200), not nullable
// - view_path: string(255), not nullable (base Blade view for the template's body)
// - page_size: enum ['A5','A4','A3','Letter','Legal','Custom'], default 'A4'
// - orientation: enum ['portrait','landscape'], default 'portrait'
// - margin_top_mm: decimal(5,2) default 10.00; margin_bottom_mm: decimal(5,2) default 10.00
// - margin_left_mm: decimal(5,2) default 10.00; margin_right_mm: decimal(5,2) default 10.00
// - page_width_mm: decimal(6,2) nullable (used when page_size='Custom')
// - page_height_mm: decimal(6,2) nullable (used when page_size='Custom')
// - options_json: json nullable (renderer-specific options, e.g., dpi, footer spacing)
// - status: enum ['active','inactive'] default 'active'
// - created_by/updated_by/deleted_by: unsignedBigInteger nullable, FK->users.id ON DELETE SET NULL
// - timestamps(); softDeletes();
// Indexes: template_code (unique), status, page_size, orientation
```

Brief

- Defines page and layout characteristics and the base Blade view to render.

---

## Step 2: Create ReportTemplate Model

```bash
php artisan make:model ReportTemplate
```

```php
// Configure the ReportTemplate model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['template_code','name','view_path','page_size','orientation','margin_top_mm','margin_bottom_mm','margin_left_mm','margin_right_mm','page_width_mm','page_height_mm','options_json','status','created_by','updated_by','deleted_by']
// - $casts: ['margin_top_mm'=>'decimal:2','margin_bottom_mm'=>'decimal:2','margin_left_mm'=>'decimal:2','margin_right_mm'=>'decimal:2','page_width_mm'=>'decimal:2','page_height_mm'=>'decimal:2','options_json'=>'array']
// - Relationships:
//   - sections() hasMany(ReportTemplateSection::class, 'template_id')
//   - definitions() hasMany(ReportDefinition::class, 'template_id')
//   - createdBy()/updatedBy()/deletedBy() belongsTo(User::class, 'created_by'|'updated_by'|'deleted_by')
```

---

## Step 3: Create Report Template Sections Migration

```bash
php artisan make:migration create_report_template_sections_table
```

```php
// Create the report_template_sections table with the following schema:
// - id: big integer unsigned, auto-increment, primary key
// - template_id: unsignedBigInteger, not nullable, FK->report_templates.id ON DELETE CASCADE
// - section_code: string(50), not nullable (e.g., 'HDR_MAIN','FTR_STD')
// - section_type: enum ['header','footer','watermark','cover','appendix','custom'] not nullable
// - name: string(200) not nullable
// - view_path: string(255) nullable (Blade partial path). If null, content_html must be provided.
// - content_html: longText nullable (inline HTML for the section)
// - order_no: integer default 0 (rendering order for multi-sections of same type)
// - is_active: boolean default true
// - options_json: json nullable (renderer-specific overrides)
// - created_by/updated_by/deleted_by: unsignedBigInteger nullable, FK->users.id ON DELETE SET NULL
// - timestamps(); softDeletes();
// Constraints/Indexes:
// - unique(template_id, section_code)
// - indexes: template_id, section_type, is_active, order_no
```

Brief

- Reusable partials like headers/footers, either via Blade partials or inline HTML.

---

## Step 4: Create ReportTemplateSection Model

```bash
php artisan make:model ReportTemplateSection
```

```php
// Configure the ReportTemplateSection model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['template_id','section_code','section_type','name','view_path','content_html','order_no','is_active','options_json','created_by','updated_by','deleted_by']
// - $casts: ['is_active'=>'boolean','order_no'=>'integer','options_json'=>'array']
// - Relationships:
//   - template() belongsTo(ReportTemplate::class, 'template_id')
//   - createdBy()/updatedBy()/deletedBy() belongsTo(User::class, ...)
```

---

## Step 5: Create Report Definitions Migration

```bash
php artisan make:migration create_report_definitions_table
```

```php
// Create the report_definitions table with the following schema:
// - id: big integer unsigned, auto-increment, primary key
// - definition_code: string(50) unique, not nullable (business key)
// - name: string(200) not nullable
// - description: text nullable
// - template_id: unsignedBigInteger not nullable, FK->report_templates.id ON DELETE RESTRICT
// - data_source_class: string(255) not nullable (FQCN resolving report data, e.g., App\\Reports\\Invoices\\InvoiceDataSource)
// - view_path_override: string(255) nullable (override the template's base body view if needed)
// - default_params: json nullable (default filters/inputs for the data source)
// - output_filename_pattern: string(255) nullable (e.g., 'invoice_{number}_{date}.pdf')
// - render_engine: enum ['snappy','dompdf'] default 'snappy'
// - status: enum ['active','inactive'] default 'active'
// - created_by/updated_by/deleted_by: unsignedBigInteger nullable, FK->users.id ON DELETE SET NULL
// - timestamps(); softDeletes();
// Indexes: definition_code (unique), template_id, data_source_class, status, render_engine
```

Brief

- Binds a use-case to a template and its data source class; can override view and provide defaults.

---

## Step 6: Create ReportDefinition Model

```bash
php artisan make:model ReportDefinition
```

```php
// Configure the ReportDefinition model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['definition_code','name','description','template_id','data_source_class','view_path_override','default_params','output_filename_pattern','render_engine','status','created_by','updated_by','deleted_by']
// - $casts: ['default_params'=>'array']
// - Relationships:
//   - template() belongsTo(ReportTemplate::class, 'template_id')
//   - jobs() hasMany(ReportGenerationJob::class, 'definition_id')
//   - createdBy()/updatedBy()/deletedBy() belongsTo(User::class, ...)
```

---

## Step 7: Create Report Generation Jobs Migration

```bash
php artisan make:migration create_report_generation_jobs_table
```

```php
// Create the report_generation_jobs table with the following schema:
// - id: big integer unsigned, auto-increment, primary key
// - definition_id: unsignedBigInteger not nullable, FK->report_definitions.id ON DELETE RESTRICT
// - requested_by: unsignedBigInteger nullable, FK->users.id ON DELETE SET NULL
// - request_params: json nullable (effective params merged with defaults at enqueue time)
// - priority: tinyInteger unsigned default 3 (1=highest ... 5=lowest)
// - status: enum ['queued','processing','success','failed','canceled'] default 'queued'
// - engine: enum ['snappy','dompdf'] nullable (snapshot of renderer used)
// - queued_at: timestamp nullable; started_at: timestamp nullable; completed_at: timestamp nullable; failed_at: timestamp nullable
// - storage_path: string(500) nullable (where the generated file is stored)
// - file_size_bytes: bigInteger unsigned nullable
// - page_count: integer unsigned nullable
// - attempt_count: smallInteger unsigned default 0
// - last_error: text nullable
// - correlation_id: string(100) nullable (idempotency/grouping key)
// - expires_at: timestamp nullable (optional cleanup threshold)
// - created_by/updated_by/deleted_by: unsignedBigInteger nullable, FK->users.id ON DELETE SET NULL
// - timestamps(); softDeletes();
// Indexes:
// - definition_id, requested_by, status, priority
// - queued_at, started_at, completed_at, correlation_id
```

Brief

- Async job record and log with parameters, lifecycle timestamps, storage metadata, and diagnostics.

---

## Step 8: Create ReportGenerationJob Model

```bash
php artisan make:model ReportGenerationJob
```

```php
// Configure the ReportGenerationJob model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['definition_id','requested_by','request_params','priority','status','engine','queued_at','started_at','completed_at','failed_at','storage_path','file_size_bytes','page_count','attempt_count','last_error','correlation_id','expires_at','created_by','updated_by','deleted_by']
// - $casts: ['request_params'=>'array','priority'=>'integer','file_size_bytes'=>'integer','page_count'=>'integer','attempt_count'=>'integer','queued_at'=>'datetime','started_at'=>'datetime','completed_at'=>'datetime','failed_at'=>'datetime','expires_at'=>'datetime']
// - Relationships:
//   - definition() belongsTo(ReportDefinition::class, 'definition_id')
//   - requester() belongsTo(User::class, 'requested_by')
//   - createdBy()/updatedBy()/deletedBy() belongsTo(User::class, ...)
```

---

Final step: Run migrations

```bash
php artisan migrate
```

Recommendation

- For high-fidelity, performant PDF rendering, install barryvdh/laravel-snappy and wkhtmltopdf.
- Composer: composer require barryvdh/laravel-snappy
- Publish config and set default engine to snappy in your app’s reporting settings.

---
## Implementation Notes (Laravel 11 + Filament 4)

**Data Structures:** `report_definitions`, `report_schedules`, `report_runs` (+ view `vw_daily_periods_conducted_rate`).  
All tables follow global standards (id PK, audit, soft_delete).

**Eloquent Models:** simple one-to-many from `report_definitions` → `report_schedules` & `report_runs`.

**Filament 4 Resources:**
- `ReportDefinitionResource`: CRUD for code/name/sql_text/format/is_active.
- `ReportScheduleResource`: CRUD linked to definition; includes a cron expression input.
- `ReportRunResource`: read-only logs with filters by status/date/definition.
- Optional custom Page: “Run Now” action on ReportDefinition to enqueue generation (Job).

**Execution Strategy (Queue Job):**
- Validate `sql_text` (allow only whitelisted SELECT or saved view names).
- Execute to array/collection; render table/chart via Filament widgets or export CSV/XLSX.
- Persist `report_runs` with status and optional `output_path`.

**Security:**
- Gate report execution by role (`report.run`, `report.admin`).
- Parameterize inputs; avoid raw SQL injection.
