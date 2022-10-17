import 'package:flutter_bloc/flutter_bloc.dart';

import '../repos/repositories.dart';
import 'user_events.dart';
import 'user_states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>(
      (event, emit) async {
        emit(UserLoadingState());
        try {
          final users = await _userRepository.getUsers();
          emit(UserLoadedState(users));
        } catch (e) {
          emit(UserErrorState(e.toString()));
        }
      },
    );
  }
}
