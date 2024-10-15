// lib/freelancefeatures/profile_screens/presentation/cubit/profile_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/repositories/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository;

  ProfileCubit(this.userRepository) : super(ProfileInitial());

  Future<void> fetchProfile(String userId) async {
    try {
      emit(ProfileLoading());
      final profileData = await userRepository.fetchUserProfile(userId);
      emit(ProfileLoaded(profileData));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}