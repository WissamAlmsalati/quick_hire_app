// lib/freelancefeatures/profile_screens/data/repositories/user_repository_impl.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../presentation/domain/repositories/user_repository.dart';
import 'package:quick_hire/freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final http.Client client;
  final AuthLocalDataSource localDataSource;

  UserRepositoryImpl(this.client, this.localDataSource);

  @override
  Future<Map<String, dynamic>> fetchUserProfile(String id) async {
    print('Fetching user profile data');
    final response = await client.get(Uri.parse('https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/users/user/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  @override
  Future<String> fetchUsername(String id) async {
    final response = await client.get(Uri.parse('https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/users/user/:?id'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['username'];
    } else {
      throw Exception('Failed to load username');
    }
  }

  Future<Map<String, dynamic>> fetchCachedUserProfile() async {
    final id = await localDataSource.getId(); // Retrieve the cached user ID
    if (id != null) {
      return fetchUserProfile(id);
    } else {
      throw Exception('No cached user ID found');
    }
  }
}