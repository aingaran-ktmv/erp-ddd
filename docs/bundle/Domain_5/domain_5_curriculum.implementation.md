# Domain 5 — Curriculum Implementation
## Module: `daily_periods_complete`
Tracks whether each scheduled period (per class & date) was conducted. UI follows our established Filament patterns (see ai_guide_filament_master.md).

---

## 1) Data Model

**Table:** `daily_periods_complete`  
**Primary Key:** `id BIGINT UNSIGNED AUTO_INCREMENT`  
**Natural Uniqueness:** `(class_code, date, period)` (unique index)  
**Foreign Keys:**  
- `class_code → school_class_structure(class_code)`

**Columns**
- `id` (PK)
- `class_code` VARCHAR(50) NOT NULL
- `date` DATE NOT NULL
- `period` SMALLINT UNSIGNED NOT NULL
- `is_conducted` BOOLEAN NOT NULL DEFAULT FALSE
- `created_by, updated_by, deleted_by` BIGINT UNSIGNED NULL
- `created_at, updated_at, deleted_at` TIMESTAMP NULL
- `soft_delete` BOOLEAN NOT NULL DEFAULT FALSE

**Indexes**
- `uq_dpc_class_date_period (class_code, date, period)` (UNIQUE)
- `idx_dpc_date (date)`
- `idx_dpc_class_date (class_code, date)`

**Rules**
- Only periods existing in the official timetable for that class & weekday are toggleable (validate in UI/service).

---

## 2) Migration (Laravel)

```php
// database/migrations/2025_01_01_000000_create_daily_periods_complete_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::create('daily_periods_complete', function (Blueprint $table) {
            $table->id();
            $table->string('class_code', 50);
            $table->date('date');
            $table->unsignedSmallInteger('period');
            $table->boolean('is_conducted')->default(false);

            // Audit
            $table->unsignedBigInteger('created_by')->nullable();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->unsignedBigInteger('deleted_by')->nullable();
            $table->timestamps();
            $table->timestamp('deleted_at')->nullable();
            $table->boolean('soft_delete')->default(false);

            $table->unique(['class_code','date','period'], 'uq_dpc_class_date_period');
            $table->index(['class_code','date'], 'idx_dpc_class_date');
            $table->index('date', 'idx_dpc_date');

            $table->foreign('class_code')->references('class_code')->on('school_class_structure');
        });
    }
    public function down(): void {
        Schema::dropIfExists('daily_periods_complete');
    }
};
```

---

## 3) Eloquent Model

```php
// app/Models/DailyPeriodComplete.php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DailyPeriodComplete extends Model
{
    protected $table = 'daily_periods_complete';

    protected $fillable = [
        'class_code','date','period','is_conducted',
        'created_by','updated_by','deleted_by','soft_delete'
    ];

    protected $casts = [
        'date' => 'date',
        'is_conducted' => 'boolean',
    ];
}
```

---

## 4) Service (Toggle / Upsert)

```php
// app/Services/DailyPeriodService.php
namespace App\Services;

use App\Models\DailyPeriodComplete;
use Carbon\Carbon;

class DailyPeriodService
{
    public function setConducted(string $classCode, Carbon $date, int $period, bool $conducted): DailyPeriodComplete
    {
        // TODO: validate timetable existence for (classCode, weekday, period)
        return DailyPeriodComplete::updateOrCreate(
            ['class_code' => $classCode, 'date' => $date->toDateString(), 'period' => $period],
            ['is_conducted' => $conducted]
        );
    }
}
```

---

## 5) Filament Resource

```php
// app/Filament/Resources/DailyPeriodCompleteResource.php
namespace App\Filament\Resources;

use App\Filament\Resources\DailyPeriodCompleteResource\Pages;
use App\Models\DailyPeriodComplete;
use Filament\Forms;
use Filament\Resources\Form;
use Filament\Resources\Table;
use Filament\Tables;
use Filament\Resources\Resource;
use Filament\Infolists;
use Filament\Infolists\Infolist;

class DailyPeriodCompleteResource extends Resource
{
    protected static ?string $model = DailyPeriodComplete::class;
    protected static ?string $navigationGroup = 'Academics';
    protected static ?string $navigationIcon = 'heroicon-o-check-circle';
    protected static ?string $navigationLabel = 'Daily Periods – Conducted';

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Group::make([
                Forms\Components\TextInput::make('class_code')
                    ->label('Class Code')
                    ->required()
                    ->maxLength(50),
                Forms\Components\DatePicker::make('date')->required(),
                Forms\Components\TextInput::make('period')
                    ->numeric()->minValue(1)->required(),
                Forms\Components\Toggle::make('is_conducted')->label('Conducted'),
            ])->columns(2),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('date')->date(),
                Tables\Columns\TextColumn::make('class_code')->searchable(),
                Tables\Columns\TextColumn::make('period')->sortable(),
                Tables\Columns\IconColumn::make('is_conducted')->boolean(),
            ])
            ->filters([
                Tables\Filters\Filter::make('date')->form([
                    Forms\Components\DatePicker::make('date'),
                ]),
            ])
            ->actions([
                Tables\Actions\Action::make('toggle')
                    ->label('Toggle')
                    ->action(fn (DailyPeriodComplete $record) => $record->update(['is_conducted' => ! $record->is_conducted])),
                Tables\Actions\EditAction::make(),
                Tables\Actions\ViewAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkAction::make('mark_all_conducted')
                    ->label('Mark All Conducted')
                    ->action(fn ($records) => $records->each->update(['is_conducted' => true])),
                Tables\Actions\BulkAction::make('clear_all')
                    ->label('Clear All')
                    ->action(fn ($records) => $records->each->update(['is_conducted' => false])),
            ]);
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist->schema([
            Infolists\Components\TextEntry::make('date')->date(),
            Infolists\Components\TextEntry::make('class_code'),
            Infolists\Components\TextEntry::make('period'),
            Infolists\Components\IconEntry::make('is_conducted')->boolean(),
            Infolists\Components\KeyValueEntry::make('meta') // placeholder for derived Subject/Teacher
                ->label('Derived (Subject & Teacher)')
                ->default(['subject' => '—', 'teacher' => '—']),
        ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListDailyPeriodCompletes::route('/'),
            'create' => Pages\CreateDailyPeriodComplete::route('/create'),
            'edit' => Pages\EditDailyPeriodComplete::route('/{record}/edit'),
            'view' => Pages\ViewDailyPeriodComplete::route('/{record}'),
        ];
    }
}
```

