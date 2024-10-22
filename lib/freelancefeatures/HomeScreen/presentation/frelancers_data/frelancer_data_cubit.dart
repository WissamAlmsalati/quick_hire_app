import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../authintication_screens/data/models/freelancer_model.dart';
import '../../data/repositories/freelancer_repository.dart';

part 'frelancer_data_state.dart';

class FreelancerCubit extends Cubit<FreelancerState> {
  final FreelancerRepository repository;

  FreelancerCubit(this.repository) : super(FreelancerInitial());

  Future<void> fetchFreelancers() async {
    try {
      emit(FreelancerLoading());
      final freelancers = await repository.fetchFreelancers();
      emit(FreelancerLoaded(freelancers));
    } catch (e) {
      emit(FreelancerError(e.toString()));
    }
  }
}