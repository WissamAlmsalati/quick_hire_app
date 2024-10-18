part of 'inbox_cubit.dart';

// lib/clientfeture/inbox_feature/presentation/cubit/inbox_state.dart

abstract class InboxState {}

class InboxInitial extends InboxState {}

class InboxLoading extends InboxState {}

class InboxLoaded extends InboxState {
  final List<ApplicationModel> applications;

  InboxLoaded(this.applications);
}

class InboxError extends InboxState {
  final String message;

  InboxError(this.message);
}