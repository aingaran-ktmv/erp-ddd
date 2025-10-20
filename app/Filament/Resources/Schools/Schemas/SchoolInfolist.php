<?php

namespace App\Filament\Resources\Schools\Schemas;

use Filament\Infolists;
use Filament\Schemas;

class SchoolInfolist
{
  public static function section(): Schemas\Components\Section
  {
    return Schemas\Components\Section::make('School Details')
      ->columns(2)
      ->schema([
        Infolists\Components\TextEntry::make('school_no')->label('School No')->placeholder('—'),
        Infolists\Components\TextEntry::make('school_census_no')->label('Census No')->placeholder('—'),
        Infolists\Components\TextEntry::make('school_name_en')->label('Name (EN)')->placeholder('—'),
        Infolists\Components\TextEntry::make('school_name_ta')->label('Name (TA)')->placeholder('—'),
        Infolists\Components\TextEntry::make('school_name_si')->label('Name (SI)')->placeholder('—'),
        Infolists\Components\TextEntry::make('school_type')->label('Type')->placeholder('—'),
        Infolists\Components\TextEntry::make('school_category')->label('Category')->placeholder('—'),
        Infolists\Components\TextEntry::make('division')->label('Division')->placeholder('—'),
        Infolists\Components\TextEntry::make('zone')->label('Zone')->placeholder('—'),
        Infolists\Components\TextEntry::make('district')->label('District')->placeholder('—'),
        Infolists\Components\TextEntry::make('province')->label('Province')->placeholder('—'),
        Infolists\Components\TextEntry::make('address')->label('Address')->placeholder('—')->columnSpanFull(),
        Infolists\Components\TextEntry::make('phone')->label('Phone')->placeholder('—'),
        Infolists\Components\TextEntry::make('email')->label('Email')->placeholder('—'),
        Infolists\Components\TextEntry::make('website')
          ->label('Website')
          ->placeholder('—')
          ->url(fn($record) => $record->website
            ? (str_starts_with($record->website, 'http') ? $record->website : 'https://' . $record->website)
            : null, true),
        Infolists\Components\TextEntry::make('established_year')->label('Established Year')->placeholder('—'),
        Infolists\Components\TextEntry::make('geo_lat')->label('Latitude')->placeholder('—'),
        Infolists\Components\TextEntry::make('geo_lng')->label('Longitude')->placeholder('—'),
        Infolists\Components\TextEntry::make('school_map_url')
          ->label('Map URL')
          ->placeholder('—')
          ->url(fn($record) => $record->school_map_url ?: null, true)
          ->columnSpanFull(),
      ]);
  }
}
