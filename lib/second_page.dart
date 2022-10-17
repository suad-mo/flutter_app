import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/blocs/app_blocs.dart';
import 'package:flutter_bloc_counter/events/app_events.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterBlocs counterBlocs = BlocProvider.of<CounterBlocs>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocs'),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder(
        bloc: counterBlocs,
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                Text(
                  counterBlocs.state.counter.toString(),
                  style: const TextStyle(fontSize: 30),
                ),
                ElevatedButton(
                  onPressed: () => counterBlocs.add(Increment()),
                  child: const Icon(Icons.add),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
