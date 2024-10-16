import 'package:http/http.dart' as http;
import 'package:quick_hire/clientfeture/job_posting/data/models/job_post_model.dart';
import 'dart:convert';
import 'job_repository.dart';

class PostJobRepositoryImpl implements PostJobRepository {
  final http.Client client;

  PostJobRepositoryImpl(this.client);

  @override
  Future<void> postJob(PostJobModel postJobModel) async {
    final response = await client.post(
      Uri.parse('https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/jobs/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(postJobModel.toJson()),
    );
print(response.body);
print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to post job');
    }
  }
}