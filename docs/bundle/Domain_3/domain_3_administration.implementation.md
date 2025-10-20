# Laravel ORM Code-First Implementation Guide - Domain 4: Administration

Notes

- Use unsignedBigInteger FKs to staff, subjects, classes, posts; audit FKs to users(id).
- Each migration: timestamps(), softDeletes(), created_by/updated_by/deleted_by with onDelete set null.
- Order matters when running migrations as listed below.

## Step 1: Create Subject Groups Migration

```bash
php artisan make:migration create_subject_groups_table
```

```php
// Create subject_groups:
// - id, group_code string(50) unique, group_name string(200), year YEAR
// - audit FKs, timestamps(), softDeletes()
// Indexes: group_code, year
```

## Step 2: Create SubjectGroup Model

```bash
php artisan make:model SubjectGroup
```

```php
// Model: SubjectGroup
// - Use HasFactory, SoftDeletes
// - $fillable: ['group_code','group_name','year','created_by','updated_by','deleted_by']
// - Relationships: createdBy/updatedBy/deletedBy -> belongsTo(User::class)
```

---

## Step 3: Create Subject Periods Migration

```bash
php artisan make:migration create_subject_periods_table
```

```php
// Create subject_periods:
// - subject_id FK->subjects.id, year YEAR, period_per_week tinyInteger unsigned
// - unique(subject_id, year); audit FKs; timestamps(); softDeletes()
// Indexes: subject_id, year
```

## Step 4: Create SubjectPeriod Model

```bash
php artisan make:model SubjectPeriod
```

```php
// Model: SubjectPeriod
// - $fillable: ['subject_id','year','period_per_week','created_by','updated_by','deleted_by']
// - $casts: ['year'=>'integer','period_per_week'=>'integer']
// - Relationships: subject()->belongsTo(Subject::class); createdBy/updatedBy/deletedBy()->belongsTo(User::class)
```

---

## Step 5: Create Period Time Slots Migration

```bash
php artisan make:migration create_period_time_slots_table
```

```php
// Create period_time_slots:
// - period_code string(50) unique, start_time TIME, end_time TIME, year YEAR
// - audit FKs; timestamps(); softDeletes()
// Indexes: period_code, year
```

## Step 6: Create PeriodTimeSlot Model

```bash
php artisan make:model PeriodTimeSlot
```

```php
// Model: PeriodTimeSlot
// - $fillable: ['period_code','start_time','end_time','year','created_by','updated_by','deleted_by']
// - $casts: ['start_time'=>'datetime:H:i:s','end_time'=>'datetime:H:i:s','year'=>'integer']
// - Relationships: createdBy/updatedBy/deletedBy()->belongsTo(User::class)
```

---

## Step 7: Create Staff Pins Migration

```bash
php artisan make:migration create_staff_pins_table
```

```php
// Create staff_pins:
// - staff_id FK->staff.id, year YEAR, pin string(100)
// - unique(staff_id, year); audit FKs; timestamps(); softDeletes()
// Indexes: staff_id, year
```

## Step 8: Create StaffPin Model

```bash
php artisan make:model StaffPin
```

```php
// Model: StaffPin
// - $fillable: ['staff_id','year','pin','created_by','updated_by','deleted_by']
// - $casts: ['year'=>'integer']
// - Relationships: staff()->belongsTo(Staff::class); createdBy/updatedBy/deletedBy()->belongsTo(User::class)
```

---

## Step 9: Create Staff Duties Migration

```bash
php artisan make:migration create_staff_duties_table
```

```php
// Create staff_duties:
// - staff_id FK->staff.id, duty_code string(50) unique, post_id FK->posts.id
// - from_date DATE nullable, to_date DATE nullable
// - audit FKs; timestamps(); softDeletes()
// Indexes: staff_id, post_id, (from_date, to_date)
```

## Step 10: Create StaffDuty Model

```bash
php artisan make:model StaffDuty
```

```php
// Model: StaffDuty
// - $fillable: ['staff_id','duty_code','post_id','from_date','to_date','created_by','updated_by','deleted_by']
// - $casts: ['from_date'=>'date','to_date'=>'date']
// - Relationships: staff()->belongsTo(Staff::class); post()->belongsTo(Post::class);
//   createdBy/updatedBy/deletedBy()->belongsTo(User::class)
```

---

## Step 11: Create Class Subjects Migration

```bash
php artisan make:migration create_class_subjects_table
```

```php
// Create class_subjects:
// - class_id FK->classes.id, subject_id FK->subjects.id
// - unique(class_id, subject_id); audit FKs; timestamps(); softDeletes()
// Indexes: class_id, subject_id
```

## Step 12: Create ClassSubject Model

```bash
php artisan make:model ClassSubject
```

```php
// Model: ClassSubject
// - $fillable: ['class_id','subject_id','created_by','updated_by','deleted_by']
// - Relationships: class()->belongsTo(Classes::class,'class_id'); subject()->belongsTo(Subject::class);
//   createdBy/updatedBy/deletedBy()->belongsTo(User::class)
```

---

## Step 13: Create Class Teachers Migration

