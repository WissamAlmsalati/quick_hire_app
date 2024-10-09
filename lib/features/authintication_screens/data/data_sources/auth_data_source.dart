import 'dart:convert';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthDataSource {
  Future<User> login(String email, String password);
  Future<User> signUp(String email, String password, String username, String userType);
}



class AuthDataSourceImpl implements AuthDataSource {
  final String apiUrl = 'https://yourapi.com';

  @override
  Future<User> login(String email, String password) async {
    // Implement API call or local storage logic
    throw UnimplementedError('login method not implemented');
  }

  @override
  Future<User> signUp(String email, String password, String username, String userType) async {
    final response = await http.post(
      Uri.parse('$apiUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'username': username,
        'userType': userType,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to sign up');
    }
  }
}