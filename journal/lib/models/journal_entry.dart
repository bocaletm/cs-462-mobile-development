import 'package:intl/intl.dart';

class JournalEntry {
  final DateFormat _dateFormat = DateFormat("EEEE, MMMM d, yyyy");
  String _title;
  String _body;
  int _rating;
  DateTime _date;
  String _dateString;

  set title(String value) => _title = value;
  set body(String value) => _body = value;
  set rating(int value) => _rating = value;

  void date(){
    _date = DateTime.now();
    _dateString = _dateFormat.format(_date);
  }

  void printAll() {
    print('$_title');
    print('$_body');
    print('$_rating');
    print('$_dateString');
  }
}