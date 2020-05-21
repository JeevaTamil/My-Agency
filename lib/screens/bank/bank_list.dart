import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_agency/screens/bank/bank_add.dart';
import 'package:my_agency/screens/bank/bank_details.dart';

import 'package:my_agency/services/bank_services.dart';

class BanksList extends StatefulWidget {
  @override
  _BanksListState createState() => _BanksListState();
}

class _BanksListState extends State<BanksList> {
  BankServices _bankServices = BankServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banks"),
      ),
      body: StreamBuilder(
        stream: _bankServices.streamBanks(),
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
                    _navigateToBankDetails(ds);
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
          _navigateToBanksAdd();
        },
      ),
    );
  }

  _navigateToBankDetails(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BanksDetails(ds),
        ));
  }

  _navigateToBanksAdd() {
    Navigator.push(context, _createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BanksAddForm(),
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
