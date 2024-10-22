import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileRepository {
  final String baseUrl;

  ProfileRepository({required this.baseUrl});

  Future<Map<String, dynamic>> fetchProfileById(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/users/user/$userId'));
print(userId);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to load profile: ${response.statusCode} ${response.body}');
      throw Exception('Failed to load profile');
    }
  }
}