<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
  public function up(): void
  {
    Schema::create('schools', function (Blueprint $table) {
      $table->bigIncrements('id');
      $table->string('school_no', 50)->unique();
      $table->string('school_census_no', 50)->unique()->nullable();
      $table->text('school_name_en');
      $table->text('school_name_ta')->nullable();
      $table->text('school_name_si')->nullable();
      $table->enum('school_type', ['1AB', '1C', 'type2', 'type3']);
      $table->enum('school_category', ['national', 'province', 'private', 'semigovernment']);
      $table->string('division', 100)->nullable();
      $table->string('zone', 100)->nullable();
      $table->string('district', 100)->nullable();
      $table->string('province', 100)->nullable();
      $table->text('address')->nullable();
      $table->string('phone', 20)->nullable();
      $table->string('email', 255)->nullable();
      $table->string('website', 255)->nullable();
      $table->year('established_year')->nullable();
      $table->decimal('geo_lat', 10, 8)->nullable();
      $table->decimal('geo_lng', 11, 8)->nullable();
      $table->text('school_map_url')->nullable();
      $table->unsignedBigInteger('created_by')->nullable();
      $table->unsignedBigInteger('updated_by')->nullable();
      $table->unsignedBigInteger('deleted_by')->nullable();
      $table->timestamps();
      $table->softDeletes();

      $table->index('school_no');
      $table->index('school_census_no');
      $table->index('school_type');
      $table->index('school_category');

      $table->foreign('created_by')->references('id')->on('users')->nullOnDelete();
      $table->foreign('updated_by')->references('id')->on('users')->nullOnDelete();
      $table->foreign('deleted_by')->references('id')->on('users')->nullOnDelete();
    });
  }

  public function down(): void
  {
    Schema::dropIfExists('schools');
  }
};
