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