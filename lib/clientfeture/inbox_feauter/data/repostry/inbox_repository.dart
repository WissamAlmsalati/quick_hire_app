// lib/clientfeture/inbox_feature/data/repositories/inbox_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/application_model.dart';

class InboxRepository {
  final String baseUrl = 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api';

  Future<List<ApplicationModel>> fetchApplications(String jobId) async {
    final response = await http.get(Uri.parse('$baseUrl/jobs/$jobId/applications'));
    print(response.body);
    print(response.statusCode);
    print("fetchApplications");
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['applications'];
      return jsonList.map((json) => ApplicationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load applications');
    }
  }

  Future<void> acceptApplication(String jobId, String freelancerId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/jobs/accept'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'jobId': jobId, 'freelancerId': freelancerId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to accept application');
    }
  }
}