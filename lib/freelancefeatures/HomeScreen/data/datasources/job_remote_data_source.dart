// lib/features/HomeScreen/data/datasources/job_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job_model.dart';

abstract class JobRemoteDataSource {
  Future<List<JobModel>> getAllJobs();

  Future<void> applyJob(String jobId, String freelancerId);
}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final http.Client client;

  JobRemoteDataSourceImpl({required this.client});

  @override
  Future<List<JobModel>> getAllJobs() async {
    final response = await client.get(Uri.parse(
        'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/jobs/all'));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Success');
      print(response.body); // Add logging to verify the response
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => JobModel.fromJson(job)).toList();
    } else {
      print(response.body);
      print("Failed to load jobs");
      throw Exception('Failed to load jobs');
    }
  }

  @override
  Future<void> applyJob(String jobId, String freelancerId) async {
    final response = await client.post(
      Uri.parse(
          'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/jobs/apply'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'jobId': jobId, 'freelancerId': freelancerId}),
    );
    print(jobId);
    print(freelancerId);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode != 200) {
      print("Failed to apply for a job");
      throw Exception('Failed to apply for a job');
    }
  }
}
