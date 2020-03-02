import 'package:intl/intl.dart';

class JournalEntry {
  final DateFormat _dateFormat = DateFormat("EEEE, MMMM d, yyyy");
  int _id = -1;
  String _title;
  String _body;
  int _rating;
  String _dateString;

  set id(int value) => _id = value;
  set title(String value) => _title = value;
  set body(String value) => _body = value;
  set rating(int value) => _rating = value;
  set dateString(String value) => _dateString = value;

  get id => _id;
  get title => _title;
  get body => _body;
  get rating => _rating;
  get dateString => _dateString;

  void date(){
    _dateString = _dateFormat.format(DateTime.now());
  }

  void printAll() {
    print('$_id');
    print('$_title');
    print('$_body');
    print('$_rating');
    print('$_dateString');
  }
}