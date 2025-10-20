<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\School;

class SchoolSeeder extends Seeder
{
  public function run(): void
  {
    School::create([
      'school_no' => 'SCH001',
      'school_census_no' => 'CEN001',
      'school_name_en' => 'Central College',
      'school_name_ta' => 'மத்திய கல்லூரி',
      'school_name_si' => 'මධ්‍ය විද්‍යාලය',
      'school_type' => '1AB',
      'school_category' => 'national',
      'division' => 'Central Division',
      'zone' => 'Central Zone',
      'district' => 'Colombo',
      'province' => 'Western',
      'address' => '123 Main St, Colombo',
      'phone' => '0111234567',
      'email' => 'info@centralcollege.lk',
      'website' => 'https://centralcollege.lk',
      'established_year' => 1950,
      'geo_lat' => 6.927079,
      'geo_lng' => 79.861244,
      'school_map_url' => 'https://maps.example.com/centralcollege',
      'created_by' => null,
      'updated_by' => null,
      'deleted_by' => null,
    ]);

    School::create([
      'school_no' => 'SCH002',
      'school_census_no' => 'CEN002',
      'school_name_en' => 'Western High School',
      'school_name_ta' => null,
      'school_name_si' => null,
      'school_type' => '1C',
      'school_category' => 'province',
      'division' => 'Western Division',
      'zone' => 'Western Zone',
      'district' => 'Gampaha',
      'province' => 'Western',
      'address' => '456 High St, Gampaha',
      'phone' => '0331234567',
      'email' => 'contact@westernhigh.lk',
      'website' => 'https://westernhigh.lk',
      'established_year' => 1975,
      'geo_lat' => 7.0928,
      'geo_lng' => 80.0144,
      'school_map_url' => 'https://maps.example.com/westernhigh',
      'created_by' => null,
      'updated_by' => null,
      'deleted_by' => null,
    ]);
  }
}
