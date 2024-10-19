// lib/repositories/application_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/freelance_application_model.dart';

class ApplicationRepository {
  final String baseUrl;

  ApplicationRepository({required this.baseUrl});

  Future<ApplicationsResponse> fetchApplications(String jobId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/jobs/$jobId/applications'));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return ApplicationsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load applications');
    }
  }
}