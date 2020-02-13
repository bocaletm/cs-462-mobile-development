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

Widget tabViews(BuildContext context, BusinessCard businessCard, Resume resume, Question question) {
  return TabBarView(
    children: <Widget> [
      businessCard?.display(context),
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

List<Widget> generateBanner(double width, int topRow, int bottomRow) {
  var widgetList = [
    Container(
        width: width,
        height: 180,
        color: Colors.teal,
      ),
      Positioned(
        top: 20,
        child: Container(
          width: width,
          height: 135,
          color: Colors.yellow[100],
        ),
      ),
  ];
  var spaceFromRight = 0.0;
  for (int i = 0; i <= topRow; i++) {
    widgetList.add(Positioned(
        top: 40,
        right: spaceFromRight,
        child: Container(
          child: CustomPaint(
            size: Size(50, 50),
            painter: DrawTriangle(Colors.red[200])
          ),
        ),
      )
    );
    spaceFromRight += 60;
  }
  
  spaceFromRight = 30.0;
  for (int i = 0; i <= bottomRow; i++) {
    widgetList.add(Positioned(
        bottom: 40,
        right: spaceFromRight,
        child: Container(
          child: CustomPaint(
            size: Size(50, 50),
            painter: DrawTriangle(Colors.red[200])
          ),
        ),
      )
    );
   spaceFromRight += 60;
  }
  return widgetList;
}

Widget stackFiller(BuildContext context) {
  return Stack(
    children: generateBanner((MediaQuery.of(context).size.width - 1), 16, 16),
  );
}