**Pages (generated by Filament artisan):**
```bash
php artisan make:filament-resource DailyPeriodComplete --view --generate
```

This produces the `List`, `Create`, `Edit`, and `View` pages.

---

## 6) Custom Page: “Class Day Grid” (Single-row or multi-card layout)

```php
// app/Filament/Resources/DailyPeriodCompleteResource/Pages/ClassDayGrid.php
namespace App\Filament\Resources\DailyPeriodCompleteResource\Pages;

use App\Filament\Resources\DailyPeriodCompleteResource;
use Filament\Resources\Pages\Page;
use App\Services\DailyPeriodService;
use Illuminate\Support\Arr;

class ClassDayGrid extends Page
{
    protected static string $resource = DailyPeriodCompleteResource::class;
    protected static string $view = 'filament.resources.daily-period-complete.pages.class-day-grid';
    protected static ?string $navigationLabel = 'Class Day Grid';

    public $class_code;
    public $date;
    public $periods = []; // hydrate from timetable service

    public function mount(): void
    {
        $this->date = request('date') ?? now()->toDateString();
        $this->class_code = request('class_code') ?? '6A';

        // TODO: hydrate $this->periods from timetable (subject, teacher, period, is_conducted)
        // $this->periods = app(TimetableService::class)->forClassDate($this->class_code, $this->date);
    }

    public function save(): void
    {
        $service = app(DailyPeriodService::class);
        foreach ($this->periods as $p) {
            $service->setConducted($this->class_code, now()->parse($this->date), (int) $p['period'], (bool) $p['is_conducted']);
        }
        $this->dispatchBrowserEvent('notify', ['message' => 'Saved conducted statuses']);
    }
}
```

**Blade view for the page (simplified):**
```php
<!-- resources/views/filament/resources/daily-period-complete/pages/class-day-grid.blade.php -->
<x-filament::page>
    <div class="flex items-center justify-between mb-4">
        <div>
            <div class="text-xl font-semibold">Class Day Grid</div>
            <div class="text-sm text-gray-500">Class: {{ $class_code }} • Date: {{ $date }}</div>
        </div>
        <x-filament::button wire:click="save">Save</x-filament::button>
    </div>

    <div class="grid md:grid-cols-3 gap-4">
        @foreach ($periods as $p)
            <div class="rounded-2xl border p-4 bg-white">
                <div class="flex items-center justify-between">
                    <div>
                        <div class="text-xs text-gray-500">Period</div>
                        <div class="text-xl font-semibold">{{ $p['period'] }}</div>
                    </div>
                    <x-filament::toggle
                        wire:model="periods.{{ $loop->index }}.is_conducted"
                    />
                </div>
                <div class="mt-3">
                    <div class="text-sm font-medium">{{ $p['subject'] }}</div>
                    <div class="text-xs text-gray-500">{{ $p['teacher'] }}</div>
                </div>
            </div>
        @endforeach
    </div>
</x-filament::page>
```

To register the page route inside the resource:

```php
// In DailyPeriodCompleteResource::getPages()
'grid' => Pages\ClassDayGrid::route('/grid'),
```

You can link to it from the index table with a table action that passes `class_code` and `date` as query parameters.

---

## 7) Policies & Validation

- Authorize toggles to teachers of the class or academic admins.
- Validate that `(class_code, date, period)` exists in the official timetable on save.

---

## 8) Reporting

- Aggregate by `(class_code, date)` to compute % conducted.
- Feed Reporting domain widgets from a view:
```sql
CREATE OR REPLACE VIEW vw_daily_periods_conducted_rate AS
SELECT class_code, date,
       SUM(CASE WHEN is_conducted THEN 1 ELSE 0 END) AS periods_conducted,
       COUNT(*) AS periods_total,
       ROUND(SUM(CASE WHEN is_conducted THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0) * 100, 2) AS completion_rate
FROM daily_periods_complete
GROUP BY class_code, date;
```
