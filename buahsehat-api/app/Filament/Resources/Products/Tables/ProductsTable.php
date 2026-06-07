<?php

namespace App\Filament\Resources\Products\Tables;

use Filament\Actions\Action;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\TextInput;
use Filament\Tables\Columns\ImageColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\Filter;
use Filament\Tables\Table;

class ProductsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('category.name')
                    ->label('Kategori')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('name')
                    ->searchable(),

                TextColumn::make('price')
                    ->money('IDR')
                    ->sortable(),

                TextColumn::make('stock')
                    ->badge()
                    ->color(fn ($state) => $state <= 10 ? 'danger' : 'success')
                    ->sortable(),

                ImageColumn::make('image'),

                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),

                TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])

            ->filters([
                Filter::make('stok_kritis')
                    ->label('Stok Kritis')
                    ->query(fn ($query) => $query->where('stock', '<=', 10)),
            ])

            ->recordActions([
                EditAction::make(),

                Action::make('tambahStok')
                    ->label('Stok')
                    ->icon('heroicon-o-plus')
                    ->form([
                        TextInput::make('jumlah')
                            ->label('Jumlah Stok')
                            ->numeric()
                            ->required(),
                    ])
                    ->action(function ($record, array $data) {
                        $record->increment('stock', $data['jumlah']);
                    }),
            ])

            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}
