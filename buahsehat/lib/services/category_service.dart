import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';

class CategoryService {
  static Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/categories'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => CategoryModel.fromJson(e)).toList();
    }

    throw Exception('Gagal mengambil kategori');
  }
}
