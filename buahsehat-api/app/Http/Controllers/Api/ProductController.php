<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;

class ProductController extends Controller
{
  public function index()
{
    return Product::with('category')
        ->get()
        ->map(function ($product) {
            return [
                'id' => $product->id,
                'category_id' => $product->category_id,
                'name' => $product->name,
                'description' => $product->description,
                'price' => $product->price,
                'stock' => $product->stock,

                'image' => $product->image
                    ? asset('storage/' . $product->image)
                    : null,

                'category' => $product->category,
            ];
        });
}
}
