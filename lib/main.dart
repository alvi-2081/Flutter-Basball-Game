import 'package:baseball_game/Views/Screeens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Home.routeName,
      routes: {
        Home.routeName: (BuildContext context) =>
            const Home(title: 'Baseball Game')
      },
    );
  }
}
