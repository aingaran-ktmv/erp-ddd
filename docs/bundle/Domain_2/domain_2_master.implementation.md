# Laravel ORM Code-First Implementation Guide - Domain 3: Plan

---

Notes

- Uses Laravel's default users table for audit foreign keys.
- Each migration includes: created_by, updated_by, deleted_by, timestamps(), softDeletes().
- Use unsignedBigInteger for FKs and add indexes similar to the SQL blueprint.

---

## Step 1: Create KPIs Migration

```bash
php artisan make:migration create_kpis_table
```

```php
// Create the kpis table:
// - id: bigIncrements
// - kpi_code: string(50) unique, not nullable
// - name_en: string(200) not nullable; name_ta/name_si: string(200) nullable
// - unit: string(50) not nullable
// - created_by/updated_by/deleted_by: unsignedBigInteger nullable FKs -> users.id (onDelete set null)
// - timestamps(), softDeletes()
// Indexes: kpi_code
```

## Step 2: Create Kpi Model

```bash
php artisan make:model Kpi
```

```php
// Configure the Kpi model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['kpi_code','name_en','name_ta','name_si','unit','created_by','updated_by','deleted_by']
// - Relationships:
//   - createdBy()/updatedBy()/deletedBy() -> belongsTo(User::class, 'created_by'|'updated_by'|'deleted_by')
//   - outcomes() hasMany(Outcome::class, 'kpi_id')
//   - outputs() hasMany(Output::class, 'kpi_id')
//   - activities() hasMany(Activity::class, 'kpi_id')
```

---

## Step 3: Create Data Sources Migration

```bash
php artisan make:migration create_data_sources_table
```

```php
// Create the data_sources table:
// - id: bigIncrements
// - data_source_code: string(50) unique, not nullable
// - name_en: string(200) not nullable; name_ta/name_si: string(200) nullable
// - description: text nullable
// - audit FKs to users; timestamps(), softDeletes()
// Indexes: data_source_code
```

## Step 4: Create DataSource Model

```bash
php artisan make:model DataSource
```

```php
// Configure the DataSource model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['data_source_code','name_en','name_ta','name_si','description','created_by','updated_by','deleted_by']
// - Relationships:
//   - outcomes() hasMany(Outcome::class, 'data_source_id')
//   - outputs() hasMany(Output::class, 'data_source_id')
//   - activities() hasMany(Activity::class, 'data_source_id')
//   - createdBy()/updatedBy()/deletedBy() belongsTo(User::class, ...)
```

---

## Step 5: Create Risks Migration

```bash
php artisan make:migration create_risks_table
```

```php
// Create the risks table:
// - id: bigIncrements
// - risk_code: string(50) unique, not nullable
// - name_en: string(200) not nullable; name_ta/name_si: string(200) nullable
// - category: string(100) nullable
// - description: text nullable
// - audit FKs to users; timestamps(), softDeletes()
// Indexes: risk_code, category
```

## Step 6: Create Risk Model

```bash
php artisan make:model Risk
```

```php
// Configure the Risk model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['risk_code','name_en','name_ta','name_si','category','description','created_by','updated_by','deleted_by']
// - Relationships:
//   - outcomes() hasMany(Outcome::class, 'risk_id')
//   - outputs() hasMany(Output::class, 'risk_id')
//   - activities() hasMany(Activity::class, 'risk_id')
//   - createdBy()/updatedBy()/deletedBy() belongsTo(User::class, ...)
```

---

## Step 7: Create Thrust Areas Migration

```bash
php artisan make:migration create_thrust_areas_table
```

```php
// Create the thrust_areas table:
// - id: bigIncrements
// - code: string(50) unique, not nullable
// - title_en: string(200) not nullable; title_ta/title_si: string(200) nullable
// - description: text nullable
// - audit FKs to users; timestamps(), softDeletes()
// Indexes: code
```

## Step 8: Create ThrustArea Model

```bash
php artisan make:model ThrustArea
```

```php
// Configure the ThrustArea model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['code','title_en','title_ta','title_si','description','created_by','updated_by','deleted_by']
// - Relationships:
//   - components() hasMany(Component::class, 'thrust_area_id')
//   - createdBy()/updatedBy()/deletedBy() belongsTo(User::class, ...)
```

---

## Step 9: Create Components Migration

```bash
php artisan make:migration create_components_table
```

```php
// Create the components table:
// - id: bigIncrements
// - thrust_area_id: unsignedBigInteger not nullable FK -> thrust_areas.id (cascade on delete)
// - code: string(50) unique, not nullable
// - title_en: string(200) not nullable; title_ta/title_si: string(200) nullable
// - description: text nullable
// - audit FKs; timestamps(), softDeletes()
// Indexes: code, thrust_area_id
```

## Step 10: Create Component Model

```bash
php artisan make:model Component
```

```php
// Configure the Component model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['thrust_area_id','code','title_en','title_ta','title_si','description','created_by','updated_by','deleted_by']
// - Relationships:
//   - thrustArea() belongsTo(ThrustArea::class, 'thrust_area_id')
//   - impacts() hasMany(Impact::class, 'component_id')
//   - createdBy()/updatedBy()/deletedBy() belongsTo(User::class, ...)
```

---

## Step 11: Create Impacts Migration

```bash
php artisan make:migration create_impacts_table
```

