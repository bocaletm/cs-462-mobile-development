import 'package:flutter/material.dart';
import 'package:journal/views/journal_view.dart';
import 'package:journal/views/welcome_view.dart';
import 'package:journal/views/add_entry_view.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/styles/styles.dart';

class App extends StatefulWidget {


  final Brightness _brightness;
  final Journal _journal;

  App(this._brightness, this._journal);

  @override
  _AppState createState() => _AppState(_brightness, _journal);
}

class _AppState extends State<App> {
  static const _swatchColor = Colors.blue;
  static const _title = 'Journal';
  static final _routes = {
    'journal': (context) => JournalView(),
    'add-entry': (context) => AddEntryView(),
  };


  final Journal _journal;

  Brightness _brightness;
  bool _darkMode = false;
  Styles _styles;

  Widget _landingPage;

  _AppState(this._brightness, this._journal) {
    if (_brightness == Brightness.dark) {
      _darkMode = true;
    }
    _journal.isNotEmpty ? _landingPage = JournalView() : _landingPage = Welcome(_darkMode,toggleDarkMode);
  }

  get styles => styles;

  void toggleDarkMode() {
    setState(() {
      _darkMode ? _darkMode = false : _darkMode = true;
      _darkMode ? _styles = Styles('dark') : _styles = Styles('light');
      print('set style to ${_styles.theme}');
      _darkMode ? _brightness = Brightness.dark : _brightness = Brightness.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: _brightness,
        primarySwatch: _swatchColor,
      ),
      title: _title,
      routes: _routes,
      home: _landingPage,
    );
  }
}