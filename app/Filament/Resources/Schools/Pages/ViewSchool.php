<?php

namespace App\Filament\Resources\Schools\Pages;

use App\Filament\Resources\Schools\Schemas\SchoolInfolist;
use App\Filament\Resources\Schools\SchoolResource;
use Filament\Resources\Pages\ViewRecord;
use Filament\Schemas\Schema;

class ViewSchool extends ViewRecord
{
  protected static string $resource = SchoolResource::class;

  public function infolist(Schema $schema): Schema
  {
    return $schema->schema([
      SchoolInfolist::section(),
    ]);
  }
}
