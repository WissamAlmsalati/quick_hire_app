part of 'job_cubit.dart';



abstract class JobState extends Equatable {
  @override
  List<Object> get props => [];
}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final List<Job> jobs;

  JobLoaded({required this.jobs});

  @override
  List<Object> get props => [jobs];
}

class JobError extends JobState {
  final String message;

  JobError({required this.message});

  @override
  List<Object> get props => [message];
}
