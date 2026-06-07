<?php

namespace App\Filament\Widgets;

use Filament\Widgets\ChartWidget;

class OrderChart extends ChartWidget
{
    protected ?string $heading = 'Order Chart';

    protected function getData(): array
    {
        return [
            //
        ];
    }

    protected function getType(): string
    {
        return 'line';
    }
}
