import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// enum CounterEvent { increment }

abstract class CounterEvents {}

class Increment extends CounterEvents {}

class Decrement extends CounterEvents {}

class CounterStates {
  int counter;
  CounterStates({required this.counter});
}

// data loading state
class InitialState extends CounterStates {
  InitialState() : super(counter: 0);
}

// data loaded state

mixin GlobalCounter on Bloc<CounterEvents, CounterStates> {}

mixin LocalCounter on Bloc<CounterEvents, CounterStates> {}

class CounterBlocs extends Bloc<CounterEvents, CounterStates>
    with GlobalCounter, LocalCounter {
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

// PPKUŠAJ SA PARAMETRIMA
// mixin CounterMixin<E extends CounterEvents, S extends CounterStates>
//     on Bloc<E, S> {
//   // common logic...
// }

// class LocalCounterBloc extends Bloc<CounterEvents, CounterStates>
//     with CounterMixin {
//   LocalCounterBloc() : super(InitialState());
// }

// class GlobalCounterBloc extends Bloc<CounterEvents, CounterStates>
//     with CounterMixin {
//   GlobalCounterBloc() : super(InitialState());
// }

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalCounter>(create: (_) => CounterBlocs()),
        BlocProvider<LocalCounter>(create: (_) => CounterBlocs()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Global Counter'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                Navigator.of(context).push(GlobalCounterScreen.route()),
          ),
          BlocBuilder<GlobalCounter, CounterStates>(
            builder: (context, state) {
              return ListTile(
                title: Text(state.counter.toString()),
                trailing: const Icon(Icons.add),
                onTap: () =>
                    BlocProvider.of<GlobalCounter>(context).add(Increment()),
              );
            },
          ),
          ListTile(
            title: const Text('Local Counter'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(LocalCounterScreen.route()),
          ),
          BlocBuilder<LocalCounter, CounterStates>(
            builder: (context, state) {
              return ListTile(
                title: Text(state.counter.toString()),
                trailing: const Icon(Icons.add),
                onTap: () =>
                    BlocProvider.of<LocalCounter>(context).add(Increment()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.point_of_sale),
          onPressed: () {
            BlocProvider.of<GlobalCounter>(context).add(Decrement());
            BlocProvider.of<LocalCounter>(context).add(Decrement());
          }),
    );
  }
}

class GlobalCounterScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => GlobalCounterScreen._(),
    );
  }

  const GlobalCounterScreen._({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Counter'),
      ),
      body: Center(
        child: BlocBuilder<GlobalCounter, CounterStates>(
          builder: (context, state) {
            return Text('Global Count: ${state.counter}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            BlocProvider.of<GlobalCounter>(context).add(Increment()),
      ),
    );
  }
}

class LocalCounterScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LocalCounterScreen._(),
      // BlocProvider<LocalCounter>(
      //   create: (_) => CounterBlocs(),
      //   child: LocalCounterScreen._(),
      // ),
    );
  }

  const LocalCounterScreen._({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Counter'),
      ),
      body: Center(
        child: BlocBuilder<LocalCounter, CounterStates>(
          builder: (context, state) {
            return Text('Local Count: ${state.counter}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            BlocProvider.of<LocalCounter>(context).add(Increment()),
      ),
    );
  }
}
