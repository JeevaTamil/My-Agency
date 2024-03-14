import 'package:flutter/material.dart';
import 'package:my_agency/view/customer_listing_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    CustomerListingPage(),
    Text("Supplier"),
    // Add other page widgets for suppliers, bill inward, etc.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 20.0,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text('Customers'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text('Supplier'),
              ),
              // Add other NavigationRailDestinations for suppliers, bill inward, etc.
            ],
          ),
          // VerticalDivider(),
          Expanded(
            child: Container(
              child: _pages[_selectedIndex],
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
