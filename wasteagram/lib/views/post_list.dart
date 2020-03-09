import 'package:flutter/material.dart';
import 'package:wasteagram/postController.dart';
import 'package:wasteagram/models/post.dart';

class PostList extends StatefulWidget {
  PostList({Key key}) : super(key: key);

  final PostController _postController = PostController();

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {

  _PostListState();

  static const String titlePrefix = 'Wasteagram ';

  int _counter = 0;

  String _title = '';


  void _uploadImage() async {
    
    widget._postController.createPost('title');
    widget._postController.incrementCounter();
    
    setState(() {
      _counter++;
      _title = '$titlePrefix$_counter';
    });
  }

  Future<int> _getCounter() async {
    int counter = await widget._postController.getNumPosts();
    return counter;
  }

  void _setCounter() async {
    _counter = await _getCounter();
    setState(() {
      _title = '$titlePrefix$_counter';
    });
  }

  Widget streamedListView() {
    return StreamBuilder(
      stream: widget._postController.readPosts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              Post post = widget._postController.postFromData(snapshot.data.documents[index].data);
              return ListTile(title: Text(post.name));
            },
          );
        }
      },
    );
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
        title: Center(child: Text(_title)),
      ),
      body: streamedListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _uploadImage(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}