import 'package:flutter/material.dart';
import 'package:project3/models/business_card.dart';
import 'formatting.dart' as format;

class BusinessCardView {

  final Map<String,dynamic> _json;
  BusinessCard _card;

  BusinessCardView(this._json) {
    _card = BusinessCard(_json);
  }
  
  Widget formattedPhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        _card.imgUrl,
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
          Center(child: format.headerText(_card.name)),
          Center(child: format.paragraphText(_card.title)),
          Center(
            child: InkWell(
              child: format.paragraphText(_card.phoneNumber),
              onTap: () { _card.msg.sendSms(_card.phoneNumber); },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Column(children: [
              InkWell(
                onTap: () async { 
                  try { 
                    await _card.msg.launchURL(_card.websiteUrl);
                  } catch(e) {
                    print(e);
                  }
                },
                child: format.footerText(_card.websiteUrl)
              )
            ]),
            Column(children: [
              format.footerText(_card.email)
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