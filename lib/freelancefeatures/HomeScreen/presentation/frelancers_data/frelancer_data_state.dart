part of 'frelancer_data_cubit.dart';

abstract class FreelancerState extends Equatable {
  const FreelancerState();

  @override
  List<Object> get props => [];
}

class FreelancerInitial extends FreelancerState {}

class FreelancerLoading extends FreelancerState {}

class FreelancerLoaded extends FreelancerState {
  final List<Freelancer> freelancers;

  const FreelancerLoaded(this.freelancers);

  @override
  List<Object> get props => [freelancers];
}

class FreelancerError extends FreelancerState {
  final String message;

  const FreelancerError(this.message);

  @override
  List<Object> get props => [message];
}