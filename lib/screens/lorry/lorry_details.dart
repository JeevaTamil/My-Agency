import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:my_agency/services/lorry_services.dart';

class LorrysDetails extends StatefulWidget {
  final DocumentSnapshot ds;
  LorrysDetails(this.ds);

  @override
  _LorrysDetailsState createState() => _LorrysDetailsState();
}

class _LorrysDetailsState extends State<LorrysDetails> {
  final LorryServices _lorryServices = LorryServices();
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
          _lorryServices.deleteLorry(widget.ds);
          Navigator.pop(context);
        },
      ),
    );
  }
}
