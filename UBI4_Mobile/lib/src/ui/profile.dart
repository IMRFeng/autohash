import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'authorization.dart';
import 'about_us.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hr = Divider();

    final firstCard = Padding(
      padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 30.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Colors.white,
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              _buildIconTile(context, Icons.pages, Colors.green, 'Authorization'),
            ],
          ),
        ),
      ),
    );

    final secondCard = Padding(
      padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 30.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Colors.white,
        child: Container(
          height: 200.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              _buildIconTile(context, LineIcons.envelope, Colors.red, 'Notifications'),
              hr,
              _buildIconTile(context, LineIcons.cogs, Colors.grey.withOpacity(0.6), 'Settings'),
              hr,
              _buildIconTile(context, LineIcons.info, Colors.blue, 'About Us'),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 10.0,
                      ),
                    ],
                  ),
                  firstCard,
                  secondCard,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconTile(BuildContext context, IconData icon, Color color, String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: Container(
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
      trailing: Icon(LineIcons.chevron_circle_right),
      onTap: () {
        if (title == 'Authorization') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuthPage(),
            ),
          );
        } else if (title == 'About Us') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AboutUsPage(),
            ),
          );
        }

      },
    );
  }
}
