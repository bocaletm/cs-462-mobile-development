import 'package:flutter/material.dart';
import 'package:project3/app.dart';

void main() {
  const String title = 'Call Me Maybe';
  runApp(MaterialApp(
    title: title,
    home: App(title),
    theme: ThemeData(
      primarySwatch: Colors.grey,
    ),
  ));
}