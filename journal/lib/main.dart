import 'package:flutter/material.dart';
import 'package:journal/app.dart';
import 'package:journal/views/welcome_view.dart';
import 'package:journal/views/journal_view.dart';
import 'package:journal/models/preferences.dart';
import 'package:journal/models/journal.dart';


void main() async {
  Preferences prefs = Preferences();
  Journal journal = Journal();

  await prefs.getPrefs();
  await journal.getEntries();

  Brightness brightness = (prefs.isDark ?? false) ? Brightness.dark: Brightness.light;
  Widget landingPage = Welcome();

  if (journal.isNotEmpty) {
    landingPage = JournalView();
  }

  runApp(App(landingPage, brightness, journal));
}