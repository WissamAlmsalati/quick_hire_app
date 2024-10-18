import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/application_model.dart';
import '../../data/repostry/inbox_repository.dart';

part 'inbox_state.dart';


class InboxCubit extends Cubit<InboxState> {
  final InboxRepository repository;

  InboxCubit(this.repository) : super(InboxInitial());

  void fetchApplications(String jobId) async {
    try {
      emit(InboxLoading());
      final applications = await repository.fetchApplications(jobId);
      emit(InboxLoaded(applications));
    } catch (e) {
      emit(InboxError(e.toString()));
    }
  }

  void acceptApplication(String jobId, String freelancerId) async {
    try {
      await repository.acceptApplication(jobId, freelancerId);
      fetchApplications(jobId);
    } catch (e) {
      emit(InboxError(e.toString()));
    }
  }
}