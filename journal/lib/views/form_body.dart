import 'package:flutter/material.dart';
import 'package:journal/styles/styles.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/models/journal.dart';


class FormBody extends StatefulWidget {

  final bool Function() _darkMode;

  final Journal _journal;

  FormBody(this._darkMode, this._journal, {Key key}) : super(key: key);

  @override
  _FormBodyState createState() => _FormBodyState(_darkMode, _journal);
}

class _FormBodyState extends State<FormBody> {

  static const _emptyFieldMsg = 'Please enter some text';
  static const _notIntMsg = 'Rating must be an integer (1-10)';
  static const _titleLabel = 'Title';
  static const _bodyLabel = 'Body';
  static const _ratingLabel = 'Rating';
  static const _saveLabel = 'Save';
  static const _cancelLabel = 'Cancel';
  static const _saveSuccess = 'Entry Saved';
  static const _saveFailure = 'Error Saving Entry';
  static const _maxRating = 4;
  static const _minRating = 1;

  final _formKey = GlobalKey<FormState>();

  JournalEntry _entry = JournalEntry();

  final bool Function() _darkMode;

  final Journal _journal;

  Styles _styles;

  String _submitMsg = '';

  _FormBodyState(this._darkMode, this._journal) {
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
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _entry.date();
              int id = await _journal.addEntry(_entry);
              id > 0 ? _submitMsg = _saveSuccess : _submitMsg = _saveFailure;
              Navigator.pop(context, _submitMsg);
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