<?php

namespace App\Filament\Widgets;

use App\Models\Category;
use App\Models\Order;
use App\Models\Product;
use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StatsOverview extends StatsOverviewWidget
{
    protected function getStats(): array
    {
        return [
            Stat::make('Produk', Product::count())
                ->description('Total produk tersedia')
                ->color('success'),

            Stat::make('Kategori', Category::count())
                ->description('Total kategori')
                ->color('info'),

            Stat::make(
                'Stok Kritis',
                Product::where('stock', '<=', 10)->count()
            )
                ->description('Klik untuk melihat produk')
                ->color('danger')
                ->url('/admin/products?tableFilters[stok_kritis][isActive]=true'),

            Stat::make('Order', Order::count())
                ->description('Total pesanan')
                ->color('warning'),
        ];
    }
}
