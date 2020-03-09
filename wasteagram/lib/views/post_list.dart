import 'package:flutter/material.dart';
import 'package:wasteagram/postController.dart';

class PostList extends StatefulWidget {
  PostList({Key key}) : super(key: key);

  final PostController _postController = PostController();

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {

  _PostListState();

  int _counter = 0;

  String _title = '';

  void _uploadImage() async {
    
    widget._postController.createPost('title');
    widget._postController.incrementCounter();
    
    setState(() {
      _counter++;
      _title = 'Wasteagram $_counter';
    });
  }

  Future<int> _getCounter() async {
    int counter = await widget._postController.getNumPosts();
    return counter;
  }

  void _setCounter() async {
    _counter = await _getCounter();
    setState(() {
      _title = 'Wasteagram $_counter';
    });
  }

  @override
  void initState(){
    super.initState();
    _setCounter();
  }

  @override
  Widget build(BuildContext context) {
    print('title in build $_title');
    Widget _image = widget._postController.getLastUploaded().isNotEmpty ? Image.network(widget._postController.getLastUploaded()) : CircularProgressIndicator(); 
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Images uploaded:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            _image,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _uploadImage(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}