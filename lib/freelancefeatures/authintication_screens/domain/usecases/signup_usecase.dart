import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';


class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<User> call(String email, String password, String username, String userType) {
    return repository.signUp(email, password  , username, userType);
  }
}