import 'package:flutter/material.dart';
import 'package:project3/business_card.dart';
import 'package:project3/question.dart';
import 'package:project3/resume.dart';
import 'formatting.dart' as format;

class App extends StatefulWidget {

  final String title;

  App(this.title);

  @override
  AppState createState() => AppState(title);
}

class AppState extends State<App> {

  final String title;

  AppState(this.title);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: format.tabbedAppbar(title: title, widgetList: [
          Icon(Icons.face),
          Icon(Icons.event_note),
          Icon(Icons.help_outline),
        ]),
        body: FutureBuilder (
          future: DefaultAssetBundle.of(context).loadString('assets/businessCard.json'),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            print('Read json data: \n ${snapshot.data}');
            var businessCard = BusinessCard(snapshot.data);
            var resume = Resume();
            var question = Question();
            return format.tabViews(businessCard, resume, question);
          }
        ),
      ),
    );
  }
}
