<?php

namespace App\Filament\Imports;

use App\Models\School;
use Filament\Actions\Imports\ImportColumn;
use Filament\Actions\Imports\Importer;
use Filament\Actions\Imports\Models\Import;
use Illuminate\Support\Str;

class SchoolImporter extends Importer
{
    protected static ?string $model = School::class;

    protected static int $chunkSize = 100;

    public static function getColumns(): array
    {
        return [
            ImportColumn::make('school_no')
                ->label('School No')
                ->requiredMapping()
                ->rules(['required', 'max:255'])
                ->guess(['school_no', 'school no', 'no'])
                ->example('SCH001'),
            ImportColumn::make('school_census_no')
                ->label('Census No')
                ->rules(['nullable', 'max:255'])
                ->guess(['school_census_no', 'census_no', 'census no'])
                ->example('CEN-2023-001'),
            ImportColumn::make('school_name_en')
                ->label('Name (EN)')
                ->requiredMapping()
                ->rules(['required', 'max:255'])
                ->guess(['school_name_en', 'name_en', 'school name', 'name'])
                ->example('Central College'),
            ImportColumn::make('school_name_ta')
                ->label('Name (TA)')
                ->rules(['nullable', 'max:255'])
                ->guess(['school_name_ta', 'name_ta', 'tamil name'])
                ->example('மத்திய கல்லூரி'),
            ImportColumn::make('school_name_si')
                ->label('Name (SI)')
                ->rules(['nullable', 'max:255'])
                ->guess(['school_name_si', 'name_si', 'sinhala name'])
                ->example('මධ්‍යම විද්‍යාලය'),
            ImportColumn::make('school_type')
                ->label('Type')
                ->requiredMapping()
                ->rules(['required', 'in:1AB,1C,type2,type3'])
                ->guess(['school_type', 'type'])
                ->example('1AB'),
            ImportColumn::make('school_category')
                ->label('Category')
                ->requiredMapping()
                ->rules(['required', 'in:national,province,private,semigovernment'])
                ->guess(['school_category', 'category'])
                ->example('national'),
            ImportColumn::make('division')
                ->label('Division')
                ->rules(['nullable', 'max:255'])
                ->guess(['division'])
                ->example('Colombo'),
            ImportColumn::make('zone')
                ->label('Zone')
                ->rules(['nullable', 'max:255'])
                ->guess(['zone'])
                ->example('Zone 1'),
            ImportColumn::make('district')
                ->label('District')
                ->rules(['nullable', 'max:255'])
                ->guess(['district'])
                ->example('Colombo'),
            ImportColumn::make('province')
                ->label('Province')
                ->rules(['nullable', 'max:255'])
                ->guess(['province'])
                ->example('Western'),
            ImportColumn::make('address')
                ->label('Address')
                ->rules(['nullable'])
                ->guess(['address'])
                ->example('123 Main Street, Colombo 07'),
            ImportColumn::make('phone')
                ->label('Phone')
                ->rules(['nullable', 'max:255'])
                ->guess(['phone', 'telephone', 'contact', 'tel'])
                ->example('011-2345678'),
            ImportColumn::make('email')
                ->label('Email')
                ->rules(['nullable', 'email', 'max:255'])
                ->guess(['email', 'e-mail', 'mail'])
                ->example('info@school.lk'),
            ImportColumn::make('website')
                ->label('Website')
                ->rules(['nullable', 'url', 'max:255'])
                ->guess(['website', 'url', 'web', 'site'])
                ->example('https://www.school.lk'),
            ImportColumn::make('established_year')
                ->label('Established Year')
                ->rules(['nullable', 'integer', 'min:1800', 'max:' . date('Y')])
                ->guess(['established_year', 'year', 'established', 'founded'])
                ->example('1985'),
            ImportColumn::make('geo_lat')
                ->label('Latitude')
                ->rules(['nullable', 'numeric', 'between:-90,90'])
                ->guess(['geo_lat', 'lat', 'latitude'])
                ->example('6.9271'),
            ImportColumn::make('geo_lng')
                ->label('Longitude')
                ->rules(['nullable', 'numeric', 'between:-180,180'])
                ->guess(['geo_lng', 'lng', 'lon', 'longitude'])
                ->example('79.8612'),
            ImportColumn::make('school_map_url')
                ->label('Map URL')
                ->rules(['nullable', 'url'])
                ->guess(['school_map_url', 'map_url', 'map', 'google_maps'])
                ->example('https://maps.google.com/?q=6.9271,79.8612'),
        ];
    }

