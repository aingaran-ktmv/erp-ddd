# Laravel ORM Code-First Implementation Guide

---

## Domain 1: School - Detailed Migration & Model Instructions

---

## Step 1: Create Schools Migration

```bash
php artisan make:migration create_schools_table
```

**Prompt for Copilot:**

```php
// Create the schools table with the following schema:
// - id: primary key, big integer, auto-increment
// - school_no: string (50), unique, not nullable (business identifier)
// - school_census_no: string (50), unique, nullable
// - school_name_en: text, not nullable
// - school_name_ta: text, nullable
// - school_name_si: text, nullable
// - school_type: enum ['1AB', '1C', 'type21', 'type2'], not nullable
// - school_category: enum ['national', 'province', 'private', 'semigovernment'], not nullable
// - division: string (100), nullable
// - zone: string (100), nullable
// - district: string (100), nullable
// - province: string (100), nullable
// - address: text, nullable
// - phone: string (20), nullable
// - email: string (255), nullable
// - website: string (255), nullable
// - established_year: year, nullable
// - geo_lat: decimal (10,8), nullable
// - geo_lng: decimal (11,8), nullable
// - school_map_url: text, nullable
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: school_no, school_census_no, school_type, school_category
```

---

## Step 2: Create School Model

```bash
php artisan make:model School
```

**Prompt for Copilot:**

```php
// Configure the School model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['school_no', 'school_census_no', 'school_name_en', 'school_name_ta', 'school_name_si', 'school_type', 'school_category', 'division', 'zone', 'district', 'province', 'address', 'phone', 'email', 'website', 'established_year', 'geo_lat', 'geo_lng', 'school_map_url', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['established_year' => 'integer', 'geo_lat' => 'decimal:8', 'geo_lng' => 'decimal:8', 'school_type' => 'string', 'school_category' => 'string']
// - Relationships:
//   - visions() hasMany(SchoolVision::class, 'school_id')
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 3: Create School Visions Migration

```bash
php artisan make:migration create_school_visions_table
```

**Prompt for Copilot:**

```php
// Create the school_visions table with the following schema:
// - id: primary key, big integer, auto-increment
// - school_id: big integer unsigned, not nullable, foreign key to schools.id, on delete cascade
// - year: year, not nullable
// - vision_en: text, nullable
// - vision_ta: text, nullable
// - vision_si: text, nullable
// - mission_en: text, nullable
// - mission_ta: text, nullable
// - mission_si: text, nullable
// - motto_en: text, nullable
// - motto_ta: text, nullable
// - motto_si: text, nullable
// - logo_url: text, nullable
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add unique constraint: unique (school_id, year)
// Add indexes: school_id, year
```

---

## Step 4: Create SchoolVision Model

```bash
php artisan make:model SchoolVision
```

**Prompt for Copilot:**

```php
// Configure the SchoolVision model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['school_id', 'year', 'vision_en', 'vision_ta', 'vision_si', 'mission_en', 'mission_ta', 'mission_si', 'motto_en', 'motto_ta', 'motto_si', 'logo_url', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['year' => 'integer']
// - Relationships:
//   - school() belongsTo(School::class, 'school_id')
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Domain 1: School - COMPLETE ✅

---

## Domain 2: Master - Detailed Migration & Model Instructions

---

## Step 1: Users (Laravel default)

Use Laravel’s default users table and migration. Do not create a new users table here. Ensure the default users.id is BIGINT (unsigned) to match foreign keys in this guide.

- No custom migration for users.
- No polymorphic columns (userable_type/userable_id) added here.

---

## Step 2: User Model (Laravel default)

Use Laravel’s default app/Models/User.php.

- No custom changes required for this guide.
- Other models will reference User via created_by, updated_by, deleted_by.

---

## Step 3: Create Departments Migration

```bash
php artisan make:migration create_departments_table
```

**Prompt for Copilot:**

```php
// Create the departments table with the following schema:
// - id: primary key, big integer, auto-increment
// - department_code: string (50), unique, not nullable
// - name: enum ['administration', 'curriculum', 'co_curricular', 'finance', 'others'], not nullable
// - description: text, nullable
// - status: enum ['active', 'inactive'], default 'active'
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: department_code, status
```

---

## Step 4: Create Department Model

```bash
php artisan make:model Department
```

**Prompt for Copilot:**

