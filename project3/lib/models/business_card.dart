import 'dart:io';
import '../messaging.dart';

class BusinessCard {

  final Map<String,dynamic> _json;
  MessagingService _msg;
  String _name;
  String _title;
  String _phoneNumber;
  String _websiteUrl;
  String _email;
  String _imgUrl;

  BusinessCard(this._json) {
    try {
      _msg = MessagingService();
      _name = _json['name'];
      _title = _json['title'];
      _phoneNumber = _json['phoneNumber'];
      _websiteUrl = _json['websiteUrl'];
      _email = _json['email'];
      _imgUrl = _json['imgUrl'];
    } catch(e) {
      stderr.write('ERROR: Could not parse json:\n\n$_json\n\n');
    }
  }

  get name => _name;
  get msg => _msg;
  get title => _title;
  get websiteUrl => _websiteUrl;
  get phoneNumber => _phoneNumber;
  get email => _email;
  get imgUrl => _imgUrl;

}