class CounterStates {
  int counter;
  CounterStates({required this.counter});
}

// data loading state
class InitialState extends CounterStates {
  InitialState() : super(counter: 0);
}

// date loaded state
// class LoadedState extends CounterStates {
//   LoadedState() : super(counter: counter);
// }


// data error loading state