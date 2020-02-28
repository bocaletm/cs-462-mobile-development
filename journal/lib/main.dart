import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:journal/app.dart';
import 'package:journal/models/journal.dart';

void main() async {
  Journal journal = Journal();

  WidgetsFlutterBinding.ensureInitialized();
  
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await journal.getEntries();

  runApp(App(prefs, journal));
}