```php
// Configure the Department model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['department_code', 'name', 'description', 'status', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['status' => 'string']
// - Relationships:
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 5: Create Subjects Migration

```bash
php artisan make:migration create_subjects_table
```

**Prompt for Copilot:**

```php
// Create the subjects table with the following schema:
// - id: primary key, big integer, auto-increment
// - subject_code: string (50), unique, not nullable
// - name_en: string (200), not nullable
// - name_ta: string (200), nullable
// - name_si: string (200), nullable
// - subject_category: enum ['core', 'optional', 'extra_curricular'], nullable
// - status: enum ['active', 'inactive'], default 'active'
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: subject_code, subject_category, status
```

---

## Step 6: Create Subject Model

```bash
php artisan make:model Subject
```

**Prompt for Copilot:**

```php
// Configure the Subject model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['subject_code', 'name_en', 'name_ta', 'name_si', 'subject_category', 'status', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['status' => 'string', 'subject_category' => 'string']
// - Relationships:
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
//   - staff() hasMany(Staff::class, 'appointed_subject_id')
```

---

## Step 7: Create Sections Migration

```bash
php artisan make:migration create_sections_table
```

**Prompt for Copilot:**

```php
// Create the sections table with the following schema:
// - id: primary key, big integer, auto-increment
// - section_code: string (50), unique, not nullable
// - parent_id: big integer unsigned, nullable, foreign key to sections.id, on delete set null (self-referencing)
// - name: string (100), not nullable
// - description: text, nullable
// - status: enum ['active', 'inactive'], default 'active'
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: section_code, parent_id, status
```

---

## Step 8: Create Section Model

```bash
php artisan make:model Section
```

**Prompt for Copilot:**

```php
// Configure the Section model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['section_code', 'parent_id', 'name', 'description', 'status', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['status' => 'string']
// - Relationships:
//   - parent() belongsTo(Section::class, 'parent_id')
//   - children() hasMany(Section::class, 'parent_id')
//   - subsections() hasMany(Subsection::class, 'section_id')
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 9: Create Subsections Migration

```bash
php artisan make:migration create_subsections_table
```

**Prompt for Copilot:**

```php
// Create the subsections table with the following schema:
// - id: primary key, big integer, auto-increment
// - subsection_code: string (50), unique, not nullable
// - section_id: big integer unsigned, not nullable, foreign key to sections.id, on delete cascade
// - parent_id: big integer unsigned, nullable, foreign key to subsections.id, on delete set null (self-referencing)
// - name: string (100), not nullable
// - description: text, nullable
// - status: enum ['active', 'inactive'], default 'active'
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: subsection_code, section_id, parent_id, status
```

---

## Step 10: Create Subsection Model

```bash
php artisan make:model Subsection
```

**Prompt for Copilot:**

```php
// Configure the Subsection model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['subsection_code', 'section_id', 'parent_id', 'name', 'description', 'status', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['status' => 'string']
// - Relationships:
//   - section() belongsTo(Section::class, 'section_id')
//   - parent() belongsTo(Subsection::class, 'parent_id')
//   - children() hasMany(Subsection::class, 'parent_id')
//   - grades() hasMany(Grade::class, 'subsection_id')
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 11: Create Grades Migration

```bash
php artisan make:migration create_grades_table
```

**Prompt for Copilot:**

```php
// Create the grades table with the following schema:
// - id: primary key, big integer, auto-increment
// - grade_code: string (50), unique, not nullable
// - subsection_id: big integer unsigned, nullable, foreign key to subsections.id, on delete set null
// - parent_id: big integer unsigned, nullable, foreign key to grades.id, on delete set null (self-referencing)
// - name: string (50), not nullable
// - order_no: integer, not nullable, default 0
// - status: enum ['active', 'inactive'], default 'active'
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: grade_code, subsection_id, parent_id, order_no, status
```

---

## Step 12: Create Grade Model

```bash
php artisan make:model Grade
```

**Prompt for Copilot:**

```php
// Configure the Grade model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['grade_code', 'subsection_id', 'parent_id', 'name', 'order_no', 'status', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['status' => 'string', 'order_no' => 'integer']
// - Relationships:
//   - subsection() belongsTo(Subsection::class, 'subsection_id')
//   - parent() belongsTo(Grade::class, 'parent_id')
//   - children() hasMany(Grade::class, 'parent_id')
//   - classes() hasMany(Classes::class, 'grade_id')
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 13: Create Classes Migration

```bash
php artisan make:migration create_classes_table
```

**Prompt for Copilot:**

```php
// Create the classes table with the following schema:
// - id: primary key, big integer, auto-increment
// - class_code: string (50), unique, not nullable
// - grade_id: big integer unsigned, not nullable, foreign key to grades.id, on delete cascade
// - class_name: string (100), not nullable
// - status: enum ['active', 'inactive'], default 'active'
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: class_code, grade_id, status
```

