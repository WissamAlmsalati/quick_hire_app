import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_hire/clientfeture/jobsFeature/postedJobs/data/models/category_post_job.dart';

class CategoryPostJobRepository {
  final String baseUrl;

  CategoryPostJobRepository({required this.baseUrl});

  Future<List<CategoryPostJob>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/api/categories'));
print(response.statusCode);
print(baseUrl);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((categoryData) => CategoryPostJob.fromJson(categoryData)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}