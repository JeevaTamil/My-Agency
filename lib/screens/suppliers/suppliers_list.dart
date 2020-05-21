import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_agency/screens/suppliers/suppliers_add.dart';
import 'package:my_agency/screens/suppliers/suppliers_details.dart';
import 'package:my_agency/services/suppliers_services.dart';

class SuppliersList extends StatefulWidget {
  @override
  _SuppliersListState createState() => _SuppliersListState();
}

class _SuppliersListState extends State<SuppliersList> {
  SuppliersServices _suppliersServices = SuppliersServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suppliers"),
      ),
      body: StreamBuilder(
        stream: _suppliersServices.streamSuppliers(),
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
          _navigateToSuppliersAdd();
        },
      ),
    );
  }

  _navigateToSupplierDetails(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuppliersDetails(ds),
        ));
  }

  _navigateToSuppliersAdd() {
    Navigator.push(context, _createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SuppliersAddForm(),
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
