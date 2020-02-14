import 'dart:io';
import 'package:flutter/material.dart';
import 'formatting.dart' as format;
import '../messaging.dart';

class BusinessCardView {

  final Map<String,dynamic> _json;
  MessagingService _msg;
  String _name;
  String _title;
  String _phoneNumber;
  String _websiteUrl;
  String _email;
  String _imgUrl;
  bool complete = false;

  BusinessCardView(this._json) {
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
        _imgUrl,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, progress) {
          return progress == null
            ? child
            : RefreshProgressIndicator();
          }
        ),
    );
  }

  Widget cardWithPicture() {
    return Container(
      color: Colors.black87,
      child: Column(
        children: [
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: SizedBox(
              child: formattedPhoto(),
              height: 75, width: 75
            ),
          ),
          Center(child: format.headerText(_name)),
          Center(child: format.paragraphText(_title)),
          Center(
            child: InkWell(
              child: format.paragraphText(_phoneNumber),
              onTap: () { _msg.sendSms(_phoneNumber); },
            ),
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
                child: format.footerText(_websiteUrl)
              )
            ]),
            Column(children: [
              format.footerText(_email)
            ]),
          ]),
          SizedBox(
            height: 30.0,
          ),        ]
      )
    );
  }

  Widget display(BuildContext context) => format.paginate(layoutList(context));

  List<Widget> layoutList(BuildContext context) {
    return [
      Center(child: format.stackFiller(context)),
      cardWithPicture(),
      Center(child: format.stackFiller(context)),
    ];
  }
}