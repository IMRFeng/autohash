import 'package:flutter/material.dart';

class MessageDialog {
  static void show(
      BuildContext context, {
        String title = 'Something went wrong',
        String message = 'Please try again!',
      }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.lightBlue,
              child: Text(title == 'Authorize' ? 'Yes' : 'Submit', style: TextStyle(color: Colors.white),),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.redAccent,
              child: Text(title == 'Authorize' ? 'Back' : 'Cancel', style: TextStyle(color: Colors.white)),
            )
          ],
        );
      },
    );
  }
}