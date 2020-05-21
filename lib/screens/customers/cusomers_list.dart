import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_agency/screens/customers/customers_add.dart';
import 'package:my_agency/screens/customers/customers_details.dart';

import 'package:my_agency/services/customers_services.dart';

class CustomersList extends StatefulWidget {
  @override
  _CustomersListState createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  CustomersServices _customersServices = CustomersServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers"),
      ),
      body: StreamBuilder(
        stream: _customersServices.streamCustomers(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Text(
              'No Data...',
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return ListTile(
                  title: Text(ds.data["name"]),
                  onTap: () {
                    _navigateToSupplierDetails(ds);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _navigateToCustomersAdd();
        },
      ),
    );
  }

  _navigateToSupplierDetails(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomersDetails(ds),
        ));
  }

  _navigateToCustomersAdd() {
    Navigator.push(context, _createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          CustomersAddForm(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
