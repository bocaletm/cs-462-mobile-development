import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project3/views/business_card_view.dart';
import 'package:project3/views/question_view.dart';
import 'package:project3/views/resume_view.dart';
import 'views/formatting.dart' as format;

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
          future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var json = jsonDecode(snapshot.data);
            print('Read json data: \n\n ${json}');
            var businessCardView = BusinessCardView(json['businessCard']);
            var resumeView = ResumeView(json['resume']);
            var questionView = QuestionView(json['answers']);
            return format.tabViews(context, businessCardView, resumeView, questionView);
          }
        ),
      ),
    );
  }
}