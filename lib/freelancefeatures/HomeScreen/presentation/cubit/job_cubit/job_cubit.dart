import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../../../domain/entities/job.dart';
import '../../../domain/usecases/get_jobs.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/job_repository.dart';

part 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  final GetJobs getJobs;
  final ApplyJob? applyJob;
  final AuthLocalDataSource? authLocalDataSource;

  JobCubit({
    required this.getJobs,
    this.applyJob,
    this.authLocalDataSource,
  }) : super(JobInitial());

  Future<void> fetchJobs() async {
    emit(JobLoading());
    try {
      final jobs = await getJobs();
      emit(JobLoaded(jobs: jobs));
    } catch (e) {
      emit(JobError(message: e.toString()));
    }
  }

  Future<void> applyForJob(String jobId) async {
    if (applyJob == null) {
      emit(JobError(message: 'ApplyJob use case is not provided'));
      return;
    }
    emit(JobLoading());
    try {
      final freelancerId = await authLocalDataSource?.getId();
      if (freelancerId == null) {
        emit(JobError(message: 'Freelancer ID not found'));
        return;
      }
      await applyJob!(jobId, freelancerId);
      emit(JobApplicationSuccess());
    } catch (e) {
      emit(JobError(message: e.toString()));
    }
  }
}

class JobApplicationSuccess extends JobState {}