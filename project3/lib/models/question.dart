import 'dart:math';

class Question {

  static const int _min = 1;
  final Map<String,dynamic> _json;
  Random _randomizer;
  int _max;
  String _message = '';

  Question(this._json) {
    _max = _json.length + 1;
    _randomizer = Random(DateTime.now().millisecondsSinceEpoch);
  }

  get message => _message;

  String _randomNumString() {
    return (_min + _randomizer.nextInt(_max - _min)).toString();
  }

  void rotateText() {
    _message = _json[_randomNumString()];
  }
}