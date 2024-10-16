// lib/freelancefeatures/profile_screens/data/repositories/user_repository_impl.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../presentation/domain/repositories/user_repository.dart';
import 'package:quick_hire/freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import 'package:quick_hire/freelancefeatures/authintication_screens/data/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final http.Client client;
  final AuthLocalDataSource localDataSource;

  UserRepositoryImpl(this.client, this.localDataSource);

  @override
  Future<User> fetchUserProfile() async {
    print('Fetching user profile data');
    final id = await localDataSource.getId(); // Retrieve the user ID
    final token = await localDataSource.getToken(); // Retrieve the token
    final response = await client.get(
      Uri.parse('https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/users/user/$id'),
      headers: {
        'Authorization': 'Bearer $token', // Add the token to the headers
      },
    );
    print("profile response code: ${response.statusCode}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data); // Convert the map to a User object
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  @override
  Future<String> fetchUsername(String id) {
    // TODO: implement fetchUsername
    throw UnimplementedError();
  }
}