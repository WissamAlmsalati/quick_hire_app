import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/client_job_posted_model.dart';
import '../../data/repositories/client_job_posted_repository.dart';

part 'client_job_state.dart';



class ClientJobPostedCubit extends Cubit<ClientJobPostedState> {
  final ClientJobPostedRepository jobRepository;

  ClientJobPostedCubit({required this.jobRepository}) : super(ClientJobPostedInitial());

  Future<void> fetchJobs() async {
    try {
      emit(ClientJobPostedLoading());
      final jobs = await jobRepository.fetchJobs();
      emit(ClientJobPostedLoaded(jobs: jobs));
    } catch (e) {
      emit(ClientJobPostedError(message: e.toString()));
    }
  }
}