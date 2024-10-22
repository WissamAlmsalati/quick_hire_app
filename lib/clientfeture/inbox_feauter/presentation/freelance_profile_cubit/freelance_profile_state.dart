part of 'freelance_profile_cubit.dart';

abstract class FreelanceProfileState extends Equatable {
  const FreelanceProfileState();

  @override
  List<Object> get props => [];
}

class FreelanceProfileInitial extends FreelanceProfileState {}

class FreelanceProfileLoading extends FreelanceProfileState {}

class FreelanceProfileLoaded extends FreelanceProfileState {
  final Map<String, dynamic> profile;

  const FreelanceProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class FreelanceProfileError extends FreelanceProfileState {
  final String message;

  const FreelanceProfileError(this.message);

  @override
  List<Object> get props => [message];
}