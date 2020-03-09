import 'package:flutter/material.dart';
import 'package:wasteagram/postController.dart';
import 'package:wasteagram/views/post_list.dart';

class App extends StatefulWidget {

  App();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostList(),
    );
  }
}