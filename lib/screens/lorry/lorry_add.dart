import 'package:flutter/material.dart';
import 'package:my_agency/models/Lorry_model.dart';

import 'package:my_agency/services/lorry_services.dart';

class LorrysAddForm extends StatelessWidget {
  final LorryServices _lorryServices = LorryServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          title: Text("Add Lorry"),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: <Widget>[
                  nameTextField(),
                  SizedBox(height: 15),
                  addButton(context),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ));
  }

  TextEditingController _name = TextEditingController();
  Widget nameTextField() {
    return TextFormField(
      controller: _name,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: "Lorry Name", prefixIcon: Icon(Icons.contacts)),
    );
  }

  Widget addButton(BuildContext context) {
    return RaisedButton(
      elevation: 10,
      color: Theme.of(context).accentColor,
      child: Text(
        "Add",
        style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
      ),
      onPressed: () {
        _addLorry();
        Navigator.pop(context);
      },
    );
  }

  _addLorry() async {
    await _lorryServices
        .addLorry(LorryModel(name: _name.text, createdOn: DateTime.now()));
  }
}
