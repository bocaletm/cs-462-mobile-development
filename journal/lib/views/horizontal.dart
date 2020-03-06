import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/styles/styles.dart';

class Horizontal extends StatefulWidget {

  final Future<List<JournalEntry>> Function() getJournalEntries;
  final Styles Function() _getStyles;

  Horizontal(this.getJournalEntries, this._getStyles);

  @override
  _HorizontalState createState() => _HorizontalState();
}

class _HorizontalState extends State<Horizontal> {
  
  JournalEntry _focused;
  Styles _styles;

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
                  onTap: () => setState(() {
                    _focused = snapshot.data[index];
                  })
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

  Widget _focusedView() {

    var vsize = MediaQuery.of(context).size.height;

    if (_focused == null) {
      return Container();
    } else {

      Widget ratingStars = _styles.stars(_focused.rating);

      return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: Column(
                children: [
                  SizedBox(
                    height: vsize / 15,
                  ),
                  _styles.formattedText(_focused.title, 'h1'),
                  ratingStars,
                  SizedBox(
                    height: vsize / 15,
                  ),
                  _styles.formattedText(_focused.body, 'h2'),
              ]),
            ),
        ),
      );
    }
  }

  @override
  void initState(){
    super.initState();
    _styles = widget._getStyles();
  }

  @override
  Widget build(BuildContext context) {
    _styles = widget._getStyles();
    return Row(
      children: [
        Expanded(
          child: Container(
            child: _journalListView(),
          )
        ),
        Expanded(
          child: Container(
            child: _focusedView(),
          )
        ),
      ],
    );
  }
}