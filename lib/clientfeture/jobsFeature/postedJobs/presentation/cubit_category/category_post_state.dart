part of 'category_post_cubit.dart';

abstract class CategoryPostJobState extends Equatable {
  const CategoryPostJobState();

  @override
  List<Object> get props => [];
}

class CategoryPostJobInitial extends CategoryPostJobState {}

class CategoryPostJobLoading extends CategoryPostJobState {}

class CategoryPostJobLoaded extends CategoryPostJobState {
  final List<CategoryPostJob> categories;

  const CategoryPostJobLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryPostJobError extends CategoryPostJobState {
  final String message;

  const CategoryPostJobError(this.message);

  @override
  List<Object> get props => [message];
}