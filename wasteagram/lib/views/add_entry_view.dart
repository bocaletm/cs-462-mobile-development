import 'package:flutter/material.dart';
import 'package:wasteagram/views/form_body.dart';
import 'package:wasteagram/post_controller.dart';


class AddEntryView extends StatefulWidget {

  AddEntryView(this._postController, {Key key}) : super(key: key);

  PostController _postController;

  @override
  _AddEntryViewState createState() => _AddEntryViewState();
}

class _AddEntryViewState extends State<AddEntryView> {

  static const _title = 'New Post';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text(_title)),
          ),
          body: FormBody(widget._postController),
        );
      },
    );
  }
}