---

## Step 14: Create Classes Model

```bash
php artisan make:model Classes
```

**Prompt for Copilot:**

```php
// Configure the Classes model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['class_code', 'grade_id', 'class_name', 'status', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['status' => 'string']
// - Relationships:
//   - grade() belongsTo(Grade::class, 'grade_id')
//   - students() hasMany(Student::class, 'current_class_id')
//   - studentHistory() hasMany(StudentClassHistory::class, 'class_id')
//   - resourceAssignments() morphMany(ResourceAssignment::class, 'assignable')
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 15: Create Staff Migration

```bash
php artisan make:migration create_staff_table
```

**Prompt for Copilot:**

```php
// Create the staff table with the following schema:
// - id: primary key, big integer, auto-increment
// - emp_no: string (50), unique, not nullable
// - first_name: string (100), not nullable
// - last_name: string (100), not nullable
// - gender: enum ['male', 'female', 'other'], not nullable
// - dob: date, not nullable
// - nic_no: string (20), unique, not nullable
// - appointed_subject_id: big integer unsigned, nullable, foreign key to subjects.id, on delete set null
// - type_of_appointment: enum ['permanent', 'temporary', 'contract', 'substitute'], not nullable
// - photo_url: text, nullable
// - is_active: boolean, default true
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: emp_no, nic_no, appointed_subject_id, is_active
```

---

## Step 16: Create Staff Model

```bash
php artisan make:model Staff
```

**Prompt for Copilot:**

```php
// Configure the Staff model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['emp_no', 'first_name', 'last_name', 'gender', 'dob', 'nic_no', 'appointed_subject_id', 'type_of_appointment', 'photo_url', 'is_active', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['dob' => 'date', 'is_active' => 'boolean', 'gender' => 'string', 'type_of_appointment' => 'string']
// - Relationships:
//   - appointedSubject() belongsTo(Subject::class, 'appointed_subject_id')
//   - clubStaff() hasMany(ClubStaff::class, 'staff_id')
//   - clubs() belongsToMany(Club::class, 'club_staff', 'staff_id', 'club_id')->withPivot('role', 'from_date', 'to_date')->withTimestamps()
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 17: Create Students Migration

```bash
php artisan make:migration create_students_table
```

**Prompt for Copilot:**

```php
// Create the students table with the following schema:
// - id: primary key, big integer, auto-increment
// - admission_no: string (50), unique, not nullable
// - first_name: string (100), not nullable
// - last_name: string (100), not nullable
// - gender: enum ['male', 'female', 'other'], not nullable
// - dob: date, not nullable
// - guardian_name: string (200), not nullable
// - joined_date: date, not nullable
// - current_class_id: big integer unsigned, nullable, foreign key to classes.id, on delete set null
// - photo_url: text, nullable
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: admission_no, current_class_id
```

---

## Step 18: Create Student Model

```bash
php artisan make:model Student
```

**Prompt for Copilot:**

```php
// Configure the Student model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['admission_no', 'first_name', 'last_name', 'gender', 'dob', 'guardian_name', 'joined_date', 'current_class_id', 'photo_url', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['dob' => 'date', 'joined_date' => 'date', 'gender' => 'string']
// - Relationships:
//   - currentClass() belongsTo(Classes::class, 'current_class_id')
//   - classHistory() hasMany(StudentClassHistory::class, 'student_id')
//   - clubStudents() hasMany(ClubStudent::class, 'student_id')
//   - clubs() belongsToMany(Club::class, 'club_students', 'student_id', 'club_id')->withPivot('role', 'from_date', 'to_date')->withTimestamps()
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 19: Create Student Class History Migration

```bash
php artisan make:migration create_student_class_history_table
```

**Prompt for Copilot:**

```php
// Create the student_class_history table with the following schema:
// - id: primary key, big integer, auto-increment
// - student_id: big integer unsigned, not nullable, foreign key to students.id, on delete cascade
// - class_id: big integer unsigned, not nullable, foreign key to classes.id, on delete cascade
// - academic_year: string (20), not nullable
// - from_date: date, not nullable
// - to_date: date, nullable
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: student_id, class_id, academic_year, composite index on (from_date, to_date)
```

---

## Step 20: Create StudentClassHistory Model

```bash
php artisan make:model StudentClassHistory
```

**Prompt for Copilot:**

```php
// Configure the StudentClassHistory model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['student_id', 'class_id', 'academic_year', 'from_date', 'to_date', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['from_date' => 'date', 'to_date' => 'date']
// - Relationships:
//   - student() belongsTo(Student::class, 'student_id')
//   - class() belongsTo(Classes::class, 'class_id')
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 21: Create Posts Migration

