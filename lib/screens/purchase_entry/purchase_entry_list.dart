import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_agency/screens/purchase_entry/purchase_entry_add.dart';
import 'package:my_agency/services/purchase_entry_services.dart';

class PurchaseEntryList extends StatefulWidget {
  @override
  _PurchaseEntryListState createState() => _PurchaseEntryListState();
}

class _PurchaseEntryListState extends State<PurchaseEntryList> {
  PurchaseEntryServices _purchaseEntryServices = PurchaseEntryServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Entry"),
      ),
      body: StreamBuilder(
        stream: _purchaseEntryServices.streamPurchaseEntries(),
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
                  onTap: () {},
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _navigateToPurchaseEntryAdd();
        },
      ),
    );
  }

  _navigateToPurchaseEntryAdd() {
    Navigator.push(context, _createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PurchaseEntryAdd(),
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
