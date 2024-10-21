part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Freelancer? freelancerProfileData;
  final Client? clientProfileData;

  const ProfileLoaded({this.freelancerProfileData, this.clientProfileData});

  @override
  List<Object> get props => [freelancerProfileData ?? Object(), clientProfileData ?? Object()];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}