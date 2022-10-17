import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/blocs/app_blocs.dart';
import 'package:flutter_bloc_counter/blocs/user_blocs.dart';
import 'package:flutter_bloc_counter/blocs/user_events.dart';
import 'package:flutter_bloc_counter/events/app_events.dart';
import 'package:flutter_bloc_counter/models/user_model.dart';
import 'package:flutter_bloc_counter/repos/repositories.dart';
import 'package:flutter_bloc_counter/screens/detail_scren.dart';
import 'package:flutter_bloc_counter/second_page.dart';
import 'package:flutter_bloc_counter/states/app_states.dart';

import 'blocs/user_states.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('The BloC App'),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserLoadedState) {
              final List<UserModel> userList = state.users;
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailScreen(e: userList[index]),
                      ));
                    },
                    child: Card(
                      color: Colors.blue,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(
                          userList[index].firstName,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          userList[index].lastName,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        trailing: CircleAvatar(
                            backgroundImage:
                                NetworkImage(userList[index].avatar)),
                      ),
                    ),
                  ),
                ),
              );
            }

            if (state is UserErrorState) {
              return Center(
                child: Text(state.error),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CounterBlocs, CounterStates>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.counter.toString(),
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<CounterBlocs>(context).add(Increment()),
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<CounterBlocs>(context).add(Decrement()),
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondPage()));
                },
                child: Container(
                  width: 138,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  child: const Center(
                    child: Text(
                      'click',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