```php
// Create the impacts table:
// - id: bigIncrements
// - component_id: unsignedBigInteger not nullable FK -> components.id (cascade on delete)
// - code: string(50) unique, not nullable
// - title_en: string(200) not nullable; title_ta/title_si: string(200) nullable
// - audit FKs; timestamps(), softDeletes()
// Indexes: code, component_id
```

## Step 12: Create Impact Model

```bash
php artisan make:model Impact
```

```php
// Configure the Impact model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['component_id','code','title_en','title_ta','title_si','created_by','updated_by','deleted_by']
// - Relationships:
//   - component() belongsTo(Component::class, 'component_id')
//   - outcomes() hasMany(Outcome::class, 'impact_id')
//   - createdBy()/updatedBy()/deletedBy() belongsTo(User::class, ...)
```

---

## Step 13: Create Outcomes Migration

```bash
php artisan make:migration create_outcomes_table
```

```php
// Create the outcomes table:
// - id: bigIncrements
// - impact_id: unsignedBigInteger not nullable FK -> impacts.id (cascade on delete)
// - kpi_id: unsignedBigInteger nullable FK -> kpis.id (set null)
// - data_source_id: unsignedBigInteger nullable FK -> data_sources.id (set null)
// - risk_id: unsignedBigInteger nullable FK -> risks.id (set null)
// - code: string(50) unique, not nullable
// - title_en: string(200) not nullable; title_ta/title_si: string(200) nullable
// - audit FKs; timestamps(), softDeletes()
// Indexes: code, impact_id, kpi_id, data_source_id, risk_id
```

## Step 14: Create Outcome Model

```bash
php artisan make:model Outcome
```

```php
// Configure the Outcome model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['impact_id','kpi_id','data_source_id','risk_id','code','title_en','title_ta','title_si','created_by','updated_by','deleted_by']
// - Relationships:
//   - impact() belongsTo(Impact::class, 'impact_id')
//   - kpi() belongsTo(Kpi::class, 'kpi_id')
//   - dataSource() belongsTo(DataSource::class, 'data_source_id')
//   - risk() belongsTo(Risk::class, 'risk_id')
//   - outputs() hasMany(Output::class, 'outcome_id')
//   - createdBy()/updatedBy()/deletedBy() belongsTo(User::class, ...)
```

---

## Step 15: Create Outputs Migration

```bash
php artisan make:migration create_outputs_table
```

```php
// Create the outputs table:
// - id: bigIncrements
// - outcome_id: unsignedBigInteger not nullable FK -> outcomes.id (cascade on delete)
// - kpi_id: unsignedBigInteger nullable FK -> kpis.id (set null)
// - data_source_id: unsignedBigInteger nullable FK -> data_sources.id (set null)
// - risk_id: unsignedBigInteger nullable FK -> risks.id (set null)
// - code: string(50) unique, not nullable
// - title_en: string(200) not nullable; title_ta/title_si: string(200) nullable
// - audit FKs; timestamps(), softDeletes()
// Indexes: code, outcome_id, kpi_id, data_source_id, risk_id
```

## Step 16: Create Output Model

```bash
php artisan make:model Output
```

```php
// Configure the Output model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['outcome_id','kpi_id','data_source_id','risk_id','code','title_en','title_ta','title_si','created_by','updated_by','deleted_by']
// - Relationships:
//   - outcome() belongsTo(Outcome::class, 'outcome_id')
//   - kpi() belongsTo(Kpi::class, 'kpi_id')
//   - dataSource() belongsTo(DataSource::class, 'data_source_id')
//   - risk() belongsTo(Risk::class, 'risk_id')
//   - activities() hasMany(Activity::class, 'output_id')
//   - createdBy()/updatedBy()/deletedBy() belongsTo(User::class, ...)
```

---

## Step 17: Create Activities Migration

```bash
php artisan make:migration create_activities_table
```

```php
// Create the activities table:
// - id: bigIncrements
// - output_id: unsignedBigInteger not nullable FK -> outputs.id (cascade on delete)
// - kpi_id: unsignedBigInteger nullable FK -> kpis.id (set null)
// - data_source_id: unsignedBigInteger nullable FK -> data_sources.id (set null)
// - risk_id: unsignedBigInteger nullable FK -> risks.id (set null)
// - code: string(50) unique, not nullable
// - title_en: string(200) not nullable; title_ta/title_si: string(200) nullable
// - expense_code: string(50) nullable
// - income_code: string(50) nullable
// - responsibility: string(200) nullable
// - audit FKs; timestamps(), softDeletes()
// Indexes: code, output_id, kpi_id, data_source_id, risk_id
```

## Step 18: Create Activity Model

```bash
php artisan make:model Activity
```

```php
// Configure the Activity model:
// - Use HasFactory, SoftDeletes
// - $fillable: ['output_id','kpi_id','data_source_id','risk_id','code','title_en','title_ta','title_si','expense_code','income_code','responsibility','created_by','updated_by','deleted_by']
// - Relationships:
//   - output() belongsTo(Output::class, 'output_id')
//   - kpi() belongsTo(Kpi::class, 'kpi_id')
//   - dataSource() belongsTo(DataSource::class, 'data_source_id')
//   - risk() belongsTo(Risk::class, 'risk_id')
//   - createdBy()/updatedBy()/deletedBy() belongsTo(User::class, ...)
```

---

## Final Step: Run Migrations

```bash
php artisan migrate
```

---

Ready tables for Domain 3: Plan

1. kpis
2. data_sources
3. risks
4. thrust_areas
5. components
6. impacts
7. outcomes
8. outputs
9. activities
