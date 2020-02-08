import 'package:flutter/material.dart';
import 'formatting.dart' as format;

class Resume {

  final Map<String,dynamic> _json;

  Resume(this._json);

  Widget display() {
        return Column(
      children: <Widget>[
        SizedBox(
          height: 5.0,
        ),
        format.headerText(_json['name']),
        format.paragraphText(_json['phoneNumber']),
        format.paragraphText(_json['email']),
        format.formattedDivider()
      ],
    );
  }
}
