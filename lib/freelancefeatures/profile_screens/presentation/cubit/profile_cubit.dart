import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_hire/freelancefeatures/authintication_screens/data/models/freelancer_model.dart';
import '../../../authintication_screens/data/models/client_model.dart';
import '../domain/repositories/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository;

  ProfileCubit(this.userRepository) : super(ProfileInitial());

  Future<void> fetchProfile(String userId) async {
    try {
      emit(ProfileLoading());
      final freelancer = await userRepository.fetchUserProfile();
      emit(ProfileLoaded(freelancerProfileData: freelancer));
    } catch (e) {
      print('Error: $e');
      emit(ProfileError(e.toString()));
    }
  }
}