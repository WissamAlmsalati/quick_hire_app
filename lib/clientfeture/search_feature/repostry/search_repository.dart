// lib/search/repository/search_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../freelancefeatures/HomeScreen/domain/entities/job.dart';

class SearchRepository {
  final String apiUrl;

  SearchRepository(this.apiUrl);

  Future<List<Job>> searchJobs(String query) async {
    final response = await http.get(Uri.parse('$apiUrl/api/jobs/search/$query'));
print(response.body
);
print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Job.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }
}