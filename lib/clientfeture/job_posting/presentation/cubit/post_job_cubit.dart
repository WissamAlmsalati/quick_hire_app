import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quick_hire/clientfeture/job_posting/data/models/job_post_model.dart';
import 'package:quick_hire/clientfeture/job_posting/data/repositories/job_repository.dart';

part 'post_job_state.dart';

class PostJobCubit extends Cubit<PostJobState> {
  final PostJobRepository jobRepository;

  PostJobCubit(this.jobRepository) : super(PostJobInitial());

  Future<void> postJob(PostJobModel postJobModel) async {
    try {
      emit(PostJobLoading());
      await jobRepository.postJob(postJobModel);
      emit(PostJobSuccess());
    } catch (e) {
      emit(PostJobError('Failed to post job'));
    }
  }
}