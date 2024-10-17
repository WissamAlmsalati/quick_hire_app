part of 'client_job_cubit.dart';


abstract class ClientJobPostedState extends Equatable {
  const ClientJobPostedState();

  @override
  List<Object> get props => [];
}

class ClientJobPostedInitial extends ClientJobPostedState {}

class ClientJobPostedLoading extends ClientJobPostedState {}

class ClientJobPostedLoaded extends ClientJobPostedState {
  final List<ClientJobPosted> jobs;

  const ClientJobPostedLoaded({required this.jobs});

  @override
  List<Object> get props => [jobs];
}

class ClientJobPostedError extends ClientJobPostedState {
  final String message;

  const ClientJobPostedError({required this.message});

  @override
  List<Object> get props => [message];
}