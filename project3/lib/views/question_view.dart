import 'dart:core';
import 'package:flutter/material.dart';
import 'formatting.dart' as format;
import 'package:project3/models/question.dart';


class QuestionView extends StatefulWidget {

  final Map<String,dynamic> _json;

  QuestionView(this._json, {Key key}) : super(key: key);

  @override
  _QuestionState createState() => new _QuestionState(_json);

}

class _QuestionState extends State {

  final Map<String,dynamic> _json;
  Question question;

  _QuestionState(this._json) {
    question = Question(_json);
  }


  List<Widget> layoutList(BuildContext context) {
    return [
      format.paragraphText(question.message),
    ];
  }

  Widget display(BuildContext context) => format.paginate(layoutList(context));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
            question.rotateText();
        });
      },
      child: display(context),
    );
  }
}