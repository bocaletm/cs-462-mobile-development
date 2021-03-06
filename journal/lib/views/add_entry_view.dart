import 'package:flutter/material.dart';
import 'package:journal/styles/styles.dart';
import 'package:journal/views/form_body.dart';
import 'package:journal/models/journal.dart';

class AddEntryView extends StatefulWidget {

  final void Function() _toggleDarkMode;
  final Styles Function() _getStyles;

  AddEntryView(this._getStyles,this._toggleDarkMode, {Key key}) : super(key: key);

  @override
  _AddEntryViewState createState() => _AddEntryViewState(_getStyles, _toggleDarkMode);
}

class _AddEntryViewState extends State<AddEntryView> {
  static const _iconName = 'settings';
  static const _title = 'New Journal Entry';
  static const _titleStyle = 'h1Alt';
  static const _drawerHeader = 'Settings';
  static const _headStyle = 'h1';
  static const _subheadStyle = 'h2';
  static const _toggleHeader = 'Dark Mode';
  static const _dbName = 'journal.db';

  final void Function() _toggleDarkMode;  
  final Styles Function() _getStyles;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _darkMode;

  Styles _styles;

  Journal _journal;

  _AddEntryViewState(this._getStyles, this._toggleDarkMode) {
    _styles = _getStyles();
    _darkMode = _styles.theme == 'dark' ? true : false;
    _journal = Journal(_dbName);
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
          body: FormBody( () => _darkMode, _journal ),
        );
      },
    );
  }
}