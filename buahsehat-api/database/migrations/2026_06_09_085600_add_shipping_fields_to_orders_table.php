<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('orders', function (Blueprint $table) {

            $table->string('shipping_name')->nullable();
            $table->string('shipping_email')->nullable();
            $table->string('shipping_phone')->nullable();

            $table->string('shipping_zip')->nullable();
            $table->string('shipping_city')->nullable();
            $table->string('shipping_country')->nullable();

            $table->string('payment_method')->nullable();
        });
    }

    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {

            $table->dropColumn([
                'shipping_name',
                'shipping_email',
                'shipping_phone',
                'shipping_zip',
                'shipping_city',
                'shipping_country',
                'payment_method',
            ]);
        });
    }
};
