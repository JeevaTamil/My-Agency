import 'package:flutter/material.dart';
import 'package:my_agency/models/bank_model.dart';

import 'package:my_agency/services/bank_services.dart';

class BanksAddForm extends StatelessWidget {
  final BankServices _bankServices = BankServices();

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
          title: Text("Add Bank"),
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
          labelText: "Bank Name", prefixIcon: Icon(Icons.contacts)),
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
        _addBank();
        Navigator.pop(context);
      },
    );
  }

  _addBank() async {
    await _bankServices
        .addBank(BankModel(name: _name.text, createdOn: DateTime.now()));
  }
}
