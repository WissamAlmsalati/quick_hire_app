import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quick_hire/features/authintication_screens/data/repositories/auth_repository.dart';

import '../../data/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> signUp(
      String email, String password, String username, String userType) async {
    emit(AuthLoading());
    try {
      final user =
          await authRepository.signUp(email, password, username, userType);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      print('signing in');
      final user = await authRepository.login(email, password);
      emit(AuthSuccess(user));
      print('Signed in successfully');
    } catch (e) {
      print('Error signing in: $e');
      emit(AuthError(e.toString()));
    }
  }
}
