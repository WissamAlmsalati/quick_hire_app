// lib/freelancefeatures/profile_screens/presentation/cubit/profile_state.dart
part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Freelancer profileData;

  const ProfileLoaded(this.profileData);

  @override
  List<Object> get props => [profileData];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}