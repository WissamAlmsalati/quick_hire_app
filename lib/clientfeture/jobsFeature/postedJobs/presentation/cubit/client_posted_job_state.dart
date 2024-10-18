part of 'client_posted_job_cubit.dart';

abstract class ClientPostedJobsState extends Equatable {
  const ClientPostedJobsState();

  @override
  List<Object> get props => [];
}

class ClientPostedJobsInitial extends ClientPostedJobsState {}

class ClientPostedJobsLoading extends ClientPostedJobsState {}

class ClientPostedJobsLoaded extends ClientPostedJobsState {
  final List<PostedJob> postedJobs;

  const ClientPostedJobsLoaded(this.postedJobs);

  @override
  List<Object> get props => [postedJobs];
}

class ClientPostedJobsError extends ClientPostedJobsState {
  final String message;

  const ClientPostedJobsError(this.message);

  @override
  List<Object> get props => [message];
}