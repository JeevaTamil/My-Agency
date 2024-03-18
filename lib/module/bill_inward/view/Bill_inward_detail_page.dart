import 'package:flutter/material.dart';
import 'package:my_agency/module/bill_inward/model/bill_inward.dart';

class BillInwardDetail extends StatefulWidget {
  const BillInwardDetail({super.key, required this.billInward});
  final BillInward billInward;

  @override
  State<BillInwardDetail> createState() => _BillInwardDetailState();
}

class _BillInwardDetailState extends State<BillInwardDetail> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
