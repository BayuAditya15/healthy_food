<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Models\Product;

class CategoryController extends Controller
{
    public function index()
    {
        return response()->json(
            Category::all()
        );
    }
    public function byCategory($id)
{
    return Product::where('category_id', $id)
        ->with('category')
        ->get()
        ->map(function ($product) {
            $product->image = $product->image
                ? asset('storage/' . $product->image)
                : null;

            return $product;
        });
}
}
