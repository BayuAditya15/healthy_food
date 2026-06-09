import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item_model.dart';

class CartService {
  static const String _storageKey = 'cart_items';

  static final ValueNotifier<List<CartItemModel>> items =
      ValueNotifier<List<CartItemModel>>(<CartItemModel>[]);

  static bool _isLoaded = false;

  static Future<void> ensureLoaded() async {
    if (_isLoaded) return;

    final prefs = await SharedPreferences.getInstance();
    final rawItems = prefs.getString(_storageKey);

    if (rawItems == null || rawItems.isEmpty) {
      _isLoaded = true;
      return;
    }

    try {
      final decoded = jsonDecode(rawItems);
      if (decoded is List) {
        items.value = decoded
            .whereType<Map>()
            .map(
              (entry) =>
                  CartItemModel.fromJson(Map<String, dynamic>.from(entry)),
            )
            .toList();
      }
    } catch (_) {
      items.value = <CartItemModel>[];
    }

    _isLoaded = true;
  }

  static Future<void> addItem(CartItemModel item) async {
    await ensureLoaded();

    final currentItems = List<CartItemModel>.from(items.value);
    final existingIndex = currentItems.indexWhere(
      (value) => value.productId == item.productId,
    );

    if (existingIndex >= 0) {
      final existingItem = currentItems[existingIndex];
      currentItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + item.quantity,
      );
    } else {
      currentItems.add(item);
    }

    items.value = currentItems;
    await _persist();
  }

  static Future<void> updateQuantity(int index, int quantity) async {
    await ensureLoaded();

    if (index < 0 || index >= items.value.length || quantity < 1) return;

    final currentItems = List<CartItemModel>.from(items.value);
    currentItems[index] = currentItems[index].copyWith(quantity: quantity);
    items.value = currentItems;
    await _persist();
  }

  static Future<void> removeAt(int index) async {
    await ensureLoaded();

    if (index < 0 || index >= items.value.length) return;

    final currentItems = List<CartItemModel>.from(items.value)..removeAt(index);
    items.value = currentItems;
    await _persist();
  }

  static Future<void> clear() async {
    await ensureLoaded();
    items.value = <CartItemModel>[];
    await _persist();
  }

  static double get totalPrice {
    return items.value.fold<double>(0, (sum, item) => sum + item.totalPrice);
  }

  static int get totalQuantity {
    return items.value.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  static Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      items.value.map((item) => item.toJson()).toList(),
    );
    await prefs.setString(_storageKey, encoded);
  }
}
