import 'package:flutter/material.dart';
import 'package:project3/business_card.dart';
import 'package:project3/resume.dart';
import 'package:project3/question.dart';

Widget paragraphText(String text) {
  return Text(
          text,
          style: TextStyle(
            height: 1.5,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
      );
}

Widget headerText(String text) {
  return Text(
          text,
          style: TextStyle(
            height: 3,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        );
}

Widget footerText(String text) {
  return Text(
          text,
          style: TextStyle(
            height: 2,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        );
}

Widget tabViews(BusinessCard businessCard, Resume resume, Question question) {
  return TabBarView(
    children: <Widget> [
      businessCard?.display(),
      resume?.display(),
      question?.display(),
    ],
  );
}

Widget tabbedAppbar({String title, List<Widget> widgetList}) {
  return AppBar( 
    title: Center(child: Text(title)),
    bottom: TabBar(
      tabs: widgetList
    ),
  );
}

Widget formattedDivider() {
  return Divider(
    color: Colors.grey,
    height: 20,
    thickness: 2
  );
}
