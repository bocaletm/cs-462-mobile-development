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

  static const String _header = 'Call me... Maybe?';
  static const String _instruction = 'Ask a question. Tap for the answer';
  final Map<String,dynamic> _json;
  Question question;

  _QuestionState(this._json) {
    question = Question(_json);
  }


  List<Widget> layoutList(BuildContext context) {
    return [
      Center(child: format.stackFiller(context)),
      Container(
        color: Colors.black87,
        width: MediaQuery.of(context).size.width,
        child: Column(     
          children: [
            SizedBox(height: 75.0),
            format.headerText(_header),
            format.footerText(_instruction),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: format.headerText(question.message),
            ),
            SizedBox(height: 75.0),
          ]),
      ),
      Center(child: format.stackFiller(context)),
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