import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../freelancefeatures/HomeScreen/domain/entities/job.dart';
import '../../repostry/search_repository.dart';

part 'search_state.dart';


class SearchCubit extends Cubit<SearchState> {
  final SearchRepository searchRepository;

  SearchCubit(this.searchRepository) : super(SearchInitial());

  Future<void> searchJobs(String query) async {
    try {
      emit(SearchLoading());
      final results = await searchRepository.searchJobs(query);
      emit(SearchLoaded(results)); // Make sure `results` is a List<Job>
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void clearSearchResults() {
    emit(SearchInitial());
  }
}
