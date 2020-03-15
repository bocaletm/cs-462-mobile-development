import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/helpers/image_proc.dart';
import 'package:wasteagram/post_controller.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/helpers/formatting.dart';
import 'package:wasteagram/views/add_entry_view.dart';

class PostList extends StatefulWidget {
  PostList({Key key}) : super(key: key);

  final PostController _postController = PostController();

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {

  _PostListState();

  static const String titlePrefix = 'Wasteagram ';
  static const String _tileLabel = 'Show post detail view';

  static const _snackbarSleep = 1500;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _title = '';

  OverlayEntry _overlayEntry;

  void _getImageAndNavToForm(BuildContext context) async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    await ImageProc.cacheImage(ImageProc.base64String(image.readAsBytesSync()));
    await _navigateToFormAndDisplayResult(context);
    _setCounter();
  }

  _navigateToFormAndDisplayResult(BuildContext context) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => AddEntryView(widget._postController)));
    if (result != null) {
      _scaffoldKey.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(backgroundColor: snackbarColorFromValue(result), content: Text('$result')));

      Future.delayed(const Duration(milliseconds: _snackbarSleep), () {
        
      });
      _setCounter();
    }
  }

  Future<int> _getCounter() async {
    int counter = await widget._postController.getCounter();
    return counter;
  }

  void _setCounter() async {
     var counter = await _getCounter();
    setState(() {
      _title = '$titlePrefix$counter';
    });
  }

  Widget _dateTile(BuildContext context, Post post) {
    const double widthFactor = 0.09;
    const double heightFactor = 0.09;
    var size = MediaQuery.of(context).size;
    return Semantics(
      label: _tileLabel,
      focusable: true,
      child: GestureDetector(
        onTap: () => _insertOverlay(context, post),
        child: ListTile(
          title: Text(post.dateString),
          leading: Icon(Icons.image),
          trailing: Container(
            height: size.height * heightFactor,
            width: size.width * widthFactor,
            child: FloatingActionButton(
              heroTag: post.date.toString(),
              backgroundColor: Colors.blueGrey,
              child: Text(post.count.toString()),
              onPressed: () => _insertOverlay(context, post),
            ),
          ),
        ),
      ),
    );
  }

  void _hideOverlay() {
    _overlayEntry.remove();
  }

  void _insertOverlay(BuildContext context,Post post) {
    _overlayEntry =   OverlayEntry(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, //override back button
          title: Center(child: Text(titlePrefix)),
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed: () => _hideOverlay(), 
          )
        ),
        body: GestureDetector(
          child: _focusView(context, post),
          onTap: () {
            _hideOverlay();
          },
        )
      );
    });

    Overlay.of(context).insert(_overlayEntry);
  }

  Widget _focusView(BuildContext context, Post post) {
    
    var vsize = MediaQuery.of(context).size.height;
    var hsize = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('${post.dateString}'),
                  Divider(),
                  Container(
                    height: vsize / 3,
                    width: hsize / 2,
                    child: formattedPhoto(post.imageUrl),
                  ),
                  Divider(),
                  Text('Items: ${post.count.toString()}'),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('(${post.latitude.toString()}, '),
                    Text('${post.longitude.toString()})'),
                  ]),
              ]),
            ),
        ),
      ),
    );
  }

  Widget _streamedListView(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).size.height / 10;
    return StreamBuilder(
      stream: widget._postController.readPosts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.documents.length < 1) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(0, 0, 0, bottomPadding),
            separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              Post post = PostController.postFromData(snapshot.data.documents[index].data);
              post.datePost();
              return _dateTile(context, post);
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text(_title, style: TextStyle(fontWeight: FontWeight.w700))),
      ),
      body: _streamedListView(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'main',
        onPressed: () => _getImageAndNavToForm(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}