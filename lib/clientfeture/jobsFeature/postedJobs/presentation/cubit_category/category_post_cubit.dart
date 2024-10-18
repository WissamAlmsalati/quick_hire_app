import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quick_hire/clientfeture/jobsFeature/postedJobs/data/models/category_post_job.dart';

import '../../data/repostry/category_post_job_repository.dart';

part 'category_post_state.dart';


class CategoryPostJobCubit extends Cubit<CategoryPostJobState> {
  final CategoryPostJobRepository categoryRepository;

  CategoryPostJobCubit(this.categoryRepository) : super(CategoryPostJobInitial());

  Future<void> fetchCategories() async {
    emit(CategoryPostJobLoading());
    try {
      final categories = await categoryRepository.fetchCategories();
      emit(CategoryPostJobLoaded(categories));
    } catch (e) {
      emit(CategoryPostJobError(e.toString()));
    }
  }
}