import 'package:flutter/material.dart';
import 'package:journal/styles/styles.dart';
import 'package:journal/views/add_entry_view.dart';

class Welcome extends StatefulWidget {

  final Styles Function() _getStyles;
  final void Function() _toggleDarkMode;  

  Welcome(this._getStyles, this._toggleDarkMode, {Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState(_getStyles, _toggleDarkMode);
}

class _WelcomeState extends State<Welcome> {

  static const _drawerHeader = 'Settings';
  static const _titleStyle = 'h1Alt';
  static const _headStyle = 'h1';
  static const _subheadStyle = 'h2';
  static const _subtitle = 'Journal';
  static const _title = 'Welcome';
  static const _toggleHeader = 'Dark Mode';
  static const _iconName = 'settings';
 
  final void Function() _toggleDarkMode;  
  final Styles Function() _getStyles;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Styles _styles;
  bool _darkMode;

  _WelcomeState(this._getStyles, this._toggleDarkMode) {
    _styles = _getStyles();
    _darkMode = _styles.theme == 'dark' ? true : false;
  }
  
  Widget _centerIcon() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
            _styles.formattedText(_subtitle,_headStyle),
            Icon(
              Icons.class_, 
              color: _styles.themeIconColors['note'], 
              size: _styles.iconSizes['note']
            )
          ]
        ),
      ),
    );
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
          body: _centerIcon(),
          floatingActionButtonAnimator: null,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddEntryView(_getStyles,_toggleDarkMode))),
          ),
        );
      },
    );
  }
}