import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/styles/styles.dart';
import 'package:journal/views/add_entry_view.dart';
import 'package:journal/views/vertical.dart';
import 'package:journal/views/horizontal.dart';


class JournalView extends StatefulWidget {

  final Styles Function() _getStyles;
  final void Function() _toggleDarkMode;  
  
  JournalView(this._getStyles, this._toggleDarkMode);

  @override
  _JournalViewState createState() => _JournalViewState(_getStyles, _toggleDarkMode);
}

class _JournalViewState extends State<JournalView> {

  static const _drawerHeader = 'Settings';
  static const _headStyle = 'h1';
  static const _subheadStyle = 'h2';
  static const _toggleHeader = 'Dark Mode';
  static const _title = 'Journal Entries';
  static const _titleStyle = 'h1Alt';
  static const _iconName = 'settings';
  static const _dbName = 'journal.db';
  
  final void Function() _toggleDarkMode;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Styles Function() _getStyles;
  bool _darkMode;
  Styles _styles;
  Journal _journal;

  _JournalViewState(this._getStyles, this._toggleDarkMode) {
    _styles = _getStyles();
    _darkMode = _styles.theme == 'dark' ? true : false;
    _journal = Journal(_dbName);
  }

  Future<List<JournalEntry>> getJournalEntries() async {
    await _journal.getEntries();
    return _journal.entries;
  }

  Widget _orientedView(BuildContext context, BoxConstraints constraints) {
    return constraints.maxWidth > 500 ? Horizontal(getJournalEntries, _getStyles) : Vertical(getJournalEntries, _getStyles);
  }

  Widget _drawerContainer() {
    return Container(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: [ 
            _styles.verticalPadding(MediaQuery.of(context).size.height * _styles.paddingFactor),
            ListTile(title: _styles.formattedText(_drawerHeader, _headStyle)),
            ListTile(
              leading: _styles.formattedText(_toggleHeader, _subheadStyle),
              trailing: Switch(
                value: _darkMode, 
                onChanged: (value) {
                  _toggleDarkMode();
                  setState(() {
                    _darkMode = value;
                  });
                }
              ),
            ),
          ]),
      ), 
      width: MediaQuery.of(context).size.width * _styles.drawerFactor,
    );
  }

  _navigateToFormAndDisplayResult(BuildContext context) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => AddEntryView(_getStyles,_toggleDarkMode)));
              
    _scaffoldKey.currentState
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: _styles.formattedText('$result', _titleStyle)));
  }

  @override
  Widget build(BuildContext context) {
    _styles = _getStyles();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          key: _scaffoldKey,
          endDrawer: _drawerContainer(),
          appBar: AppBar(
            title: Center(child: _styles.formattedText(_title,_titleStyle)),
            actions: [ 
              IconButton(
                icon: Icon(Icons.settings, color: _styles.themeIconColors[_iconName]), 
                onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
              )
            ],
          ),
          body: LayoutBuilder(builder: _orientedView),
          floatingActionButtonAnimator: null,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _navigateToFormAndDisplayResult(context),
          ),
        );
      },
    );
  }
}