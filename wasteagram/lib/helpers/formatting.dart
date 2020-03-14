import 'package:flutter/material.dart';

Widget formattedPhoto(String url) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Image.network(
      url,
      fit: BoxFit.fill,
      loadingBuilder: (context, child, progress) {
        return progress == null
          ? child
          : Center(child: Text('loading...'));
        }
      ),
  );
}

Color snackbarColorFromValue(result) {
  var color;
  result.toLowerCase().contains('error') ? color =  Colors.red : color = Colors.green;
  return color;
}