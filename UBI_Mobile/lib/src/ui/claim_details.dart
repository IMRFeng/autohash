import 'package:flutter/material.dart';

class ClaimDetailsPage extends StatefulWidget {
  ClaimDetailsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ClaimDetailsPage createState() => _ClaimDetailsPage();
}

class _ClaimDetailsPage extends State<ClaimDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Claims Detail Page'),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                    text: 'Claims Detail Page for OBD123\n\n',
                    children: <TextSpan>[
                      TextSpan(text: 'To be implemented!', style: TextStyle(color: Colors.redAccent, fontSize: 28))
                    ])),
          )),
    );
  }
}
