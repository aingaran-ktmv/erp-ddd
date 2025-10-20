<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
  public function up(): void
  {
    $driver = DB::getDriverName();

    if (in_array($driver, ['mysql', 'mariadb'])) {
      // Convert ENUMs to VARCHAR and YEAR to SMALLINT UNSIGNED
      DB::statement("ALTER TABLE schools MODIFY school_type VARCHAR(25) NOT NULL");
      DB::statement("ALTER TABLE schools MODIFY school_category VARCHAR(25) NOT NULL");
      DB::statement("ALTER TABLE schools MODIFY established_year SMALLINT UNSIGNED NULL");
      return;
    }

    if ($driver === 'pgsql') {
      // Convert ENUM-like to VARCHAR using explicit cast and YEAR-like to SMALLINT
      DB::statement("ALTER TABLE schools ALTER COLUMN school_type TYPE VARCHAR(25) USING school_type::text");
      DB::statement("ALTER TABLE schools ALTER COLUMN school_category TYPE VARCHAR(25) USING school_category::text");
      DB::statement("ALTER TABLE schools ALTER COLUMN established_year TYPE SMALLINT");
      return;
    }

    if ($driver === 'sqlite') {
      // SQLite has limited ALTER TABLE support. Skip to keep dev env working.
      // If you need this on SQLite, we can rebuild the table in a follow-up migration.
      info('Skipping enum/year conversion on SQLite. No-op.');
      return;
    }

    throw new RuntimeException("Unsupported database driver '{$driver}' for altering enum/year columns.");
  }

  public function down(): void
  {
    $driver = DB::getDriverName();

    if (in_array($driver, ['mysql', 'mariadb'])) {
      // Revert VARCHAR back to ENUM and SMALLINT back to YEAR
      DB::statement("ALTER TABLE schools MODIFY school_type ENUM('1AB','1C','type2','type3') NOT NULL");
      DB::statement("ALTER TABLE schools MODIFY school_category ENUM('national','province','private','semigovernment') NOT NULL");
      DB::statement("ALTER TABLE schools MODIFY established_year YEAR NULL");
      return;
    }

    if ($driver === 'pgsql') {
      // Best-effort rollback: convert VARCHAR back to TEXT (closest) and SMALLINT back to INTEGER
      DB::statement("ALTER TABLE schools ALTER COLUMN school_type TYPE TEXT");
      DB::statement("ALTER TABLE schools ALTER COLUMN school_category TYPE TEXT");
      DB::statement("ALTER TABLE schools ALTER COLUMN established_year TYPE INTEGER");
      return;
    }

    if ($driver === 'sqlite') {
      info('Skipping rollback of enum/year conversion on SQLite. No-op.');
      return;
    }

    throw new RuntimeException("Unsupported database driver '{$driver}' for rollback of enum/year columns.");
  }
};
