import 'package:flutter/material.dart';
import 'package:journal/styles/styles.dart';

class Welcome extends StatelessWidget {
  final Styles _styles = Styles('dark');
  static const _title = 'Welcome';
  static const _subtitle = 'Journal';
  static const _style = 'h1';

  Widget _centerIcon() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
            _styles.formattedText(_subtitle,_style),
            Icon(
              Icons.class_, 
              color: _styles.themeIconColors['note'], 
              size: _styles.iconSizes['note']
            )
          ]
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: _styles.formattedText(_title,_style)),
            actions: [ 
              IconButton(
                icon: Icon(Icons.settings, color: _styles.themeIconColors['settings']), 
                onPressed: null
              )
            ],
          ),
          body: _centerIcon(),
          floatingActionButtonAnimator: null,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed('add-entry')
          ),
        );
      },
    );
  }
}