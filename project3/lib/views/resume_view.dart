import 'package:flutter/material.dart';
import 'package:project3/models/resume.dart';
import 'formatting.dart' as format;

class ResumeView {

  final Map<String,dynamic> _json;
  Resume _resume;

  ResumeView(this._json) {
    _resume = Resume(_json);
  }

  Widget _printHeader() {
    return Center(
      child: Column (children: [
        format.headerText(_resume.name),
        format.paragraphText(_resume.email),
        format.paragraphText(_resume.phoneNumber),
      ]),
    );
  }

Widget _printExperience() {
    List<Widget> columnList= [];

    _resume.experience.forEach((exp) {
      columnList.add(format.headerText(exp.title));
      columnList.add(format.subHeadText(exp.employer));
      columnList.add(format.paragraphText(exp.dates));
      columnList.add(format.paragraphText(exp.description));
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
    List<Widget> columnList= [];
    _resume.education.forEach((edu) {
      columnList.add(format.headerText(edu.degree));
      columnList.add(format.subHeadText(edu.institution));
      columnList.add(format.paragraphText(edu.dates));
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
        child: format.paddedHeaderRow(_resume.eduHeader),
        color: Colors.black87,
        height: 50,
      ),
      Container(
        child: _printEducation(),
        color: Colors.black87,
        height: 88.0 * _resume.educationCount,
      ),
      format.formattedDivider(),
      Container(
        child: format.paddedHeaderRow(_resume.expHeader),
        color: Colors.black87,
        height: 50,
      ),
      Container(
        child: _printExperience(),
        color: Colors.black87, 
        height: 150.0 * _resume.experienceCount,
      ),
    ];
  }

  Widget display() => format.paginate(_layoutList());

}