import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/wishlist_item_model.dart';

class WishlistService {
  static const String _storageKey = 'wishlist_items';

  static final ValueNotifier<List<WishlistItemModel>> items =
      ValueNotifier<List<WishlistItemModel>>(<WishlistItemModel>[]);

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
                  WishlistItemModel.fromJson(Map<String, dynamic>.from(entry)),
            )
            .toList();
      }
    } catch (_) {
      items.value = <WishlistItemModel>[];
    }

    _isLoaded = true;
  }

  static Future<bool> isInWishlist(String name, String image) async {
    await ensureLoaded();
    return items.value.any((item) => item.name == name && item.image == image);
  }

  static Future<bool> isInWishlistById(int productId) async {
    await ensureLoaded();
    return items.value.any((item) => item.productId == productId);
  }

  static Future<void> toggleItem(WishlistItemModel item) async {
    await ensureLoaded();

    final currentItems = List<WishlistItemModel>.from(items.value);
    final existingIndex = currentItems.indexWhere(
      (value) => value.productId == item.productId,
    );

    if (existingIndex >= 0) {
      currentItems.removeAt(existingIndex);
    } else {
      currentItems.add(item);
    }

    items.value = currentItems;
    await _persist();
  }

  static Future<void> removeAt(int index) async {
    await ensureLoaded();

    if (index < 0 || index >= items.value.length) return;

    final currentItems = List<WishlistItemModel>.from(items.value)
      ..removeAt(index);
    items.value = currentItems;
    await _persist();
  }

  static Future<void> clear() async {
    await ensureLoaded();
    items.value = <WishlistItemModel>[];
    await _persist();
  }

  static Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      items.value.map((item) => item.toJson()).toList(),
    );
    await prefs.setString(_storageKey, encoded);
  }
}
