<?php

namespace App\Filament\Resources\Schools\Tables;

use App\Filament\Exports\SchoolExporter;
use App\Filament\Imports\SchoolImporter;
use App\Models\School;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteAction;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ExportAction;
use Filament\Actions\ExportBulkAction;
use Filament\Actions\ForceDeleteBulkAction;
use Filament\Actions\ImportAction;
use Filament\Actions\RestoreBulkAction;
use Filament\Actions\ViewAction;
use Filament\Infolists;
use Filament\Schemas;
use App\Filament\Resources\Schools\Schemas\SchoolInfolist;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Filters\TernaryFilter;
use Filament\Tables\Filters\TrashedFilter;
use Filament\Tables\Table;

class SchoolsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('school_no')->searchable(),
                TextColumn::make('school_census_no')->searchable(),
                TextColumn::make('school_name_en')->searchable(),
                TextColumn::make('school_type')->badge(),
                TextColumn::make('school_category')->badge(),
                TextColumn::make('division')->searchable(),
                TextColumn::make('zone')->searchable(),
                TextColumn::make('district')->searchable(),
                TextColumn::make('province')->searchable()->sortable(),
                TextColumn::make('phone')->searchable(),
                TextColumn::make('email')->label('Email address')->searchable(),
                TextColumn::make('website')->searchable(),
                TextColumn::make('established_year'),
                TextColumn::make('geo_lat')->numeric()->sortable(),
                TextColumn::make('geo_lng')->numeric()->sortable(),
                TextColumn::make('created_at')->dateTime()->sortable()->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('updated_at')->dateTime()->sortable()->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('deleted_at')->dateTime()->sortable()->toggleable(isToggledHiddenByDefault: true),
            ])
            ->defaultSort('school_name_en')
            ->filters([
                SelectFilter::make('school_type')
                    ->options([
                        '1AB' => '1AB',
                        '1C' => '1C',
                        'type2' => 'Type 2',
                        'type3' => 'Type 3',
                    ]),
                SelectFilter::make('school_category')
                    ->options([
                        'national' => 'National',
                        'province' => 'Province',
                        'private' => 'Private',
                        'semigovernment' => 'Semi-Government',
                    ]),
                SelectFilter::make('province')
                    ->options(fn() => School::query()
                        ->whereNotNull('province')
                        ->where('province', '!=', '')
                        ->orderBy('province')
                        ->pluck('province', 'province')
                        ->toArray())
                    ->searchable(),
                TernaryFilter::make('email')->label('Has Email')->nullable(),
                TernaryFilter::make('website')->label('Has Website')->nullable(),
                TrashedFilter::make(),
            ])
            ->recordActions([
                ViewAction::make()
                    ->modalWidth('7xl')
                    ->schema([
                        SchoolInfolist::section(),
                    ]),
                EditAction::make(),
                DeleteAction::make(),
            ])
            ->toolbarActions([
                ImportAction::make()->importer(SchoolImporter::class),
                ExportAction::make()->exporter(SchoolExporter::class),
            ])
            ->pushToolbarActions([
                BulkActionGroup::make([
                    ExportBulkAction::make()->exporter(SchoolExporter::class),
                    DeleteBulkAction::make(),
                    ForceDeleteBulkAction::make(),
                    RestoreBulkAction::make(),
                ]),
            ]);
    }

    // Details section extracted to Schemas\SchoolInfolist::section()
}
