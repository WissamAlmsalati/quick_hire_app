import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void updateIndex(int index){
    emit(index);
  }
}
