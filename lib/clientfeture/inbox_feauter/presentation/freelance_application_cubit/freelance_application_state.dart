part of 'freelance_application_cubit.dart';

abstract class InboxApplicationState extends Equatable {
  const InboxApplicationState();

  @override
  List<Object> get props => [];
}

class InboxApplicationInitial extends InboxApplicationState {}

class InboxApplicationLoading extends InboxApplicationState {}

class InboxApplicationLoaded extends InboxApplicationState {
  final ApplicationsResponse applicationsResponse;

  const InboxApplicationLoaded(this.applicationsResponse);

  @override
  List<Object> get props => [applicationsResponse];
}

class InboxApplicationError extends InboxApplicationState {
  final String message;

  const InboxApplicationError(this.message);

  @override
  List<Object> get props => [message];
}