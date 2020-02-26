import 'package:flutter/material.dart';
import 'package:journal/app.dart';

import 'package:journal/models/preferences.dart';
import 'package:journal/models/journal.dart';


void main() async {
  Preferences prefs = Preferences();
  Journal journal = Journal();

  await prefs.getPrefs();
  await journal.getEntries();

  Brightness brightness = (prefs.isDark ?? false) ? Brightness.dark: Brightness.light;

  runApp(App(brightness, journal));
}