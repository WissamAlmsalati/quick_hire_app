import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../authintication_screens/data/models/freelancer_model.dart';

class FreelancerRepository {
  final String baseUrl;

  FreelancerRepository({required this.baseUrl});

  Future<List<Freelancer>> fetchFreelancers() async {
    final response = await http.get(Uri.parse('$baseUrl/api/freelancers'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Freelancer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load freelancers: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}