import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/styles/styles.dart';

class JournalView extends StatefulWidget {
  @override
  _JournalViewState createState() => _JournalViewState();
}

class _JournalViewState extends State<JournalView> {

  final Styles _styles = Styles('dark');
  final String _header = 'Journal Entries';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _orientedView(BuildContext context, BoxConstraints constraints) => constraints.maxWidth > 500 ? Horizontal() : Vertical();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          key: _scaffoldKey,
          endDrawer: Container(child: Drawer(), width: MediaQuery.of(context).size.width * _styles.drawerFactor),
          appBar: AppBar(
            leading: Container(),
            title: Center(child: _styles.formattedText(_header, 'h1')),
            actions: [ 
              IconButton(
                icon: Icon(Icons.settings, color: _styles.themeIconColors['settings']), 
                onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
              )
            ],
          ),
          body: LayoutBuilder(builder: _orientedView),
        );
      },
    );
  }
}

class OrientedView extends StatelessWidget {

  final _items = List<Map>.generate(100,(i){
    return {
      'title':'Item $i',
      'subtitle':'Subtitle for $i',
    };
  });

  Widget _journalListView;

  OrientedView() {
    _journalListView = ListView.builder(
      itemBuilder: (context,index){
        return ListTile(
          leading: Icon(Icons.star),
          trailing: Icon(Icons.pool),
          title: Text(_items[index]['title']),
          subtitle: Text(_items[index]['subtitle']),
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white);
  }
}

class Vertical extends OrientedView {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green[100], child: _journalListView);
  }
}

class Horizontal extends OrientedView {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.green[100],
            child: _journalListView
          )
        ),
        Expanded(
          child: Container(color: Colors.red[100])
        ),
      ],
    );
  }
}