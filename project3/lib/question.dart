import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'formatting.dart' as format;


class Question extends StatefulWidget {

  final Map<String,dynamic> _json;

  Question(this._json, {Key key}) : super(key: key);

  @override
  _QuestionState createState() => new _QuestionState(_json);

}

class _QuestionState extends State {

  _QuestionState(this._json) {
    _max = _json.length + 1;
    _randomizer = Random(DateTime.now().millisecondsSinceEpoch);
  }

  final Map<String,dynamic> _json;
  Random _randomizer;
  static const int _min = 1;
  int _max;
  String _message = 'Tap here for your prediction!';

  String randomNumString() {
    return (_min + _randomizer.nextInt(_max - _min)).toString();
  }

  List<Widget> layoutList(BuildContext context) {
    return [
      format.paragraphText(_message),
    ];
  }

  void _rotateText() {
    _message = _json[randomNumString()];
  }

  Widget display(BuildContext context) => format.paginate(layoutList(context));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
            _rotateText();
        });
      },
      child: display(context),
    );
  }
}