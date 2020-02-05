import 'package:flutter/material.dart';

class CenteredPlaceholder extends StatelessWidget {
  
  final double padding;

  const CenteredPlaceholder({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Placeholder(),
        )
      );
  }
}