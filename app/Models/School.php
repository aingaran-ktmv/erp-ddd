<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class School extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'school_no',
        'school_census_no',
        'school_name_en',
        'school_name_ta',
        'school_name_si',
        'school_type',
        'school_category',
        'division',
        'zone',
        'district',
        'province',
        'address',
        'phone',
        'email',
        'website',
        'established_year',
        'geo_lat',
        'geo_lng',
        'school_map_url',
        'created_by',
        'updated_by',
        'deleted_by',
    ];

    protected $casts = [
        'established_year' => 'integer',
        'geo_lat' => 'decimal:8',
        'geo_lng' => 'decimal:8',
        'school_type' => 'string',
        'school_category' => 'string',
    ];

    public function visions()
    {
        // return $this->hasMany(SchoolVision::class, 'school_id'); // Uncomment when SchoolVision model exists
    }

    public function createdBy()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function updatedBy()
    {
        return $this->belongsTo(User::class, 'updated_by');
    }

    public function deletedBy()
    {
        return $this->belongsTo(User::class, 'deleted_by');
    }
}
