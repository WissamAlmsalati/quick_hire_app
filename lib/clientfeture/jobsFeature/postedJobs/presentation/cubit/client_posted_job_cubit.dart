import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../data/models/posted_job.dart';
import '../../data/repostry/posted_job_repository.dart';

part 'client_posted_job_state.dart';

class ClientPostedJobsCubit extends Cubit<ClientPostedJobsState> {
  final PostedJobRepository postedJobRepository;

  ClientPostedJobsCubit(this.postedJobRepository) : super(ClientPostedJobsInitial());

  Future<void> fetchPostedJobs(String clientId) async {
    emit(ClientPostedJobsLoading());
    try {
      final jobs = await postedJobRepository.fetchPostedJobs(clientId);
      emit(ClientPostedJobsLoaded(jobs));
    } catch (e) {
      emit(ClientPostedJobsError(e.toString()));
    }
  }
}