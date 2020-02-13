import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project3/app.dart';

void main() {
  const String title = 'Call Me Maybe';

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  
  runApp(MaterialApp(
    title: title,
    home: App(title),
    theme: ThemeData(
      primarySwatch: Colors.grey,
      fontFamily: 'Consolas',
    ),
  ));
}