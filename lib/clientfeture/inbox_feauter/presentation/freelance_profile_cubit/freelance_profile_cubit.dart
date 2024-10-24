import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../freelancefeatures/authintication_screens/data/models/freelancer_model.dart';
import '../../data/repostry/profile_freelance_repostry.dart';

part 'freelance_profile_state.dart';

class FreelanceProfileCubit extends Cubit<FreelanceProfileState> {
  final ProfileRepository profileRepository;

  FreelanceProfileCubit(this.profileRepository) : super(FreelanceProfileInitial());

  Future<void> fetchProfile(String userId) async {
    try {
      emit(FreelanceProfileLoading());
      final profile = await profileRepository.fetchProfileById(userId);
      emit(FreelanceProfileLoaded(Freelancer.fromJson(profile)));
    } catch (e) {
      print('Error fetching profile: $e');
      emit(FreelanceProfileError(e.toString()));
    }
  }
}