```bash
php artisan make:migration create_posts_table
```

**Prompt for Copilot:**

```php
// Create the posts table with the following schema:
// - id: primary key, big integer, auto-increment
// - post_code: string (50), unique, not nullable
// - name: enum ['principal', 'deputy_principal', 'assistant_principal', 'sectional_head', 'subject_coordinator', 'class_teacher', 'subject_incharge', 'club_incharge', 'secretary', 'treasurer', 'president', 'vice_president'], not nullable
// - description: text, nullable
// - status: enum ['active', 'inactive'], default 'active'
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: post_code, status
```

---

## Step 22: Create Post Model

```bash
php artisan make:model Post
```

**Prompt for Copilot:**

```php
// Configure the Post model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['post_code', 'name', 'description', 'status', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['status' => 'string', 'name' => 'string']
// - Relationships:
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 23: Create Resources Migration

```bash
php artisan make:migration create_resources_table
```

**Prompt for Copilot:**

```php
// Create the resources table with the following schema:
// - id: primary key, big integer, auto-increment
// - resource_code: string (50), unique, not nullable
// - name: string (200), not nullable
// - description: text, nullable
// - type: enum ['room', 'equipment', 'vehicle', 'facility', 'other'], not nullable
// - location: text, nullable
// - status: enum ['available', 'in_use', 'maintenance', 'retired'], default 'available'
// - capacity: integer, nullable
// - photo_url: text, nullable
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: resource_code, type, status
```

---

## Step 24: Create Resource Model

```bash
php artisan make:model Resource
```

**Prompt for Copilot:**

```php
// Configure the Resource model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['resource_code', 'name', 'description', 'type', 'location', 'status', 'capacity', 'photo_url', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['status' => 'string', 'type' => 'string', 'capacity' => 'integer']
// - Relationships:
//   - assignments() hasMany(ResourceAssignment::class, 'resource_id')
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 25: Create Resource Assignments Migration

```bash
php artisan make:migration create_resource_assignments_table
```

**Prompt for Copilot:**

```php
// Create the resource_assignments table with the following schema:
// - id: primary key, big integer, auto-increment
// - resource_id: big integer unsigned, not nullable, foreign key to resources.id, on delete cascade
// - assignable_type: string (255), not nullable (polymorphic relation type)
// - assignable_id: big integer unsigned, not nullable (polymorphic relation id)
// - assigned_from: date, not nullable
// - assigned_to: date, nullable
// - purpose: text, nullable
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: resource_id, composite index on (assignable_type, assignable_id), composite index on (assigned_from, assigned_to)
```

---

## Step 26: Create ResourceAssignment Model

```bash
php artisan make:model ResourceAssignment
```

**Prompt for Copilot:**

```php
// Configure the ResourceAssignment model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['resource_id', 'assignable_type', 'assignable_id', 'assigned_from', 'assigned_to', 'purpose', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['assigned_from' => 'date', 'assigned_to' => 'date']
// - Relationships:
//   - resource() belongsTo(Resource::class, 'resource_id')
//   - assignable() morphTo()
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 27: Create Clubs Migration

```bash
php artisan make:migration create_clubs_table
```

**Prompt for Copilot:**

```php
// Create the clubs table with the following schema:
// - id: primary key, big integer, auto-increment
// - club_code: string (50), unique, not nullable
// - name_en: string (200), not nullable
// - name_ta: string (200), nullable
// - name_si: string (200), nullable
// - job_profile: text, nullable
// - status: enum ['active', 'inactive'], default 'active'
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: club_code, status
```

---

## Step 28: Create Club Model

```bash
php artisan make:model Club
```

**Prompt for Copilot:**

```php
// Configure the Club model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['club_code', 'name_en', 'name_ta', 'name_si', 'job_profile', 'status', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['status' => 'string']
// - Relationships:
//   - clubStaff() hasMany(ClubStaff::class, 'club_id')
//   - staff() belongsToMany(Staff::class, 'club_staff', 'club_id', 'staff_id')->withPivot('role', 'from_date', 'to_date')->withTimestamps()
//   - clubStudents() hasMany(ClubStudent::class, 'club_id')
//   - students() belongsToMany(Student::class, 'club_students', 'club_id', 'student_id')->withPivot('role', 'from_date', 'to_date')->withTimestamps()
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 29: Create Club Staff Migration

