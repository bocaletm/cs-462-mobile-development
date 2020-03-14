import 'dart:io';
import 'package:path_provider/path_provider.dart';
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

  static Uint8List dataFromBase64(String base64Str) {
    return base64Decode(base64Str);
  }

  static Image imgFromBase64(String base64Str) {
    return Image.memory(
      base64Decode(base64Str),
      fit: BoxFit.fill,
    );
  }

  static Future<File> imageFileFromData(Uint8List data) async {
    final file = File('${(await getTemporaryDirectory()).path}/temp');
    return file.writeAsBytes(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

}
