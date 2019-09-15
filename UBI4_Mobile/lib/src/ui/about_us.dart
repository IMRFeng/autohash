import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  AboutUsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AboutUsPage createState() => _AboutUsPage();
}

class _AboutUsPage extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'About Autohash',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
