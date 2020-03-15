import 'package:flutter/material.dart';
import 'package:wasteagram/post_controller.dart';
import 'package:wasteagram/helpers/image_proc.dart';

class FormBody extends StatefulWidget {

  FormBody(this._postController, {Key key}) : super(key: key);

  final PostController _postController;

  @override
  _FormBodyState createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {

  static const _emptyFieldMsg = 'Please enter the count of items here';
  static const _notIntMsg = 'Please enter intems (1-1000)';
  static const _ratingLabel = 'Item Count';
  static const _saveSuccess = 'Post saved successfully';
  static const _saveFailure = 'Error saving post';
  static const _submitSemantics = 'Upload post to cloud';
  static const _semanticsInputLabel = 'Enter item count';
  static const _maxCount = 1000;
  static const _minCount = 1;

  final _formKey = GlobalKey<FormState>();

  String _submitMsg = '';

  String _validateInt(var value) {

    if (value.isEmpty) {
      return _emptyFieldMsg;
    } else if (int.tryParse(value) == null) {
      return _notIntMsg;
    } else if (int.parse(value) > _maxCount || int.parse(value) < _minCount) {
      return _notIntMsg;
    }
    return null;
  }

  Widget _buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          color: Colors.teal,
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
            }
          },
          child: Semantics(button: true, label: _submitSemantics, child: Icon(Icons.cloud_upload,color: Colors.white)),
        ),
      ],
    );
  }

  void _savePost(int count) async {
    String imageBase64 = await ImageProc.loadImageFromCache();
    bool success = await widget._postController.createPost(imageBase64, 'New Item', count);
    if (success) {
      _submitMsg = _saveSuccess;
      widget._postController.incrementCounter();
    } else {
      _submitMsg = _saveFailure;
    }
    Navigator.pop(context, _submitMsg);
  }

  Widget _entryForm(BuildContext context) {
    var vsize = MediaQuery.of(context).size.height;
    var hsize = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(50),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Divider(),
              Container(
                height: vsize / 3,
                width: hsize / 2,
                child: FutureBuilder(
                  future: ImageProc.loadImageFromCache(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData) {
                      return Text('loading...');
                    }
                    return ImageProc.imgFromBase64(snapshot.data);
                  }     
                ),
              ),
              Divider(),
              Semantics(
                textField: true,
                label: _semanticsInputLabel,
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: _ratingLabel,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => _validateInt(value),
                  onSaved: (value) => _savePost(int.parse(value)),
                ),
              ),
              Divider(),
              _buttons(context),
            ]
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _entryForm(context);
  }
}