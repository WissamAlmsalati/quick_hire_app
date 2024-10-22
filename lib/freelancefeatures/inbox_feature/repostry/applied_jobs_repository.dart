import 'package:http/http.dart' as http;
import 'dart:convert';

class AppliedJobsRepository {
  final String baseUrl;

  AppliedJobsRepository({required this.baseUrl});

  Future<List<dynamic>> fetchAppliedJobs(String freelancerId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/jobs/freelancer/$freelancerId/applied-jobs'));
    print(freelancerId);
    print(response.statusCode);
    print(response.body); // Print the entire response body for debugging

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody.containsKey('appliedJobs') && responseBody['appliedJobs'] != null) {
        final List<dynamic> jobs = responseBody['appliedJobs'];
        return jobs;
      } else {
        throw Exception('appliedJobs key is missing or null');
      }
    } else {
      print('Failed to load applied jobs: ${response.statusCode} ${response.body}');
      throw Exception('Failed to load applied jobs');
    }
  }
}