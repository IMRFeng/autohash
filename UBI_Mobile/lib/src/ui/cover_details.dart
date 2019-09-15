import 'package:flutter/material.dart';

class CoverDetailsPage extends StatefulWidget {
  CoverDetailsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CoverDetailsPage createState() => _CoverDetailsPage();
}

class _CoverDetailsPage extends State<CoverDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cover Details Page'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                  text: 'Cover Details Page for Premium A\n\n',
                  children: <TextSpan>[
                    TextSpan(text: 'To be implemented!', style: TextStyle(color: Colors.redAccent, fontSize: 28))
                  ])),
        ),
      ),
    );
  }
}
