part of 'client_active_jobs_cubit.dart';

abstract class ClientActiveJobsState extends Equatable {
  const ClientActiveJobsState();

  @override
  List<Object> get props => [];
}

class ClientActiveJobsInitial extends ClientActiveJobsState {}

class ClientActiveJobsLoading extends ClientActiveJobsState {}

class ClientActiveJobsLoaded extends ClientActiveJobsState {
  final List<ActiveJob> activeJobs;

  const ClientActiveJobsLoaded(this.activeJobs);

  @override
  List<Object> get props => [activeJobs];
}

class ClientActiveJobsError extends ClientActiveJobsState {
  final String message;

  const ClientActiveJobsError(this.message);

  @override
  List<Object> get props => [message];
}