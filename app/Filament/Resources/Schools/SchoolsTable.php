<?php

namespace App\Filament\Resources\Schools;

use App\Filament\Resources\Schools\Tables\SchoolsTable as TablesSchoolsTable;
use Filament\Tables\Table;

class SchoolsTable
{
    // Wrapper: delegate to the Tables\SchoolsTable which already uses Filament 4 APIs.
    public static function table(Table $table): Table
    {
        return TablesSchoolsTable::configure($table);
    }
}
