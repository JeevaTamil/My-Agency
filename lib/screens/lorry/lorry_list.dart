import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_agency/screens/lorry/lorry_add.dart';
import 'package:my_agency/screens/lorry/lorry_details.dart';

import 'package:my_agency/services/lorry_services.dart';

class LorrysList extends StatefulWidget {
  @override
  _LorrysListState createState() => _LorrysListState();
}

class _LorrysListState extends State<LorrysList> {
  LorryServices _lorryServices = LorryServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lorrys"),
      ),
      body: StreamBuilder(
        stream: _lorryServices.streamLorrys(),
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
                    _navigateToLorryDetails(ds);
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
          _navigateToLorrysAdd();
        },
      ),
    );
  }

  _navigateToLorryDetails(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LorrysDetails(ds),
        ));
  }

  _navigateToLorrysAdd() {
    Navigator.push(context, _createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LorrysAddForm(),
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
