import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_agency/services/suppliers_services.dart';

class SuppliersSearch extends StatefulWidget {
  @override
  _SuppliersSearchState createState() => _SuppliersSearchState();
}

class _SuppliersSearchState extends State<SuppliersSearch> {
  SuppliersServices _suppliersServices = SuppliersServices();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  var queryResultSet = [];
  var tempResultset = [];

  initiateSearch(String value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempResultset = [];
      });
    }

    var capitalizedVal =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      _suppliersServices.searchByName(value).forEach((docs) {
        for (int i = 0; i < docs.documents.length; i++) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempResultset = [];
      queryResultSet.forEach((element) {
        if (element['name'].startsWith(capitalizedVal)) {
          setState(() {
            tempResultset.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Supplier"),
      ),
      body: searchTextField(),
    );
  }

  TextEditingController _searchController = TextEditingController();
  Widget searchTextField() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          child: TextField(
            onChanged: (value) {
              initiateSearch(value);
            },
            controller: _searchController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 0),
              prefixIcon: Icon(Icons.search),
              labelText: "Search Supplier",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: tempResultset.length,
          itemBuilder: (context, index) {
            if (tempResultset.isEmpty) {
              return Center(
                child: Text("No result"),
              );
            } else {
              return ListTile(
                title: Text(tempResultset[index]['name']),
                subtitle: Text(tempResultset[index]['city']),
                onTap: () {
                  Navigator.pop(context, tempResultset[index]);
                },
              );
            }
          },
        ),
      ],
    );
  }
}
