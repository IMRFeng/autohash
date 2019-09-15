import 'package:flutter/material.dart';
import '../shared/message_dialog.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AuthPage createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authorization'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Align(
              alignment: Alignment(0, -1.0),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: RaisedButton(
                        child: Text(
                          'Enable',
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.green,
                        onPressed: () {
                          MessageDialog.show(context, title: 'Authorize', message: 'You are granting the UBI to capture your data!');
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: RaisedButton(
                        child: Text(
                          'Disable',
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.yellowAccent,
                        onPressed: () {
                          MessageDialog.show(context, title: 'Authorize', message: 'Are your sure you want to revoke the UBI\'s permission?');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fit: FlexFit.tight,
            flex: 2,
          ),
          Flexible(
            child: Align(
                alignment: Alignment(0, -2.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  childAspectRatio: 4,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(24),
                      child: RaisedButton(
                        child: Text(
                          'Clear All Data',
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.red,
                        onPressed: () {
                          MessageDialog.show(context,
                              title: 'Authorize', message: 'Your data has been removed successfully!');
                        },
                      ),
                    ),
                  ],
                )),
            fit: FlexFit.tight,
            flex: 3,
          )
        ],
      ),
    );
  }
}
