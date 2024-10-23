import 'package:http/http.dart' as http;
import 'dart:convert';

class AppliedJobsRepository {
  final String baseUrl;

  AppliedJobsRepository({required this.baseUrl});

  Future<List<dynamic>> fetchAppliedJobs(String freelancerId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/jobs/freelancer/$freelancerId/applied-jobs'));

    print(freelancerId);
    print(response.statusCode);
    print(response.body); // Debugging: Print the response body

    if (response.statusCode == 200) {
      try {
        final decodedResponse = json.decode(response.body);

        // If the response is a list directly
        if (decodedResponse is List) {
          return decodedResponse; // Return the list of jobs directly
        }

        // If the response is a map with 'appliedJobs' key
        if (decodedResponse is Map<String, dynamic> && decodedResponse.containsKey('appliedJobs')) {
          return decodedResponse['appliedJobs'] ?? [];
        }

        throw Exception('Unexpected response structure');
      } catch (e) {
        print('Error parsing the response: $e');
        throw Exception('Failed to parse applied jobs');
      }
    } else {
      print('Failed to load applied jobs: ${response.statusCode} ${response.body}');
      throw Exception('Failed to load applied jobs');
    }
  }
}
