// lib/freelancefeatures/profile_screens/domain/repositories/user_repository.dart
abstract class UserRepository {
  Future<Map<String, dynamic>> fetchUserProfile(String id);
  Future<String> fetchUsername(String id);
}