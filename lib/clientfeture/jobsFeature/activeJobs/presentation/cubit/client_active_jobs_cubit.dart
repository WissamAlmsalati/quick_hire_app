import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_hire/clientfeture/jobsFeature/activeJobs/data/active_job_model.dart';
import 'package:quick_hire/clientfeture/jobsFeature/activeJobs/reppostry/active_job_repository.dart';


part 'client_active_jobs_state.dart';

class ClientActiveJobsCubit extends Cubit<ClientActiveJobsState> {
  final ActiveJobRepository activeJobRepository;

  ClientActiveJobsCubit(this.activeJobRepository) : super(ClientActiveJobsInitial());

  Future<void> fetchActiveJobs(String clientId) async {
    emit(ClientActiveJobsLoading());
    try {
      final jobs = await activeJobRepository.fetchActiveJobs(clientId);
      emit(ClientActiveJobsLoaded(jobs));
    } catch (e) {
      emit(ClientActiveJobsError(e.toString()));
    }
  }
}