import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/job.dart';
import '../../../domain/usecases/get_jobs.dart';
import 'package:equatable/equatable.dart';


part 'job_state.dart';


class JobCubit extends Cubit<JobState> {
  final GetJobs getJobs;

  JobCubit({required this.getJobs}) : super(JobInitial());

  Future<void> fetchJobs() async {
    emit(JobLoading());
    try {
      print("fetching jobs");
      final jobs = await getJobs();
      print(jobs);
      emit(JobLoaded(jobs: jobs));
    } catch (e) {
      print(e);
      emit(JobError(message: e.toString()));
    }
  }
}
