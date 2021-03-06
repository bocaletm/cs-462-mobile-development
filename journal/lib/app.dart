import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:journal/views/journal_view.dart';
import 'package:journal/views/welcome_view.dart';
import 'package:journal/styles/styles.dart';

class App extends StatefulWidget {

  final bool _skipWelcomePage;
  final SharedPreferences _prefs;

  App(this._prefs,this._skipWelcomePage);

  @override
  _AppState createState() => _AppState(_prefs,_skipWelcomePage);
}

class _AppState extends State<App> {
  static const _swatchColor = Colors.blue;
  static const _title = 'Journal';

  final bool _skipWelcomePage;
  final SharedPreferences _prefs;

  bool _darkMode;
  Styles _styles;
  Brightness _brightness;

  Widget _landingPage;

  _AppState(this._prefs, this._skipWelcomePage) {
    _darkMode =_prefs.containsKey('darkMode') ? _prefs.getBool('darkMode') : false;
    _darkMode ? _brightness = Brightness.dark : _brightness = Brightness.light;
    _darkMode ? _styles = Styles('dark') : _styles = Styles('light');
    _skipWelcomePage ? _landingPage = JournalView(getStyles,toggleDarkMode) :  _landingPage = Welcome(getStyles,toggleDarkMode);
  }

  Styles getStyles() => _styles;

  void toggleDarkMode() {
    setState(() {
      _darkMode ? _darkMode = false : _darkMode = true;
      _darkMode ? _styles = Styles('dark') : _styles = Styles('light');
      _darkMode ? _brightness = Brightness.dark : _brightness = Brightness.light;
      _prefs.setBool('darkMode', _darkMode);
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
      home: _landingPage,
    );
  }
}