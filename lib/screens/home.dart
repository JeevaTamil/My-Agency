import 'package:flutter/material.dart';
import 'package:my_agency/models/customer_model.dart';
import 'package:my_agency/screens/bank/bank_list.dart';
import 'package:my_agency/screens/customers/cusomers_list.dart';
import 'package:my_agency/screens/image_upload.dart';
import 'package:my_agency/screens/lorry/lorry_list.dart';
import 'package:my_agency/screens/purchase_entry/purchase_entry_list.dart';
import 'package:my_agency/screens/suppliers/suppliers_list.dart';
import 'package:my_agency/services/customers_services.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        //drawer: drawerMenu(context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              menu(context, Colors.red, 'Suppliers'),
              menu(context, Colors.orange, 'Customers'),
              menu(context, Colors.yellow, 'Purchase Entry'),
              menu(context, Colors.green, 'invoice Entry'),
              menu(context, Colors.blue, 'Banks'),
              menu(context, Colors.indigo, 'Lorrys'),
              menu(context, Colors.deepPurple, 'Lorrys'),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu(BuildContext context, Color color, String menu) {
    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
            onTap: () {
              if (menu == 'Suppliers') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuppliersList(),
                    ));
              } else if (menu.toLowerCase() == 'customers') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomersList(),
                    ));
              } else if (menu.toLowerCase() == 'banks') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BanksList(),
                    ));
              } else if (menu.toLowerCase() == 'lorrys') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LorrysList(),
                    ));
              } else if (menu.toLowerCase() == 'purchase entry') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PurchaseEntryList(),
                    ));
              }
            },
            child: Container(
              margin: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color, Colors.white10]),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                  )
                ],
              ),
            )),
        Text(menu)
      ],
    );
  }

  Widget drawerMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: InkWell(
              child: CircleAvatar(
                backgroundImage: NetworkImage('http://i.pravatar.cc/'),
              ),
              onTap: () {
                print("tapped");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageCapture(),
                    ));
              },
            ),
            accountName: Text('Jeeva'),
            accountEmail: Text('jeevapriyan@ymail.com'),
          ),
          ListTile(
              leading: Icon(Icons.business),
              title: Text("Customers"),
              onTap: () => _navigateToCustomers(context))
        ],
      ),
    );
  }

  _navigateToCustomers(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return MultiProvider(
          providers: [
            StreamProvider<List<CustomersModel>>(
              create: (context) => CustomersServices().streamCustomers(),
              initialData: [],
            )
          ],
          child: CustomersList(),
        );
      },
    ));
  }
}
