<?php

namespace App\Filament\Exports;

use App\Models\School;
use Filament\Actions\Exports\ExportColumn;
use Filament\Actions\Exports\Exporter;
use Filament\Actions\Exports\Models\Export;

class SchoolExporter extends Exporter
{
  protected static ?string $model = School::class;

  public static function getColumns(): array
  {
    return [
      ExportColumn::make('school_no')
        ->label('School No'),
      ExportColumn::make('school_census_no')
        ->label('Census No'),
      ExportColumn::make('school_name_en')
        ->label('Name (EN)'),
      ExportColumn::make('school_name_ta')
        ->label('Name (TA)'),
      ExportColumn::make('school_name_si')
        ->label('Name (SI)'),
      ExportColumn::make('school_type')
        ->label('Type'),
      ExportColumn::make('school_category')
        ->label('Category'),
      ExportColumn::make('division')
        ->label('Division'),
      ExportColumn::make('zone')
        ->label('Zone'),
      ExportColumn::make('district')
        ->label('District'),
      ExportColumn::make('province')
        ->label('Province'),
      ExportColumn::make('address')
        ->label('Address'),
      ExportColumn::make('phone')
        ->label('Phone'),
      ExportColumn::make('email')
        ->label('Email'),
      ExportColumn::make('website')
        ->label('Website'),
      ExportColumn::make('established_year')
        ->label('Established Year'),
      ExportColumn::make('geo_lat')
        ->label('Latitude'),
      ExportColumn::make('geo_lng')
        ->label('Longitude'),
      ExportColumn::make('school_map_url')
        ->label('Map URL'),
      ExportColumn::make('created_at')
        ->label('Created At'),
      ExportColumn::make('updated_at')
        ->label('Updated At'),
    ];
  }

  public static function getCompletedNotificationBody(Export $export): string
  {
    $body = 'Your school export has completed and ' . number_format($export->successful_rows) . ' ' . str('row')->plural($export->successful_rows) . ' exported.';

    if ($failedRowsCount = $export->getFailedRowsCount()) {
      $body .= ' ' . number_format($failedRowsCount) . ' ' . str('row')->plural($failedRowsCount) . ' failed to export.';
    }

    return $body;
  }
}
