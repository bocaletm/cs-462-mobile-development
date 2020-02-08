import 'dart:io';
import 'package:flutter/material.dart';
import 'formatting.dart' as format;
import 'messaging.dart';

class BusinessCard {

  final Map<String,dynamic> _json;
  MessagingService _msg;
  String _name;
  String _title;
  String _phoneNumber;
  String _websiteUrl;
  String _email;
  String _imgUrl;
  bool complete = false;

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
    complete = true;
  }
  
  Widget formattedPhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        this._imgUrl,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, progress) {
          return progress == null
            ? child
            : RefreshProgressIndicator();
          }
        ),
    );
  }

  Widget display() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        SizedBox(
          child: formattedPhoto(),
          height: 75, width: 75
        ),
        format.headerText(this._name),
        format.paragraphText(this._title),
        InkWell(
          child: format.paragraphText(this._phoneNumber),
          onTap: () { _msg.sendSms(_phoneNumber); },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Column(children: [
            InkWell(
              onTap: () async { 
                try { 
                  await _msg.launchURL(_websiteUrl);
                } catch(e) {
                  print(e);
                }
              },
              child: format.footerText(this._websiteUrl)
            )
          ]),
          Column(children: [
            format.footerText(this._email)
          ])
        ]),
      ],
    );
  }
}