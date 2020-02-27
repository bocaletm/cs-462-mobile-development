import 'package:flutter/material.dart';
import 'package:journal/styles/styles.dart';
import 'package:journal/models/journal_entry.dart';

class AddEntryView extends StatefulWidget {

  final bool _darkMode;
  final void Function() _toggleDarkMode;

  AddEntryView(this._darkMode,this._toggleDarkMode, {Key key}) : super(key: key);

  @override
  _AddEntryViewState createState() => _AddEntryViewState(_darkMode, _toggleDarkMode);
}

class _AddEntryViewState extends State<AddEntryView> {
  static const _iconName = 'settings';
  static const _title = 'New Journal Entry';
  static const _titleStyle = 'h1Alt';
  static const _drawerHeader = 'Settings';
  static const _headStyle = 'h1';
  static const _subheadStyle = 'h2';
  static const _toggleHeader = 'Dark Mode';

  final void Function() _toggleDarkMode;  

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _darkMode;

  Styles _styles;

  _AddEntryViewState(this._darkMode, this._toggleDarkMode) {
    _darkMode ? _styles = Styles('dark') : Styles('light');
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
    _darkMode ? _styles = Styles('dark') : _styles = Styles('light');
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
          body: FormBody( () => _darkMode ),
        );
      },
    );
  }
}

class FormBody extends StatefulWidget {

  final bool Function() _darkMode;

  FormBody(this._darkMode, {Key key}) : super(key: key);

  @override
  _FormBodyState createState() => _FormBodyState(_darkMode);
}

class _FormBodyState extends State<FormBody> {

  static const _emptyFieldMsg = 'Please enter some text';
  static const _notIntMsg = 'Rating must be an integer (1-10)';
  static const _titleLabel = 'Title';
  static const _bodyLabel = 'Body';
  static const _ratingLabel = 'Rating';
  static const _saveLabel = 'Save';
  static const _cancelLabel = 'Cancel';
  static const _submitMsg = 'Processing Data';
  static const _maxRating = 10;
  static const _minRating = 1;

  final _formKey = GlobalKey<FormState>();

  JournalEntry _entry = JournalEntry();

  final bool Function() _darkMode;

  Styles _styles;

  _FormBodyState(this._darkMode) {
    _darkMode() ? _styles = Styles('dark') : Styles('light');
  }

  String _validateEmpty(var value) {
    if (value.isEmpty) {
      return _emptyFieldMsg;
    } 
    return null;
  }

  String _validateInt(var value) {

    if (value.isEmpty) {
      return _emptyFieldMsg;
    } else if (int.tryParse(value) == null) {
      return _notIntMsg;
    } else if (int.parse(value) > _maxRating || int.parse(value) < _minRating) {
      return _notIntMsg;
    }
    return null;
  }

  Widget _buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(_submitMsg)));
              _formKey.currentState.save();
              _entry.date();
              _entry.printAll();
            }
          },
          child: _styles.formattedText(_saveLabel, 'h1Alt'),
          color: _styles.buttonColors['default'],
        ),
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: _styles.formattedText(_cancelLabel, 'h1Alt'),
          color: _styles.buttonColors['default'],
        )
      ],
    );
  }

  Widget _entryForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _styles.verticalPadding(MediaQuery.of(context).size.height * _styles.paddingFactor),
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: _titleLabel,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _validateEmpty(value),
                onSaved: (value) => _entry.title = value,
              ),
              _styles.verticalPadding(MediaQuery.of(context).size.height * _styles.paddingFactor),
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: _bodyLabel,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _validateEmpty(value),
                onSaved: (value) => _entry.body = value,
              ),
              _styles.verticalPadding(MediaQuery.of(context).size.height * _styles.paddingFactor),
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: _ratingLabel,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _validateInt(value),
                onSaved: (value) => _entry.rating = int.parse(value),
              ),
              _styles.verticalPadding(MediaQuery.of(context).size.height * _styles.paddingFactor),
              _buttons(context),
            ]
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _darkMode() ? _styles = Styles('dark') : _styles = Styles('light');
    return _entryForm(context);
  }
}