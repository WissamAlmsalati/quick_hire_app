import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job_model.dart';

abstract class JobRemoteDataSource {
  Future<List<JobModel>> getAllJobs();
}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final http.Client client;

  JobRemoteDataSourceImpl({required this.client});

  @override
  Future<List<JobModel>> getAllJobs() async {
    final response = await client.get(Uri.parse('https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/jobs/all'));

    if (response.statusCode == 200) {
      print(response.body); // Add logging to verify the response
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => JobModel.fromJson(job)).toList();
    } else {
      print("Failed to load jobs");
      throw Exception('Failed to load jobs');
    }
  }
}