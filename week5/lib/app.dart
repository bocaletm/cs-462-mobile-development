import 'package:flutter/material.dart';
import 'main_screen.dart';

class App extends StatelessWidget {
  
  final String title;

  const App({Key key, this.title}) : super (key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(title: title),
    );
  }
}