//Source: Class based on seven.srikanth https://fluttercentral.com/Articles/Post/1154
import 'package:flutter/material.dart';

class DrawTriangle extends CustomPainter {

  Paint _paint;

  DrawTriangle(var color) {
    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }
  
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width/2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}