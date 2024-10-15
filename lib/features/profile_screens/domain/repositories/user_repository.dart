import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_hire/features/profile_screens/data/repositories/user_repository_impl.dart';

class UserRepositoryImpl implements UserRepository {
  final http.Client client;

  UserRepositoryImpl(this.client);

  @override
  Future<String> fetchUsername(String id) async {
    final response = await client.get(Uri.parse('https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/users/user/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['username'];
    } else {
      throw Exception('Failed to load username');
    }
  }
}