import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'formatting.dart' as format;
import 'messaging.dart';

class BusinessCard {

  final String json;
  MessagingService msg;
  String name;
  String title;
  String phoneNumber;
  String websiteUrl;
  String email;
  String imgUrl;
  bool complete = false;

  BusinessCard(this.json) {
    var jsonParsed;
    try {
      this.msg = MessagingService();
      jsonParsed = convert.jsonDecode(this.json);
      this.name = jsonParsed['name'];
      this.title = jsonParsed['title'];
      this.phoneNumber = jsonParsed['phoneNumber'];
      this.websiteUrl = jsonParsed['websiteUrl'];
      this.email = jsonParsed['email'];
      this.imgUrl = jsonParsed['imgUrl'];
    } catch(e) {
      stderr.write('ERROR: Could not parse json:\n\n$json\n\n');
    }
    complete = true;
  }
  
  Widget formattedPhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        this.imgUrl,
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
        format.headerText(this.name),
        format.paragraphText(this.title),
        InkWell(
          child: format.paragraphText(this.phoneNumber),
          onTap: () { msg.sendSms(phoneNumber); },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Column(children: [
            InkWell(
              onTap: () async { 
                try { 
                  await msg.launchURL(websiteUrl);
                } catch(e) {
                  print(e);
                }
              },
              child: format.footerText(this.websiteUrl)
            )
          ]),
          Column(children: [
            format.footerText(this.email)
          ])
        ]),
      ],
    );
  }
}