// category_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';

class CategoryRepository {
  final String baseUrl = 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}api/categories'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}