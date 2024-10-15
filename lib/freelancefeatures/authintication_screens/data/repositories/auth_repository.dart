import '../models/user_model.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> signUp(String email, String password, String username, String userType);
}