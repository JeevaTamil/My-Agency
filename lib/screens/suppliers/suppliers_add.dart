import 'package:flutter/material.dart';
import 'package:my_agency/models/supplier_model.dart';
import 'package:my_agency/services/suppliers_services.dart';

class SuppliersAddForm extends StatelessWidget {
  final SuppliersServices _suppliersServices = SuppliersServices();

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
          title: Text("Add Supplier"),
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
                  addressTextField(),
                  SizedBox(height: 15),
                  cityTextField(),
                  SizedBox(height: 15),
                  phoneNumberTextField(),
                  SizedBox(height: 15),
                  gstTextField(),
                  SizedBox(height: 15),
                  commissionTextField(),
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
          labelText: "Supplier Name", prefixIcon: Icon(Icons.contacts)),
    );
  }

  TextEditingController _address = TextEditingController();
  Widget addressTextField() {
    return TextFormField(
      controller: _address,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      decoration: InputDecoration(
          labelText: "Address", prefixIcon: Icon(Icons.card_travel)),
    );
  }

  TextEditingController _city = TextEditingController();
  Widget cityTextField() {
    return TextFormField(
      controller: _city,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: "City", prefixIcon: Icon(Icons.location_city)),
    );
  }

  TextEditingController _phone = TextEditingController();
  Widget phoneNumberTextField() {
    return TextFormField(
      controller: _phone,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Phone Number", prefixIcon: Icon(Icons.contact_phone)),
    );
  }

  TextEditingController _gst = TextEditingController();
  Widget gstTextField() {
    return TextFormField(
      controller: _gst,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: "GST Number", prefixIcon: Icon(Icons.business_center)),
    );
  }

  TextEditingController _commission = TextEditingController();
  Widget commissionTextField() {
    return TextFormField(
      controller: _commission,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Commission", prefixIcon: Icon(Icons.monetization_on)),
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
        _addSupplier();
        Navigator.pop(context);
      },
    );
  }

  _addSupplier() async {
    await _suppliersServices.addSupplier(SuppliersModel(
        name: _name.text,
        address: _address.text,
        city: _city.text,
        phone: int.parse(_phone.text) ?? 0,
        gst: _gst.text,
        commission: int.parse(_commission.text) ?? 0,
        createdOn: DateTime.now()));
  }
}
