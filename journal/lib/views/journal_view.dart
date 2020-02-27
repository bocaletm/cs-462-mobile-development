import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/styles/styles.dart';

class JournalView extends StatefulWidget {

  final bool _darkMode;
  final void Function() _toggleDarkMode;  
  
  JournalView(this._darkMode, this._toggleDarkMode);

  @override
  _JournalViewState createState() => _JournalViewState(_darkMode, _toggleDarkMode);
}

class _JournalViewState extends State<JournalView> {

  static const _drawerHeader = 'Settings';
  static const _headStyle = 'h1';
  static const _subheadStyle = 'h2';
  static const _toggleHeader = 'Dark Mode';
  static const _header = 'Journal Entries';
  final void Function() _toggleDarkMode;  

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _darkMode;
  Styles _styles;

  _JournalViewState(this._darkMode, this._toggleDarkMode) {
    _darkMode ? _styles = Styles('dark') : Styles('light');
    print('created journal view page object with theme: ${_styles.theme}');
  }

  Widget _orientedView(BuildContext context, BoxConstraints constraints) => constraints.maxWidth > 500 ? Horizontal() : Vertical();

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
                    print('set dark mode to: $_darkMode in drawer');
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          key: _scaffoldKey,
          endDrawer: _drawerContainer(),
          appBar: AppBar(
            leading: Container(),
            title: Center(child: _styles.formattedText(_header, 'h1')),
            actions: [ 
              IconButton(
                icon: Icon(Icons.settings, color: _styles.themeIconColors['settings']), 
                onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
              )
            ],
          ),
          body: LayoutBuilder(builder: _orientedView),
        );
      },
    );
  }
}

class OrientedView extends StatelessWidget {

  final _items = List<Map>.generate(100,(i){
    return {
      'title':'Item $i',
      'subtitle':'Subtitle for $i',
    };
  });

  Widget _journalListView;

  OrientedView() {
    _journalListView = ListView.builder(
      itemBuilder: (context,index){
        return ListTile(
          leading: Icon(Icons.star),
          trailing: Icon(Icons.pool),
          title: Text(_items[index]['title']),
          subtitle: Text(_items[index]['subtitle']),
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white);
  }
}

class Vertical extends OrientedView {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green[100], child: _journalListView);
  }
}

class Horizontal extends OrientedView {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.green[100],
            child: _journalListView
          )
        ),
        Expanded(
          child: Container(color: Colors.red[100])
        ),
      ],
    );
  }
}