part of 'post_job_cubit.dart';


@immutable
sealed class PostJobState {}

final class PostJobInitial extends PostJobState {}

final class PostJobLoading extends PostJobState {}

final class PostJobSuccess extends PostJobState {}

final class PostJobError extends PostJobState {
  final String message;

  PostJobError(this.message);
}