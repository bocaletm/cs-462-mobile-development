import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'formatting.dart' as format;


class Question {

  final Map<String,dynamic> _json;
  static const int _min = 1;
  Random _randomizer;
  int _max;

  Question(this._json) {
    _max = _json.length;
    var epoch = DateTime.now().millisecondsSinceEpoch;
    _randomizer = Random(epoch);
  }

  String randomNumString() {
    return _randomizer.nextInt(_max).toString();
  }

  Widget display() {
    return Text(_json[randomNumString()]);
  }
}
