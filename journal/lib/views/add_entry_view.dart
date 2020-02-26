import 'package:flutter/material.dart';
import 'package:journal/styles/styles.dart';
import 'package:journal/models/journal_entry.dart';

class AddEntryView extends StatefulWidget {

  @override
  _AddEntryViewState createState() => _AddEntryViewState();
}

class _AddEntryViewState extends State<AddEntryView> {
  static const _iconName = 'settings';
  static const _title = 'New Journal Entry';
  static const _style = 'h1';
  final Styles _styles = Styles('dark');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          key: _scaffoldKey,
          endDrawer: Container(child: Drawer(), width: MediaQuery.of(context).size.width * _styles.drawerFactor),
          appBar: AppBar(
            title: Center(child: _styles.formattedText(_title,_style)),
            actions: [ 
              IconButton(
                icon: Icon(Icons.settings, color: _styles.themeIconColors[_iconName]), 
                onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
              )
            ],
          ),
          body: FormBody(),
        );
      },
    );
  }
}

class FormBody extends StatefulWidget {

  @override
  _FormBodyState createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {

  final Styles _styles = Styles('dark');
  static const _emptyFieldMsg = 'Please enter some text';
  static const _notIntMsg = 'Rating must be an integer (1-10)';
  static const _titleLabel = 'Title';
  static const _bodyLabel = 'Body';
  static const _ratingLabel = 'Rating';
  static const _saveLabel = 'Save';
  static const _submitMsg = 'Processing Data';
  static const _maxRating = 10;
  static const _minRating = 1;

  final _formKey = GlobalKey<FormState>();

  JournalEntry _entry = JournalEntry();

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

  Widget _entryForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text(_submitMsg)));
                    _formKey.currentState.save();
                    _entry.date();
                    _entry.printAll();
                  }
                },
                child: Text(_saveLabel),
              )
            ]
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _entryForm(context);
  }
}