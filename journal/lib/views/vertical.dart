import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/styles/styles.dart';

class Vertical extends StatefulWidget {

  final Future<List<JournalEntry>> Function() getJournalEntries;
  final Styles Function() _getStyles;

  Vertical(this.getJournalEntries, this._getStyles);

  @override
  _VerticalState createState() => _VerticalState();
}

class _VerticalState extends State<Vertical> {

  Styles _styles;

  OverlayEntry _overlayEntry;

  Widget _focusView(BuildContext context,JournalEntry entry) {
    
    var vsize = MediaQuery.of(context).size.height;

    Widget ratingStars = _styles.stars(entry.rating);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: vsize / 4),
                  _styles.formattedText(entry.title, 'h1'),
                  Divider(),
                  ratingStars,
                  SizedBox(height: vsize / 15),
                  _styles.formattedText(entry.body, 'h2'),
              ]),
            ),
        ),
      ),
    );
  }

  void _hideOverlay() {
    _overlayEntry.remove();
  }

  void _insertOverlay(BuildContext context,JournalEntry entry) {
    _overlayEntry =   OverlayEntry(builder: (context) {
      var size = MediaQuery.of(context).size;
      return Positioned(
        width: size.width,
        height: size.height,
        child: Material(
          color: Colors.blue,
          child: GestureDetector(
            child: _focusView(context, entry),
            onTap: () {
              _hideOverlay();
            },
          )
        ),
      );
    });

    Overlay.of(context).insert(_overlayEntry);
  }

  Widget _journalListView() {
    return FutureBuilder(
        future: widget.getJournalEntries(),
        builder: (context,snapshot) { 
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                return ListTile(
                  leading: Icon(Icons.open_in_new),
                  title: Text(snapshot.data[index].title),
                  subtitle: Text(snapshot.data[index].dateString),
                  onTap: () => _insertOverlay(context,snapshot.data[index]),
                );
              }
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );   
  }

  @override
  void initState(){
    super.initState();
    _styles = widget._getStyles();
  }

  @override
  Widget build(BuildContext context) {
    _styles = widget._getStyles();
    return Container(child: _journalListView());
  }
}