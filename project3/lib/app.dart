import 'dart:convert';
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
          future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var json = jsonDecode(snapshot.data);
            print('Read json data: \n\n ${json}');
            var businessCard = BusinessCard(json['businessCard']);
            var resume = Resume(json['resume']);
            var question = Question(json['answers']);
            return format.tabViews(context, businessCard, resume, question);
          }
        ),
      ),
    );
  }
}