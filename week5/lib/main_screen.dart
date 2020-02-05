import 'package:flutter/material.dart';
import 'components/centered_placeholder.dart';

class MainScreen extends StatelessWidget {

  final String title;

  const MainScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [ placeholderRow(), placeholderRow() ]
      )
    );
  }
}

Widget placeholderRow() {
  return Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              paddedPlaceholder(height: 150, width: 150, padding: 20), 
              paddedPlaceholder(height: 150, width: 150, padding: 20)
            ]);
}

Widget paddedPlaceholder({@required double height, @required double width, @required double padding}) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: SizedBox(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/9/96/Wayne%27s_Pachifractal_very_large_bright.jpg',
            fit: BoxFit.fill,
            loadingBuilder: (context, child, progress) {
              return progress == null
                ? child
                : RefreshProgressIndicator();
            }
          ),
        ), 
        height: height, width: width
      ),
  );
}