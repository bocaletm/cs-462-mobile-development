import 'package:flutter/material.dart';
import 'package:journal/views/journal_view.dart';
import 'package:journal/views/add_entry_view.dart';
import 'package:journal/models/journal.dart';


class App extends StatelessWidget {
  static final _routes = {
    'journal': (context) => JournalView(),
    'add-entry': (context) => AddEntryView(),
  };

  final Brightness _brightness;
  final Widget _landingPage;
  final Journal _journal;

  App(this._landingPage, this._brightness, this._journal);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: _brightness,
        primarySwatch: Colors.blue,
      ),
      title: 'Journal',
      routes: _routes,
      home: _landingPage,
    );
  }
}