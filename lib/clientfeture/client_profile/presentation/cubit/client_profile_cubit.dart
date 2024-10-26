import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../features/profile_screens/data/repositories/user_repository_impl.dart';
import '../../data/client_profile_model.dart';
import 'package:http/http.dart' as http;
part 'client_profile_state.dart';
// client_profile_cubit.dart

class ClientProfileCubit extends Cubit<ClientProfileState> {
  ClientProfileCubit() : super(ClientProfileInitial());

  void fetchClientProfile(String userId) async {
    try {
      emit(ClientProfileLoading());
      final response = await http.get(Uri.parse('https://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/users/user/$userId'));

      if (response.statusCode == 200) {
        final profile = ClientProfile.fromJson(json.decode(response.body));
        emit(ClientProfileLoaded(profile));
      } else {
        emit(ClientProfileError('Failed to load client profile'));
      }
    } catch (e) {
      emit(ClientProfileError(e.toString()));
    }
  }
}
