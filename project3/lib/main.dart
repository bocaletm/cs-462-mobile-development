import 'package:flutter/material.dart';
import 'helpers.dart' as help;

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Me Maybe',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: help.tabbedAppbar(widgetList: [
            Icon(Icons.face),
            Icon(Icons.event_note),
            Icon(Icons.help_outline),
          ]),
          body: help.tabViews()
        ),
      ),
    );
  }
}
