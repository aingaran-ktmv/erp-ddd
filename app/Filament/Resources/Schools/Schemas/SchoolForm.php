<?php

namespace App\Filament\Resources\Schools\Schemas;

use Filament\Schemas\Components\Grid as SchemaGrid;
use Filament\Schemas\Components\Section as SchemaSection;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Schemas\Schema;

class SchoolForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                SchemaSection::make('Identity & Governance')
                    ->description('Reference identifiers and classification for the school.')
                    ->columns(12)
                    ->schema([
                        TextInput::make('school_no')
                            ->label('School Number')
                            ->placeholder('e.g. SCH-0142')
                            ->required()
                            ->maxLength(50)
                            ->columnSpan(4),
                        TextInput::make('school_census_no')
                            ->label('Census Number')
                            ->placeholder('Government-issued census number')
                            ->maxLength(50)
                            ->columnSpan(4),
                        Select::make('school_type')
                            ->label('School Type')
                            ->options([
                                'national' => 'National',
                                'provincial' => 'Provincial',
                                'private' => 'Private',
                                'international' => 'International',
                            ])
                            ->searchable()
                            ->native(false)
                            ->required()
                            ->columnSpan(2),
                        Select::make('school_category')
                            ->label('School Category')
                            ->options([
                                '1ab' => '1AB (A/L Science)',
                                '1c' => '1C (A/L Commerce / Arts)',
                                'type2' => 'Type 2 (Up to O/L)',
                                'type3' => 'Type 3 (Primary Only)',
                                'special' => 'Special Focus',
                            ])
                            ->searchable()
                            ->native(false)
                            ->required()
                            ->columnSpan(2),
                    ]),

                SchemaSection::make('Naming & Language')
                    ->columns(12)
                    ->schema([
                        Textarea::make('school_name_en')
                            ->label('Official Name (English)')
                            ->placeholder('Enter the commonly used English name')
                            ->rows(2)
                            ->required()
                            ->maxLength(255)
                            ->columnSpan(4),
                        Textarea::make('school_name_ta')
                            ->label('Official Name (Tamil)')
                            ->rows(2)
                            ->maxLength(255)
                            ->columnSpan(4),
                        Textarea::make('school_name_si')
                            ->label('Official Name (Sinhala)')
                            ->rows(2)
                            ->maxLength(255)
                            ->columnSpan(4),
                    ]),

                SchemaSection::make('Location Overview')
                    ->description('Administrative hierarchy and postal address.')
                    ->schema([
                        SchemaGrid::make()
                            ->columns([
                                'sm' => 2,
                                'lg' => 4,
                            ])
                            ->schema([
                                TextInput::make('province')
                                    ->label('Province')
                                    ->required()
                                    ->maxLength(120),
                                TextInput::make('district')
                                    ->label('District')
                                    ->required()
                                    ->maxLength(120),
                                TextInput::make('zone')
                                    ->label('Zone / Education Office')
                                    ->required()
                                    ->maxLength(120),
                                TextInput::make('division')
                                    ->label('Division / DS Office')
                                    ->required()
                                    ->maxLength(120),
                            ]),
                        Textarea::make('address')
                            ->label('Full Postal Address')
                            ->placeholder('Street address, town, postal code')
                            ->rows(3)
                            ->required()
                            ->columnSpanFull(),
                    ]),

                SchemaSection::make('Contact & Digital Presence')
                    ->columns([
                        'sm' => 2,
                        'lg' => 4,
                    ])
                    ->schema([
                        TextInput::make('phone')
                            ->label('Primary Phone')
                            ->placeholder('+94 11 234 5678')
                            ->tel()
                            ->maxLength(30),
                        TextInput::make('email')
                            ->label('Contact Email')
                            ->placeholder('info@school.lk')
                            ->email()
                            ->maxLength(255),
                        TextInput::make('website')
                            ->label('Website URL')
                            ->placeholder('https://www.school.lk')
                            ->url()
                            ->maxLength(255),
                        TextInput::make('school_map_url')
                            ->label('Map Link')
                            ->placeholder('https://maps.google.com/...')
                            ->url()
                            ->maxLength(255)
                            ->columnSpan(['sm' => 2, 'lg' => 4]),
                    ]),

                SchemaSection::make('History & Coordinates')
                    ->columns([
                        'sm' => 2,
                        'lg' => 4,
                    ])
                    ->schema([
                        TextInput::make('established_year')
                            ->label('Established Year')
                            ->numeric()
                            ->minValue(1800)
                            ->maxValue((int) date('Y'))
                            ->placeholder('e.g. 1952'),
                        TextInput::make('geo_lat')
                            ->label('Latitude (decimal)')
                            ->numeric()
                            ->step('0.000001'),
                        TextInput::make('geo_lng')
                            ->label('Longitude (decimal)')
                            ->numeric()
                            ->step('0.000001'),
                    ]),
            ]);
    }
}
