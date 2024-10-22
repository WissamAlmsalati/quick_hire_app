import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../repostry/applied_jobs_repository.dart';

part 'applied_jobs_state.dart';



class AppliedJobsCubit extends Cubit<AppliedJobsState> {
  final AppliedJobsRepository appliedJobsRepository;

  AppliedJobsCubit(this.appliedJobsRepository) : super(AppliedJobsInitial());

  Future<void> fetchAppliedJobs(String freelancerId) async {
    try {
      emit(AppliedJobsLoading());
      final jobs = await appliedJobsRepository.fetchAppliedJobs(freelancerId);
      emit(AppliedJobsLoaded(jobs));
    } catch (e) {
      print('Error fetching applied jobs: $e');
      emit(AppliedJobsError(e.toString()));
    }
  }
}
