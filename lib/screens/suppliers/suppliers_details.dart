import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_agency/services/suppliers_services.dart';

class SuppliersDetails extends StatefulWidget {
  final DocumentSnapshot ds;
  SuppliersDetails(this.ds);

  @override
  _SuppliersDetailsState createState() => _SuppliersDetailsState();
}

class _SuppliersDetailsState extends State<SuppliersDetails> {
  final SuppliersServices _suppliersServices = SuppliersServices();
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
          _suppliersServices.deleteSupplier(widget.ds);
          Navigator.pop(context);
        },
      ),
    );
  }
}
