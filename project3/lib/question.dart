import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'formatting.dart' as format;


class Question {
  final Map<String,dynamic> _json;
  final int _min = 1;
  int _max;

  Question(this._json) {
    _max = _json.length;
  }

  String randomNumString() {
    var epoch = DateTime.now().millisecondsSinceEpoch;
    Random randomizer = Random(epoch);
    return randomizer.nextInt(_max).toString();
  }

  Widget display() {
    return Text(_json[randomNumString()]);
  }
}
