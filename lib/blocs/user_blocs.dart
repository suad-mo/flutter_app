import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc_counter/blocs/user_events.dart';
import 'package:flutter_bloc_counter/blocs/user_states.dart';
import 'package:flutter_bloc_counter/repos/repositories.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>(
      (event, emit) async {
        emit(UserLoadingState());
      },
    );
  }
}
