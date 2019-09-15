import 'package:flutter/material.dart';
import '../shared/message_dialog.dart';
import 'claim_details.dart';

class MyClaimsPage extends StatefulWidget {
  MyClaimsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyClaimsPage createState() => _MyClaimsPage();
}

class _MyClaimsPage extends State<MyClaimsPage> {
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add_box),
      onPressed: () {
        MessageDialog.show(context, title: 'Claims', message: 'To be implemented!');
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
              label: Text(
                'Claims#',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
              ),
            ),
            DataColumn(
              label: Text(
                'Invoice#',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
              ),
            ),
            DataColumn(
              label: Text(
                'Fee',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
              ),
            ),
            DataColumn(
              label: Text(
                'ServiceDate',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
              ),
            ),
          ],
          rows: items
              .map(
                (itemRow) => DataRow(
                  cells: [
                    DataCell(
                      Text(itemRow.claimsNumber),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      Text(itemRow.invoiceNumber),
                      showEditIcon: false,
                      placeholder: false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClaimDetailsPage(),
                          ),
                        );
                      },
                    ),
                    DataCell(
                      Text(itemRow.fee),
                      showEditIcon: false,
                      placeholder: false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClaimDetailsPage(),
                          ),
                        );
                      },
                    ),
                    DataCell(
                      Text(itemRow.serviceDate),
                      showEditIcon: false,
                      placeholder: false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClaimDetailsPage(),
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
  String claimsNumber;
  String invoiceNumber;
  String fee;
  String serviceDate;

  ItemInfo({this.claimsNumber, this.invoiceNumber, this.fee, this.serviceDate});
}

var items = <ItemInfo>[
  ItemInfo(claimsNumber: 'OBD123', invoiceNumber: 'IN24943', fee: '\$123', serviceDate: '2018-12-28'),
  ItemInfo(claimsNumber: 'OBD456', invoiceNumber: 'IN92845', fee: '\$78', serviceDate: '2019-02-17'),
  ItemInfo(claimsNumber: 'OBD789', invoiceNumber: 'IN01923', fee: '\$99', serviceDate: '2018-07-09'),
];