    public function resolveRecord(): ?School
    {
        // Try to find existing school by school_no
        return School::firstOrNew([
            'school_no' => $this->data['school_no'],
        ]);
    }

    protected function beforeFill(): void
    {
        // Transform and clean data before validation and filling

        // Trim all string values
        $this->data = array_map(function ($value) {
            return is_string($value) ? trim($value) : $value;
        }, $this->data);

        // Normalize school_no (uppercase, remove extra spaces)
        if (!empty($this->data['school_no'])) {
            $this->data['school_no'] = strtoupper(preg_replace('/\s+/', '', $this->data['school_no']));
        }

        // Normalize school_type (lowercase to match validation)
        if (!empty($this->data['school_type'])) {
            $type = strtolower(trim($this->data['school_type']));
            // Handle common variations
            $typeMap = [
                '1ab' => '1AB',
                '1 ab' => '1AB',
                '1-ab' => '1AB',
                '1c' => '1C',
                '1 c' => '1C',
                '1-c' => '1C',
                'type 2' => 'type2',
                'type-2' => 'type2',
                'type 3' => 'type3',
                'type-3' => 'type3',
            ];
            $this->data['school_type'] = $typeMap[$type] ?? $this->data['school_type'];
        }

        // Normalize school_category (lowercase)
        if (!empty($this->data['school_category'])) {
            $category = strtolower(trim($this->data['school_category']));
            // Handle common variations
            $categoryMap = [
                'semi-government' => 'semigovernment',
                'semi government' => 'semigovernment',
                'provincial' => 'province',
            ];
            $this->data['school_category'] = $categoryMap[$category] ?? $category;
        }

        // Normalize email (lowercase)
        if (!empty($this->data['email'])) {
            $this->data['email'] = strtolower(trim($this->data['email']));
        }

        // Normalize website (ensure proper URL format)
        if (!empty($this->data['website'])) {
            $website = trim($this->data['website']);
            // Add https:// if no protocol specified
            if (!preg_match('/^https?:\/\//i', $website)) {
                $this->data['website'] = 'https://' . $website;
            } else {
                $this->data['website'] = $website;
            }
        }

        // Normalize phone (remove common separators for consistency, but keep original format)
        if (!empty($this->data['phone'])) {
            $this->data['phone'] = trim($this->data['phone']);
        }

        // Convert empty strings to null for nullable fields
        $nullableFields = [
            'school_census_no',
            'school_name_ta',
            'school_name_si',
            'division',
            'zone',
            'district',
            'province',
            'address',
            'phone',
            'email',
            'website',
            'established_year',
            'geo_lat',
            'geo_lng',
            'school_map_url'
        ];

        foreach ($nullableFields as $field) {
            if (isset($this->data[$field]) && $this->data[$field] === '') {
                $this->data[$field] = null;
            }
        }

        // Convert numeric strings to proper types
        if (!empty($this->data['established_year']) && is_string($this->data['established_year'])) {
            $this->data['established_year'] = (int) $this->data['established_year'];
        }

        if (!empty($this->data['geo_lat']) && is_string($this->data['geo_lat'])) {
            $this->data['geo_lat'] = (float) $this->data['geo_lat'];
        }

        if (!empty($this->data['geo_lng']) && is_string($this->data['geo_lng'])) {
            $this->data['geo_lng'] = (float) $this->data['geo_lng'];
        }

        // Capitalize proper names for consistency
        if (!empty($this->data['school_name_en'])) {
            $this->data['school_name_en'] = Str::title($this->data['school_name_en']);
        }

        if (!empty($this->data['province'])) {
            $this->data['province'] = Str::title($this->data['province']);
        }

        if (!empty($this->data['district'])) {
            $this->data['district'] = Str::title($this->data['district']);
        }

        if (!empty($this->data['division'])) {
            $this->data['division'] = Str::title($this->data['division']);
        }
    }

    public static function getCompletedNotificationBody(Import $import): string
    {
        $body = 'Your school import has completed and ' . number_format($import->successful_rows) . ' ' . str('row')->plural($import->successful_rows) . ' imported.';

        if ($failedRowsCount = $import->getFailedRowsCount()) {
            $body .= ' ' . number_format($failedRowsCount) . ' ' . str('row')->plural($failedRowsCount) . ' failed to import.';
        }

        return $body;
    }
}