```bash
php artisan make:migration create_class_teachers_table
```

```php
// Create class_teachers:
// - staff_id FK->staff.id, class_id FK->classes.id, year YEAR
// - unique(class_id, year); audit FKs; timestamps(); softDeletes()
// Indexes: staff_id, class_id, year
```

## Step 14: Create ClassTeacher Model

```bash
php artisan make:model ClassTeacher
```

```php
// Model: ClassTeacher
// - $fillable: ['staff_id','class_id','year','created_by','updated_by','deleted_by']
// - $casts: ['year'=>'integer']
// - Relationships: staff()->belongsTo(Staff::class); class()->belongsTo(Classes::class);
//   createdBy/updatedBy/deletedBy()->belongsTo(User::class)
```

---

## Step 15: Create Teacher Subject Classes Migration

```bash
php artisan make:migration create_teacher_subject_classes_table
```

```php
// Create teacher_subject_classes:
// - staff_id FK->staff.id, subject_id FK->subjects.id, class_id FK->classes.id, year YEAR
// - unique(staff_id, subject_id, class_id, year); audit FKs; timestamps(); softDeletes()
// Indexes: staff_id, subject_id, class_id, year
```

## Step 16: Create TeacherSubjectClass Model

```bash
php artisan make:model TeacherSubjectClass
```

```php
// Model: TeacherSubjectClass
// - $fillable: ['staff_id','subject_id','class_id','year','created_by','updated_by','deleted_by']
// - $casts: ['year'=>'integer']
// - Relationships: staff()->belongsTo(Staff::class); subject()->belongsTo(Subject::class);
//   class()->belongsTo(Classes::class); createdBy/updatedBy/deletedBy()->belongsTo(User::class)
```

---

## Step 17: Create Timetables Migration

```bash
php artisan make:migration create_timetables_table
```

```php
// Create timetables:
// - class_id FK->classes.id, subject_id FK->subjects.id, period_time_slot_id FK->period_time_slots.id
// - week_day tinyInteger unsigned (1..7), staff_id FK->staff.id
// - unique(class_id, week_day, period_time_slot_id); audit FKs; timestamps(); softDeletes()
// Indexes: class_id, subject_id, week_day, period_time_slot_id, staff_id
```

## Step 18: Create Timetable Model

```bash
php artisan make:model Timetable
```

```php
// Model: Timetable
// - $fillable: ['class_id','subject_id','period_time_slot_id','week_day','staff_id','created_by','updated_by','deleted_by']
// - $casts: ['week_day'=>'integer']
// - Relationships: class()->belongsTo(Classes::class); subject()->belongsTo(Subject::class);
//   periodTimeSlot()->belongsTo(PeriodTimeSlot::class,'period_time_slot_id');
//   staff()->belongsTo(Staff::class); createdBy/updatedBy/deletedBy()->belongsTo(User::class)
```

---

## Step 19: Create Events Migration

```bash
php artisan make:migration create_events_table
```

```php
// Create events:
// - event_code string(50) unique, description text, event_date DATE, event_time TIME, responsibility string(200) nullable
// - audit FKs; timestamps(); softDeletes()
// Indexes: event_code, event_date
```

## Step 20: Create Event Model

```bash
php artisan make:model Event
```

```php
// Model: Event
// - $fillable: ['event_code','description','event_date','event_time','responsibility','created_by','updated_by','deleted_by']
// - $casts: ['event_date'=>'date','event_time'=>'datetime:H:i:s']
// - Relationships: createdBy/updatedBy/deletedBy()->belongsTo(User::class)
```

---

## Step 21: Create Daily Substitutions Migration

```bash
php artisan make:migration create_daily_substitutions_table
```

```php
// Create daily_substitutions:
// - sub_date DATE, class_id FK->classes.id, period_no tinyInteger unsigned
// - original_staff_id FK->staff.id, substitute_staff_id FK->staff.id, reason text nullable
// - unique(sub_date, class_id, period_no); audit FKs; timestamps(); softDeletes()
// Indexes: sub_date, class_id, period_no, original_staff_id, substitute_staff_id
```

## Step 22: Create DailySubstitution Model

```bash
php artisan make:model DailySubstitution
```

```php
// Model: DailySubstitution
// - $fillable: ['sub_date','class_id','period_no','original_staff_id','substitute_staff_id','reason','created_by','updated_by','deleted_by']
// - $casts: ['sub_date'=>'date','period_no'=>'integer']
// - Relationships: class()->belongsTo(Classes::class); originalStaff()->belongsTo(Staff::class,'original_staff_id');
//   substituteStaff()->belongsTo(Staff::class,'substitute_staff_id'); createdBy/updatedBy/deletedBy()->belongsTo(User::class)
```

---

## Final Step: Run Migrations

```bash
php artisan migrate
```

Ready tables for Domain 4: Administration

1. subject_groups
2. subject_periods
3. period_time_slots
4. staff_pins
5. staff_duties
6. class_subjects
7. class_teachers
8. teacher_subject_classes
9. timetables
10. events
11. daily_substitutions
