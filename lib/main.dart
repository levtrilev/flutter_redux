import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_simple/example_with_data.dart';

  class AppData {
    String name;
    int age;
    AppData({
      required this.name,
      required this.age,
    });
  }
void main() {
  runApp(Example());
  // Store<AppData> myStore = Store(myReducer, initialState: AppData(age: 17, name: 'Ivan' ));
  // runApp(
  //   StoreProvider(
  //     store: myStore,
  //     child: MaterialApp(
  //       title: 'Flutter Redux simple demo',
  //       theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //       ),
  //       home: MyReduxExample(title: 'Flutter Redux simple demo'),
  //     ),
  //   ),
  // );
}

class MyReduxExample extends StatelessWidget {
  final String title;
  const MyReduxExample({Key? key, required this.title}) : super(key: key);
  //final int _counter = 5;

  //   void _incrementCounter() {
  //   _counter++;
  // }

  @override
  Widget build(BuildContext context) {
    final Store<AppData> store = StoreProvider.of<AppData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StoreConnector<AppData, AppData>(
              converter: (storeInConverter) => storeInConverter.state,
              builder: (context, state) => Text(
                'имя: ${state.name}, возраст: ${state.age.toString()}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => store.dispatch(AddAction()),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddAction {}

AppData myReducer(AppData state, dynamic action) {
  if (action is AddAction) {
    return AppData(age: state.age + 1, name: state.name);
  }
  return state;
}
