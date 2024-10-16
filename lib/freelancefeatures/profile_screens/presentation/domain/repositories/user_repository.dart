// lib/freelancefeatures/profile_screens/domain/repositories/user_repository.dart
import 'package:quick_hire/freelancefeatures/authintication_screens/data/models/user_model.dart';

abstract class UserRepository {
  Future<User> fetchUserProfile();
  Future<String> fetchUsername(String id);
}