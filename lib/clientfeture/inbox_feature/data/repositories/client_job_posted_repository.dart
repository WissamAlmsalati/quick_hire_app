import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/client_job_posted_model.dart';

class ClientJobPostedRepository {
  final http.Client client;
  final FlutterSecureStorage storage;

  ClientJobPostedRepository({required this.client, required this.storage});

  Future<List<ClientJobPosted>> fetchJobs() async {
    final clientId = await storage.read(key: 'id');
    final response = await client.get(
      Uri.parse('https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/jobs/client/$clientId/jobs'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jobList = json.decode(response.body);
      return jobList.map((json) => ClientJobPosted.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}