import 'package:project3/models/education.dart';
import 'package:project3/models/experience.dart';

class Resume {

  static const String _eduHeader = 'EDUCATION';
  static const String _expHeader = 'EXPERIENCE';
  final Map<String,dynamic> _json;
  String _name;
  String _phoneNumber;
  String _email;
  List<Experience> _experience;
  List<Education> _education;
  int _educationCount;
  int _experienceCount;

  get eduHeader => _eduHeader;
  get expHeader => _expHeader;
  get name => _name;
  get phoneNumber => _phoneNumber;
  get email => _email;
  get experience => _experience;
  get education => _education;
  get educationCount => _educationCount;
  get experienceCount => _experienceCount;

  Resume(this._json) {
    _name = _json['name'];
    _phoneNumber = _json['phoneNumber'];
    _email = _json['email'];
    _educationCount = _json['education'].length;
    _experienceCount = _json['experience'].length;
    _education = new List();
    _experience = new List();

    var idx = 1;
    _json['education'].forEach((edu) {
      var entry = edu['${idx.toString()}'];
      print(entry);
      _education.add(Education(entry[0]['degree'], entry[1]['institution'], entry[2]['dates']));
      idx++;
    });

    idx = 1;
    _json['experience'].forEach((exp) {
      var entry = exp['${idx.toString()}'];
      print(entry);
      _experience.add(Experience(entry[0]['title'], entry[1]['employer'], entry[2]['description'],entry[3]['dates']));
      idx++;
    });
  }
}