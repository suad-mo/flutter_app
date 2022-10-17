import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/app_events.dart';
import '../states/app_states.dart';

class CounterBlocs extends Bloc<CounterEvents, CounterStates> {
  CounterBlocs() : super(InitialState()) {
    on<Increment>((event, emit) {
      emit(CounterStates(counter: state.counter + 1));
    });

    on<Decrement>(
      (event, emit) {
        emit(CounterStates(counter: state.counter - 1));
      },
    );
  }
}
