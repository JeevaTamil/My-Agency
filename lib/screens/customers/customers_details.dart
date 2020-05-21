import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_agency/services/customers_services.dart';

class CustomersDetails extends StatefulWidget {
  final DocumentSnapshot ds;
  CustomersDetails(this.ds);

  @override
  _CustomersDetailsState createState() => _CustomersDetailsState();
}

class _CustomersDetailsState extends State<CustomersDetails> {
  final CustomersServices _customersServices = CustomersServices();
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
          _customersServices.deleteCustomer(widget.ds);
          Navigator.pop(context);
        },
      ),
    );
  }
}
