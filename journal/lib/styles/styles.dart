import 'package:flutter/material.dart';

class Styles {
  static const _paddingFactor = 0.03;
  static const _drawerFactor = 0.45;

  static const _textColorDark = {
    'h1Alt': Colors.white,
    'h1': Colors.white70,
    'h2': Colors.white70,
    'p': Colors.white70,
  };

  static const _iconColorDark = {
    'settings': Colors.white,
    'note': Colors.white,
  };

  static const _textColorLight = {
    'h1Alt': Colors.white,
    'h1': Colors.black,
    'h2': Colors.black,
    'p': Colors.black
  };
  
  static const _iconColorLight = {
    'settings': Colors.white,
    'note': Colors.black,
  };

  static const _buttonColorDark = {
    'default': Colors.teal,
  };

  static const _buttonColorLight = {
    'default': Colors.blue,
  };

  static const _iconSizes = {
    'settings': 20.0,
    'note': 50.0,
  };

  static const _textSizes = {
    'h1': 20.0,
    'h2': 16.0,
    'p': 12.0,
  };

  var _themeButtonColors;
  var _themeIconColors;
  var _themeTextColors;
  final String _theme;
  get theme => _theme;

  Styles(this._theme) {
    _themeIconColors = _theme.contains('dark') ? _iconColorDark : _iconColorLight;
    _themeTextColors = _theme.contains('dark') ? _textColorDark : _textColorLight;
    _themeButtonColors = _theme.contains('dark') ? _buttonColorDark : _buttonColorLight;
  }

  get themeIconColors => _themeIconColors;
  get themeTextColor => _themeTextColors;
  get textSizes => _textSizes;
  get iconSizes => _iconSizes;
  get drawerFactor => _drawerFactor;
  get paddingFactor => _paddingFactor;
  get buttonColors => _themeButtonColors;

  Widget formattedText(String text, String style){
    return Text(
      text,
      style: TextStyle(fontSize: textSizes[style], color: _themeTextColors[style])
    );
  }

  Widget verticalPadding(double val) {
    return SizedBox(height: val);
  }
}