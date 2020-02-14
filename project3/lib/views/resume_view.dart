import 'package:flutter/material.dart';
import 'formatting.dart' as format;

class ResumeView {

  final Map<String,dynamic> _json;
  int _experienceCount;
  int _educationCount;

  ResumeView(this._json) {
    _educationCount = _json['education'].length;
    _experienceCount = _json['experience'].length;
  }

  Widget _printHeader() {
    return Center(
      child: Column (children: [
        format.headerText(_json['name']),
        format.paragraphText(_json['phoneNumber']),
        format.paragraphText(_json['email']),
      ]),
    );
  }

Widget _printExperience() {
    var experience = _json['experience'];
    var idx = 1;
    List<Widget> columnList= [];
    experience.forEach((exp) {
      print('Processing experience');
      print(exp);
      var entry = exp['${idx.toString()}'];
      print(entry);
      String title = entry[0]['title'];
      String employer = entry[1]['employer'];
      String desc = entry[2]['description'];
      String dates = entry[3]['dates'];

      columnList.add(format.headerText(title));
      columnList.add(format.subHeadText(employer));
      columnList.add(format.paragraphText(dates));
      columnList.add(format.paragraphText(desc));
      idx++;
    });

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnList,
        ),
        alignment: Alignment.topLeft,
      ),
    );
  }

  Widget _printEducation() {
    var education = _json['education'];
    var idx = 1;
    List<Widget> columnList= [];
    education.forEach((edu) {
      print('Processing education');
      print(edu);
      var entry = edu['${idx.toString()}'];
      print(entry);
      String degree = entry[0]['degree'];
      String uni = entry[1]['university'];
      String year = entry[2]['year'];
      columnList.add(format.headerText(degree));
      columnList.add(format.subHeadText(uni));
      columnList.add(format.paragraphText(year));
      idx++;
    });

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnList,
        ),
        alignment: Alignment.topLeft,
      ),
    );
  }

  List <Widget> _layoutList() {
    return [
      Container(
        child: _printHeader(),
        color: Colors.black87,
        height: 110.0,
      ),
      format.formattedDivider(),
      Container(
        child: format.paddedHeaderRow('EDUCATION'),
        color: Colors.black87,
        height: 50,
      ),
      Container(
        child: _printEducation(),
        color: Colors.black87,
        height: 88.0 * _educationCount,
      ),
      format.formattedDivider(),
      Container(
        child: format.paddedHeaderRow('EXPERIENCE'),
        color: Colors.black87,
        height: 50,
      ),
      Container(
        child: _printExperience(),
        color: Colors.black87, 
        height: 150.0 * _experienceCount,
      ),
    ];
  }

  Widget display() => format.paginate(_layoutList());

}