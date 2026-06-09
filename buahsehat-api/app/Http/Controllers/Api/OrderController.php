<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;

class OrderController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $rules = [
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|integer|exists:products,id',
            'items.*.quantity' => 'required|integer|min:1',

            'shipping_name' => 'required|string',
            'shipping_email' => 'required|email',
            'shipping_phone' => 'required|string',
            'shipping_zip' => 'nullable|string',
            'shipping_city' => 'nullable|string',
            'shipping_country' => 'nullable|string',

            'payment_method' => 'nullable|string',
            'payment_details' => 'nullable|string',
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $user = $request->user();
        $items = $request->input('items', []);

        // calculate total by reading product prices from DB
        $total = 0;
        foreach ($items as $entry) {
            $qty = intval($entry['quantity'] ?? 0);
            $pid = intval($entry['product_id'] ?? 0);
            $product = Product::find($pid);
            $price = $product ? floatval($product->price) : 0;
            $total += $price * $qty;
        }

        try {
            $order = DB::transaction(function () use ($user, $items, $total, $request) {
                $order = Order::create([
                    'user_id' => $user->id,
                    'total_price' => $total,
                    'status' => 'pending',
                    'shipping_name' => $request->input('shipping_name'),
                    'shipping_email' => $request->input('shipping_email'),
                    'shipping_phone' => $request->input('shipping_phone'),
                    'shipping_zip' => $request->input('shipping_zip'),
                    'shipping_city' => $request->input('shipping_city'),
                    'shipping_country' => $request->input('shipping_country'),
                    'payment_method' => $request->input('payment_method'),
                    'payment_details' => $request->input('payment_details'),
                ]);

                foreach ($items as $entry) {
                    $pid = intval($entry['product_id'] ?? 0);
                    $qty = intval($entry['quantity'] ?? 0);

                    // resolve product by id and lock
                    $product = Product::where('id', $pid)->lockForUpdate()->first();

                    if (!$product) {
                        throw new \Exception('Produk tidak ditemukan: ' . $pid);
                    }

                    if ($product->stock < $qty) {
                        throw new \Exception('Stok tidak mencukupi untuk produk: ' . $product->name);
                    }

                    // decrement stock
                    $product->stock = max(0, $product->stock - $qty);
                    $product->save();

                    // create order item with product price at time of order
                    OrderItem::create([
                        'order_id' => $order->id,
                        'product_id' => $product->id,
                        'quantity' => $qty,
                        'price' => $product->price,
                    ]);
                }

                return $order;
            });

            return response()->json(['message' => 'Order created', 'order_id' => $order->id], 201);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 422);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
