import 'package:flutter/material.dart';
import 'package:wasteagram/post_controller.dart';

class FormBody extends StatefulWidget {

  FormBody(this._postController, {Key key}) : super(key: key);

  PostController _postController;

  @override
  _FormBodyState createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {

  static const _emptyFieldMsg = 'Please enter the count of items here';
  static const _notIntMsg = 'Please enter intems (1-1000)';
  static const _ratingLabel = 'Item Count';
  static const _saveLabel = 'Save';
  static const _cancelLabel = 'Cancel';
  static const _saveSuccess = 'Post Saved';
  static const _saveFailure = 'Error Saving Post';
  static const _maxCount = 1000;
  static const _minCount = 1;

  final _formKey = GlobalKey<FormState>();

  String _submitMsg = '';

  String _validateInt(var value) {

    if (value.isEmpty) {
      return _emptyFieldMsg;
    } else if (int.tryParse(value) == null) {
      return _notIntMsg;
    } else if (int.parse(value) > _maxCount || int.parse(value) < _minCount) {
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
              int id = 0;
              id > 0 ? _submitMsg = _saveSuccess : _submitMsg = _saveFailure;
              Navigator.pop(context, _submitMsg);
            }
          },
          child: Text(_saveLabel),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(_cancelLabel),
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
              Divider(),
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: _ratingLabel,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _validateInt(value),
                onSaved: (value) => print(value),
              ),
              Divider(),
              _buttons(context),
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