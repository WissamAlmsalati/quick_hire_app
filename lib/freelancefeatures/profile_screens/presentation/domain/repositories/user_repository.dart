// lib/freelancefeatures/profile_screens/domain/repositories/user_repository.dart
import 'package:quick_hire/freelancefeatures/authintication_screens/data/models/freelancer_model.dart';

abstract class UserRepository {
  Future<Freelancer> fetchUserProfile();
  Future<String> fetchUsername(String id);
  Future<void> updateUserProfile(Freelancer freelancer);
}