<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

use App\Models\OrderItem;

class Order extends Model
{
    protected $fillable = [
        'user_id',
        'total_price',
        'status',
        'shipping_name',
        'shipping_email',
        'shipping_phone',
        'shipping_zip',
        'shipping_city',
        'shipping_country',
        'payment_method',
        'payment_details',
    ];

    public function items(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }
}
