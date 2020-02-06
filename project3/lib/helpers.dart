import 'package:flutter/material.dart';

Widget businessCard() {
  return Column(
    children: <Widget>[
      SizedBox(
         height: 50.0,
       ),
      SizedBox(
        child: Placeholder(),
        height: 50, width: 50
      ),
      headerText('Mario Bocaletti'),
      paragraphText('St. Infrastructure Architect'),
      paragraphText('504-756-1818'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Column(children: [footerText('github.com/bocaletm')]),
        Column(children: [footerText('bocalettirocco@gmail.com')])
      ]),
    ],
  );
}

Widget paragraphText(String text) {
  return Text(
          text,
          style: TextStyle(
            height: 2,
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

Widget resume() {
  return Text('note');
}

Widget question() {
  return Text('?');
}
Widget tabViews() {
  return TabBarView(
    children: <Widget> [
      businessCard(),
      resume(),
      question(),
    ],
  );
}

Widget tabbedAppbar({String title, List<Widget> widgetList}) {
  return AppBar( 
    title: Center(child: Text("Call Me Maybe")),
    bottom: TabBar(
      tabs: widgetList
    ),
  );
}
