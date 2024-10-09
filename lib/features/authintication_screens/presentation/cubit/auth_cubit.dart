// auth_cubit.dart
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quick_hire/features/authintication_screens/data/repositories/auth_repository_impl.dart';
import '../../data/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryImpl authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> signUp(
      String email, String password, String username, String userType) async {
    print('Signing up now');
    emit(AuthLoading());
    try {
      final user = await authRepository.signUp(email, password, username, userType);
      print('Signed up successfully: ${user.toString()}');
      emit(AuthSuccess(user));
    } on SocketException catch (e) {
      print('Network error: $e');
      emit(AuthError('Network error: Please check your internet connection.'));
    } catch (e) {
      print('Error signing up: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    print('Signing in');
    emit(AuthLoading());
    try {
      final user = await authRepository.login(email, password);
      print('Signed in successfully: ${user.toString()}');
      emit(AuthSuccess(user));
    } on SocketException catch (e) {
      print('Network error: $e');
      emit(AuthError('Network error: Please check your internet connection.'));
    } catch (e) {
      print('Error signing in: $e');
      emit(AuthError(e.toString()));
    }
  }
}