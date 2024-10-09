
// lib/features/authintication_screens/data/repositories/auth_repository_impl.dart
import 'auth_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final String registerUrl = 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/auth/register';
  final String loginUrl = 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/auth/login';

  @override
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<User> signUp(String email, String password, String username, String userType) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
        'userType': userType,
      }),
    );

    if (response.statusCode == 201) {
      print('Registration successful: ${response.body}');
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('Registration failed: ${response.body}');
      throw Exception('Failed to sign up');
    }
  }
}