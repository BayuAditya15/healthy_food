import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/product_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewPage extends StatefulWidget {
  final List<dynamic> purchasedItems;

  const ReviewPage({super.key, required this.purchasedItems});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<Map<String, dynamic>> _products = [];
  int _selectedIndex = 0;
  int _rating = 5;
  final _commentController = TextEditingController();
  bool _submitting = false;

  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final all = await ProductService.getProducts();

      final purchasedIds = widget.purchasedItems
          .map((e) => (e['product_id'] as num?)?.toInt() ?? 0)
          .toSet();

      final matched = all
          .where((p) => purchasedIds.contains(p.id))
          .map((p) => {'id': p.id, 'name': p.name})
          .toList();

      setState(() {
        _products = matched.cast<Map<String, dynamic>>().toList();
      });
    } catch (_) {
      // ignore
    }
  }

  Future<void> _submitReview() async {
    if (_products.isEmpty) return;

    setState(() => _submitting = true);

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final productId = _products[_selectedIndex]['id'];

    final payload = {
      'product_id': productId,
      'rating': _rating,
      'comment': _commentController.text,
    };

    try {
      final res = await http.post(
        Uri.parse('$_baseUrl/reviews'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload),
      );

      if (res.statusCode == 201) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Review submitted')));
        Navigator.of(context).pop();
      } else {
        final decoded = jsonDecode(res.body);
        final msg = decoded['message'] ?? decoded['error'] ?? 'Failed';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg.toString())));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Review')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select product',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (_products.isEmpty)
              const Text('No matching products found locally')
            else
              DropdownButton<int>(
                value: _selectedIndex,
                items: List.generate(
                  _products.length,
                  (i) => DropdownMenuItem(
                    value: i,
                    child: Text(_products[i]['name']),
                  ),
                ),
                onChanged: (v) => setState(() => _selectedIndex = v ?? 0),
              ),
            const SizedBox(height: 12),
            const Text('Rating', style: TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _rating.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: '$_rating',
              onChanged: (v) => setState(() => _rating = v.toInt()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Comment'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitting ? null : _submitReview,
                child: _submitting
                    ? const CircularProgressIndicator()
                    : const Text('Submit Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
