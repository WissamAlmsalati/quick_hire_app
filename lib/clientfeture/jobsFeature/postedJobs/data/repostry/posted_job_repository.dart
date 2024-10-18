import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/posted_job.dart';

class PostedJobRepository {
  final String baseUrl;

  PostedJobRepository({required this.baseUrl});

  Future<List<PostedJob>> fetchPostedJobs(String clientId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/clients/client/$clientId/jobs'));
print(clientId);
print(response.statusCode);
print(baseUrl);
print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((jobData) => PostedJob.fromJson(jobData)).toList();
    } else {
      throw Exception('Failed to load posted jobs');
    }
  }
}