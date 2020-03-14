import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ImageProc {
  
  static const String cacheKey = 'CACHED_IMAGE_KEY';

  static Future<bool> cacheImage(String imageValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(cacheKey, imageValue);
  }

  static Future<String> loadImageFromCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(cacheKey);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Image imgFromBase64(String base64Str) {
    return Image.memory(
      base64Decode(base64Str),
      fit: BoxFit.fill,
    );
  }
}
