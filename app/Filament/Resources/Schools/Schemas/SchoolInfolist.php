<?php

namespace App\Filament\Resources\Schools\Schemas;

use Filament\Infolists;
use Filament\Schemas;
use Filament\Schemas\Components\Text as SchemaText;

class SchoolInfolist
{
    // Differentiated style: softer labels (slate), greenish values (emerald) to match Modern Mint
    private const LABEL_COLOR = 'slate';
    private const VALUE_COLOR = 'emerald';
    private const TEXT_SIZE = 'base';

    public static function section(): Schemas\Components\Section
    {
        return Schemas\Components\Section::make('School Details')
            ->columns(2)
            ->schema([
                Infolists\Components\TextEntry::make('school_no')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('School No')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('school_census_no')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Census No')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('school_name_en')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Name (EN)')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('school_name_ta')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Name (TA)')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('school_name_si')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Name (SI)')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('school_type')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Type')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('school_category')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Category')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('division')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Division')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('zone')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Zone')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('district')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('District')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('province')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Province')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('address')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Address')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—')
                    ->columnSpanFull(),

                Infolists\Components\TextEntry::make('phone')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Phone')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('email')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Email')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('website')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Website')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—')
                    ->url(fn($record) => $record->website
                        ? (str_starts_with($record->website, 'http') ? $record->website : 'https://' . $record->website)
                        : null, true),

                Infolists\Components\TextEntry::make('established_year')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Established Year')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('geo_lat')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Latitude')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('geo_lng')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Longitude')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—'),

                Infolists\Components\TextEntry::make('school_map_url')
                    ->hiddenLabel()
                    ->aboveLabel(SchemaText::make('Map URL')->size(self::TEXT_SIZE)->color(self::LABEL_COLOR)->weight('medium'))
                    ->size(self::TEXT_SIZE)
                    ->color(self::VALUE_COLOR)
                    ->weight('semibold')
                    ->placeholder('—')
                    ->url(fn($record) => $record->school_map_url ?: null, true)
                    ->columnSpanFull(),
            ]);
    }
}
