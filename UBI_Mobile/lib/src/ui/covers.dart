import 'package:flutter/material.dart';
import '../shared/message_dialog.dart';
import 'cover_details.dart';

class MyCoversPage extends StatefulWidget {
  MyCoversPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCoversPage createState() => _MyCoversPage();
}

class _MyCoversPage extends State<MyCoversPage> {

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        MessageDialog.show(context, title: 'Apply', message: 'Your premium is \$800 per month.\n\n\n\nTerms and conditions\n');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      body: Container(
        child: DataTable(
          onSelectAll: (b) {},
          horizontalMargin: 12,
          columnSpacing: 45,
          sortAscending: true,
          columns: <DataColumn>[
            DataColumn(
              label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),),
            ),
            DataColumn(
              label: Text('Period', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),),
            ),
            DataColumn(
              label: Text('Premium', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),),
            ),
            DataColumn(
              label: Text('StartDate', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),),
            ),
          ],
          rows: items
              .map(
                (itemRow) => DataRow(
              cells: [
                DataCell(
                  Text(itemRow.name),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(itemRow.period),
                  showEditIcon: false,
                  placeholder: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoverDetailsPage(),
                      ),
                    );
                  },
                ),
                DataCell(
                  Text(itemRow.premium),
                  showEditIcon: false,
                  placeholder: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoverDetailsPage(),
                      ),
                    );
                  },
                ),
                DataCell(
                  Text(itemRow.dateTime),
                  showEditIcon: false,
                  placeholder: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoverDetailsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}

class ItemInfo {
  String name;
  String dateTime;
  String period;
  String premium;

  ItemInfo({
    this.name,
    this.dateTime,
    this.premium,
    this.period
  });
}

var items = <ItemInfo>[
  ItemInfo(
    name: 'Item A',
    dateTime: '2019-02-10',
    period: '12 Mos',
      premium: '\$2000'
  ),
  ItemInfo(
      name: 'Item B',
      dateTime: '2019-05-20',
      period: '8 Mos',
      premium: '\$1800'
  ),
  ItemInfo(
      name: 'Item C',
      dateTime: '2019-08-28',
      period: '23 Days',
      premium: '\$500'
  ),
];
