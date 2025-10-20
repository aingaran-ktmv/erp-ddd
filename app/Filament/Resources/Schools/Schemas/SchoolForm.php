<?php

namespace App\Filament\Resources\Schools\Schemas;

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
                TextInput::make('school_no')
                    ->required(),
                TextInput::make('school_census_no'),
                Textarea::make('school_name_en')
                    ->required()
                    ->columnSpanFull(),
                Textarea::make('school_name_ta')
                    ->columnSpanFull(),
                Textarea::make('school_name_si')
                    ->columnSpanFull(),
                Select::make('school_type')
                    ->options(['1AB' => '1 a b', '1C' => '1 c', 'type2' => 'Type2', 'type3' => 'Type3'])
                    ->required(),
                Select::make('school_category')
                    ->options([
            'national' => 'National',
            'province' => 'Province',
            'private' => 'Private',
            'semigovernment' => 'Semigovernment',
        ])
                    ->required(),
                TextInput::make('division'),
                TextInput::make('zone'),
                TextInput::make('district'),
                TextInput::make('province'),
                Textarea::make('address')
                    ->columnSpanFull(),
                TextInput::make('phone')
                    ->tel(),
                TextInput::make('email')
                    ->label('Email address')
                    ->email(),
                TextInput::make('website')
                    ->url(),
                TextInput::make('established_year'),
                TextInput::make('geo_lat')
                    ->numeric(),
                TextInput::make('geo_lng')
                    ->numeric(),
                Textarea::make('school_map_url')
                    ->columnSpanFull(),
                TextInput::make('created_by')
                    ->numeric(),
                TextInput::make('updated_by')
                    ->numeric(),
                TextInput::make('deleted_by')
                    ->numeric(),
            ]);
    }
}
