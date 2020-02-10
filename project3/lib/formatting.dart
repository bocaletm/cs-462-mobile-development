import 'package:flutter/material.dart';
import 'package:project3/business_card.dart';
import 'package:project3/resume.dart';
import 'package:project3/question.dart';
import 'package:project3/draw_triangle.dart';

Widget paragraphText(String text) {
  return Text(
      text,
      style: TextStyle(
        height: 1.5,
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.green
      ),
  );
}

Widget headerText(String text) {
  return Text(
          text,
          style: TextStyle(
            height: 2,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green
          ),
        );
}

Widget subHeadText(String text) {
  return Text(
          text,
          style: TextStyle(
            height: 1,
            fontSize: 20,
            color: Colors.green
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
            color: Colors.green
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
    height: 0,
    thickness: 2
  );
}

Widget paddedHeaderRow(String text) {
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: headerText(text)
      )
    ]
  );
}

Widget paginate(List<Widget> displayList) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: displayList
          ),
        ),
      );
    },
  );
}

Widget stackFiller() {
  return Stack(
    children: <Widget>[
      Container(
        width: 400,
        height: 180,
        color: Colors.teal,
      ),
      Positioned(
        top: 20,
        child: Container(
          width: 400,
          height: 135,
          color: Colors.yellow[100],
        ),
      ),
      Positioned(
        bottom: 80,
        right: 30,
        child: Container(
          child: CustomPaint(
            size: Size(50, 50),
            painter: DrawTriangle(Colors.red[200])
          ),
        ),
      ),
      Positioned(
        bottom: 80,
        right: 105,
        child: Container(
          child: CustomPaint(
            size: Size(50, 50),
            painter: DrawTriangle(Colors.red[200])
          ),
        ),
      ),
      Positioned(
        bottom: 80,
        right: 180,
        child: Container(
          child: CustomPaint(
            size: Size(50, 50),
            painter: DrawTriangle(Colors.red[200])
          ),
        ),
      ),
      Positioned(
        bottom: 80,
        right: 255,
        child: Container(
          child: CustomPaint(
            size: Size(50, 50),
            painter: DrawTriangle(Colors.red[200])
          ),
        ),
      ),
      Positioned(
        bottom: 80,
        right: 330,
        child: Container(
          child: CustomPaint(
            size: Size(50, 50),
            painter: DrawTriangle(Colors.red[200])
          ),
        ),
      ),
//bottom row
      Positioned(
        bottom: 50,
        right: 69,
        child: Container(
          child: CustomPaint(
            size: Size(50, 50),
            painter: DrawTriangle(Colors.red[200])
          ),
        ),
      ),
      Positioned(
        bottom: 50,
        right: 144,
        child: Container(
          child: CustomPaint(
            size: Size(50, 50),
            painter: DrawTriangle(Colors.red[200])
          ),
        ),
      ),
      Positioned(
        bottom: 50,
        right: 218,
        child: Container(
          child: CustomPaint(
            size: Size(50, 50),
            painter: DrawTriangle(Colors.red[200])
          ),
        ),
      ),
      Positioned(
        bottom: 50,
        right: 293,
        child: Container(
          child: CustomPaint(
            size: Size(50, 50),
            painter: DrawTriangle(Colors.red[200])
          ),
        ),
      ),
    ],
  );
}