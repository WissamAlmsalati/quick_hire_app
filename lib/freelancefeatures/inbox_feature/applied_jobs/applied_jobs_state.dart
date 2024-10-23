part of 'applied_jobs_cubit.dart';

abstract class AppliedJobsState extends Equatable {
  const AppliedJobsState();

  @override
  List<Object> get props => [];
}

class AppliedJobsInitial extends AppliedJobsState {}

class AppliedJobsLoading extends AppliedJobsState {}

class AppliedJobsLoaded extends AppliedJobsState {
  final List<dynamic> jobs;

  const AppliedJobsLoaded(this.jobs);

  @override
  List<Object> get props => [jobs];
}

class AppliedJobsError extends AppliedJobsState {
  final String message;

  const AppliedJobsError(this.message);

  @override
  List<Object> get props => [message];
}