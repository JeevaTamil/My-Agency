import 'package:flutter/material.dart';
import 'package:my_agency/module/bill_inward/model/bill_inward_with_details.dart';
import 'package:my_agency/module/bill_inward/view/bill_inward_form_page.dart';

class BillInwardDataTable extends StatelessWidget {
  const BillInwardDataTable(
      {super.key, required this.billInwardWithDetailsList});
  final List<BillInwardWithDetails> billInwardWithDetailsList;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(label: Text('Supplier')),
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Bill Date')),
        DataColumn(label: Text('Bill No')),
        DataColumn(label: Text('Bill Final Amount')),
        DataColumn(label: Text('Transport')),
        DataColumn(label: Text('LR No')),
        DataColumn(label: Text('LR Date')),
      ],
      rows: billInwardWithDetailsList.map((item) {
        return DataRow(
          cells: [
            DataCell(Text(item.supplierName)),
            DataCell(Text(item.customerName)),
            DataCell(Text(item.billDate.toString())),
            DataCell(Text(item.billNumber)),
            DataCell(Text(item.finalBillAmount.toString())),
            DataCell(Text(item.transportName)),
            DataCell(Text(item.lrNumber)),
            DataCell(Text(item.lrDate.toString())),
          ],
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: BillInwardFormPage(
                      billInward: item.toBillInward(),
                    ),
                  ),
                );
              },
            );
          },
        );
      }).toList(),
    );
  }
}
