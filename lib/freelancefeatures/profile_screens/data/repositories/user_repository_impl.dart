import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../presentation/domain/repositories/user_repository.dart';
import 'package:quick_hire/freelancefeatures/authintication_screens/data/datasources/local/auth_local_data_source.dart';
import 'package:quick_hire/freelancefeatures/authintication_screens/data/models/freelancer_model.dart';

class UserRepositoryImpl implements UserRepository {
  final http.Client client;
  final AuthLocalDataSource localDataSource;

  UserRepositoryImpl(this.client, this.localDataSource);

  @override
  Future<Freelancer> fetchUserProfile() async {
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
    print("profile response body: ${response.body}");
    print("profile response headers: ${response.headers}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Freelancer.fromJson(data); // Convert the map to a Freelancer object
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  @override
  Future<String> fetchUsername(String id) {
    // TODO: implement fetchUsername
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserProfile(Freelancer freelancer) async {
    final id = await localDataSource.getId();
    final token = await localDataSource.getToken();
    final response = await client.put(
      Uri.parse('https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/users/user/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(freelancer.toJson()),
    );
    print("update response code: ${response.statusCode}");
    if (response.statusCode != 200) {
      throw Exception('Failed to update profile data');
    }
  }

  Future<void> patchUserProfile(Map<String, dynamic> updates) async {
    final id = await localDataSource.getId();
    final token = await localDataSource.getToken();
    final response = await client.patch(
      Uri.parse('https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/users/update-user/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(updates),
    );

    print("patch response code: ${response.statusCode}");
    print("patch response body: ${response.body}");
    print("patch response headers: ${response.headers}");

    if (response.statusCode != 200) {
      throw Exception('Failed to patch profile data');
    }
  }
}