```bash
php artisan make:migration create_club_staff_table
```

**Prompt for Copilot:**

```php
// Create the club_staff table with the following schema:
// - id: primary key, big integer, auto-increment
// - club_id: big integer unsigned, not nullable, foreign key to clubs.id, on delete cascade
// - staff_id: big integer unsigned, not nullable, foreign key to staff.id, on delete cascade
// - role: enum ['coordinator', 'assistant', 'advisor'], not nullable
// - from_date: date, not nullable
// - to_date: date, nullable
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: club_id, staff_id, composite index on (from_date, to_date)
// Add unique constraint: unique (club_id, staff_id, role, from_date)
```

---

## Step 30: Create ClubStaff Model

```bash
php artisan make:model ClubStaff
```

**Prompt for Copilot:**

```php
// Configure the ClubStaff model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['club_id', 'staff_id', 'role', 'from_date', 'to_date', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['from_date' => 'date', 'to_date' => 'date', 'role' => 'string']
// - Relationships:
//   - club() belongsTo(Club::class, 'club_id')
//   - staff() belongsTo(Staff::class, 'staff_id')
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 31: Create Club Students Migration

```bash
php artisan make:migration create_club_students_table
```

**Prompt for Copilot:**

```php
// Create the club_students table with the following schema:
// - id: primary key, big integer, auto-increment
// - club_id: big integer unsigned, not nullable, foreign key to clubs.id, on delete cascade
// - student_id: big integer unsigned, not nullable, foreign key to students.id, on delete cascade
// - role: enum ['president', 'vice_president', 'secretary', 'treasurer', 'member'], not nullable
// - from_date: date, not nullable
// - to_date: date, nullable
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: club_id, student_id, composite index on (from_date, to_date)
// Add unique constraint: unique (club_id, student_id, role, from_date)
```

---

## Step 32: Create ClubStudent Model

```bash
php artisan make:model ClubStudent
```

**Prompt for Copilot:**

```php
// Configure the ClubStudent model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['club_id', 'student_id', 'role', 'from_date', 'to_date', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['from_date' => 'date', 'to_date' => 'date', 'role' => 'string']
// - Relationships:
//   - club() belongsTo(Club::class, 'club_id')
//   - student() belongsTo(Student::class, 'student_id')
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 33: Create Routines Migration

```bash
php artisan make:migration create_routines_table
```

**Prompt for Copilot:**

```php
// Create the routines table with the following schema:
// - id: primary key, big integer, auto-increment
// - routine_code: string (50), unique, not nullable
// - name_en: string (200), not nullable
// - name_ta: string (200), nullable
// - name_si: string (200), nullable
// - belongs_to: enum ['administration', 'curriculum', 'co_curricular', 'others'], not nullable
// - type: enum ['daily', 'weekly', 'monthly', 'termly', 'annually'], not nullable
// - description: text, nullable
// - status: enum ['active', 'inactive'], default 'active'
// - created_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - updated_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - deleted_by: big integer unsigned, nullable, foreign key to users.id, on delete set null
// - timestamps()
// - softDeletes()
// Add indexes: routine_code, belongs_to, type, status
```

---

## Step 34: Create Routine Model

```bash
php artisan make:model Routine
```

**Prompt for Copilot:**

```php
// Configure the Routine model:
// - Use HasFactory and SoftDeletes traits
// - $fillable: ['routine_code', 'name_en', 'name_ta', 'name_si', 'belongs_to', 'type', 'description', 'status', 'created_by', 'updated_by', 'deleted_by']
// - $casts: ['status' => 'string', 'belongs_to' => 'string', 'type' => 'string']
// - Relationships:
//   - createdBy() belongsTo(User::class, 'created_by')
//   - updatedBy() belongsTo(User::class, 'updated_by')
//   - deletedBy() belongsTo(User::class, 'deleted_by')
```

---

## Step 35: Run Migrations

```bash
php artisan migrate
```

---

All migrations and models for the Master domain have been generated. The following tables are now ready:

1. ✅ users (Laravel default)
2. ✅ departments
3. ✅ subjects
4. ✅ sections (with self-referencing hierarchy)
5. ✅ subsections (with self-referencing hierarchy)
6. ✅ grades (with self-referencing hierarchy)
7. ✅ classes
8. ✅ staff
9. ✅ students
10. ✅ student_class_history
11. ✅ posts
12. ✅ resources
13. ✅ resource_assignments (polymorphic)
14. ✅ clubs
15. ✅ club_staff
16. ✅ club_students
17. ✅ routines

---

**Next Steps:**
Specify the next domain to process.
