import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_agency/services/bank_services.dart';

class BanksDetails extends StatefulWidget {
  final DocumentSnapshot ds;
  BanksDetails(this.ds);

  @override
  _BanksDetailsState createState() => _BanksDetailsState();
}

class _BanksDetailsState extends State<BanksDetails> {
  final BankServices _bankServices = BankServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ds.data['name']),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
        onPressed: () {
          _bankServices.deleteBank(widget.ds);
          Navigator.pop(context);
        },
      ),
    );
  }
}
