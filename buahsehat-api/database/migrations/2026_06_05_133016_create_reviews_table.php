<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
public function up(): void
{
    Schema::table('reviews', function (Blueprint $table) {

        $table->foreignId('user_id')
            ->after('id')
            ->constrained()
            ->cascadeOnDelete();

        $table->foreignId('product_id')
            ->after('user_id')
            ->constrained()
            ->cascadeOnDelete();

        $table->integer('rating')
            ->after('product_id');

        $table->text('comment')
            ->after('rating');
    });
}

public function down(): void
{
    Schema::table('reviews', function (Blueprint $table) {

        $table->dropForeign(['user_id']);
        $table->dropForeign(['product_id']);

        $table->dropColumn([
            'user_id',
            'product_id',
            'rating',
            'comment',
        ]);
    });
}
};
