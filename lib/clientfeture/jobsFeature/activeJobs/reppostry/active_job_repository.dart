import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_hire/clientfeture/jobsFeature/activeJobs/data/active_job_model.dart';

class ActiveJobRepository {
  final String baseUrl;

  ActiveJobRepository({required this.baseUrl});

  Future<List<ActiveJob>> fetchActiveJobs(String clientId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/clients/client/$clientId/active-projects'));
print(clientId);
    if (response.statusCode == 200) {
      print("active jobs  found in  " + response.body);
      final List<dynamic> data = json.decode(response.body);
      return data.map((jobData) => ActiveJob.fromJson(jobData['job'])).toList();
    } else {
      throw Exception('Failed to load active jobs');
    }
  }
}