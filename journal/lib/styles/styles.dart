import 'package:flutter/material.dart';

class Styles {
  static const _textColorDark = {
    'h1': Colors.white,
    'h2': Colors.white,
    'p': Colors.white
  };

  static const _iconColorDark = {
    'settings': Colors.white,
    'note': Colors.white,
  };

  static const _textColorLight = {
    'h1': Colors.black,
    'h2': Colors.black,
    'p': Colors.black
  };
  
  static const _iconColorLight = {
    'settings': Colors.black,
    'note': Colors.black,
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

  var _themeIconColors;
  var _themeTextColors;
  final String _theme;

  Styles(this._theme) {
    _themeIconColors = _theme.contains('dark') ? _iconColorDark : _iconColorLight;
    _themeTextColors = _theme.contains('dark') ? _textColorDark : _textColorLight;
  }

  get themeIconColors => _themeIconColors;
  get themeTextColor => _themeTextColors;
  get textSizes => _textSizes;
  get iconSizes => _iconSizes;

  Widget formattedText(String text, String style){
    return Text(
      text,
      style: TextStyle(fontSize: textSizes[style], color: _themeTextColors[style])
    );
  }

  Widget verticalPadding() {
    return SizedBox(height: 10);
  }
}