<?php

namespace App\Filament\Resources\Schools;

use App\Filament\Resources\Schools\Schemas\SchoolInfolist as SchemaSchoolInfolist;
use Filament\Schemas\Components\Section as SchemaSection;

class SchoolInfolist
{
  // Wrapper to keep resource API stable; real layout lives in Schemas\SchoolInfolist
  public static function section(): SchemaSection
  {
    return SchemaSchoolInfolist::section();
  }
}
