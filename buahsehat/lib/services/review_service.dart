import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/review_model.dart';

class ReviewService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static Future<List<ReviewModel>> getReviews(int productId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/$productId/reviews'),
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => ReviewModel.fromJson(e)).toList();
    }

    throw Exception(response.body);
  }
}
