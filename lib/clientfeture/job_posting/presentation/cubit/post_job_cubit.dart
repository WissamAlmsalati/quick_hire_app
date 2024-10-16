import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_job_state.dart';

class PostJobCubit extends Cubit<PostJobState> {
  PostJobCubit() : super(PostJobInitial());
}
