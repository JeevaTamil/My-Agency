import 'package:flutter/material.dart';
import 'package:my_agency/module/bill_inward/model/bill_inward.dart';

class BillInwardFormPage extends StatefulWidget {
  final BillInward?
      billInward; // Pass billInward for editing, null for creating

  const BillInwardFormPage({Key? key, this.billInward}) : super(key: key);

  @override
  State<BillInwardFormPage> createState() => _BillInwardFormPageState();
}

class _BillInwardFormPageState extends State<BillInwardFormPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
