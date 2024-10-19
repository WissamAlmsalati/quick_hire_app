import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/freelance_application_model.dart';
import '../../data/repostry/freelance_application_repository.dart';

part 'freelance_application_state.dart';

class InboxApplicationCubit extends Cubit<InboxApplicationState> {
  final ApplicationRepository applicationRepository;

  InboxApplicationCubit(this.applicationRepository) : super(InboxApplicationInitial());

  Future<void> fetchApplications(String jobId) async {
    try {
      emit(InboxApplicationLoading());
      final ApplicationsResponse applications = await applicationRepository.fetchApplications(jobId);
      emit(InboxApplicationLoaded(applications));
    } catch (e) {
      emit(InboxApplicationError(e.toString()));
    }
  }
}