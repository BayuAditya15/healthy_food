import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductService {
  // Semua produk
  static Future<List<ProductModel>> getProducts() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/products'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => ProductModel.fromJson(e)).toList();
    }

    throw Exception('Gagal mengambil produk');
  }

  // Produk berdasarkan kategori
  static Future<List<ProductModel>> getProductsByCategory(
    int categoryId,
  ) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/categories/$categoryId/products'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => ProductModel.fromJson(e)).toList();
    }

    throw Exception('Gagal mengambil produk kategori');
  }
}
