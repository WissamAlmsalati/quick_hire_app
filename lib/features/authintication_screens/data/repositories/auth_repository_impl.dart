import 'auth_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import '../datasources/local/auth_local_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final String registerUrl = 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/auth/register';
  final String loginUrl = 'https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/auth/login';

  final AuthLocalDataSource authLocalDataSource = AuthLocalDataSource(FlutterSecureStorage());

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
      final user = User.fromJson(jsonDecode(response.body));
      await authLocalDataSource.cacheToken(user.token); // Save the token
      await authLocalDataSource.cacheId(user.id); // Save the id
      return user;
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
      final user = User.fromJson(jsonDecode(response.body));
      await authLocalDataSource.cacheToken(user.token); // Save the token
      await authLocalDataSource.cacheId(user.id); // Save the id

      return user;
    } else {
      print('Registration failed: ${response.body}');
      throw Exception('Failed to sign up');
    }
  }
}