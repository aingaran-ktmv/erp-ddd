<?php

namespace App\Filament\Resources\Schools;

use App\Filament\Resources\Schools\Schemas\SchoolForm as SchemaSchoolForm;
use Filament\Schemas\Schema;

class SchoolForm
{
    // Wrapper to keep resource API stable; real schema lives in Schemas\SchoolForm
    public static function form(Schema $schema): Schema
    {
        return SchemaSchoolForm::configure($schema);
    }
}
