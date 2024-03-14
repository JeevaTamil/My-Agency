import 'package:flutter/material.dart';
import 'package:my_agency/module/customer/view/customer_listing_page.dart';
import 'package:my_agency/module/supplier/view/supplier_listing_page.dart';

class NavModel {
  String label;
  Icon icon;
  Widget page;

  NavModel({required this.icon, required this.label, required this.page});

  static final navModelList = [
    NavModel(
      icon: const Icon(Icons.person_add_alt_sharp),
      label: 'Customer',
      page: CustomerListingPage(),
    ),
    NavModel(
      icon: const Icon(Icons.person),
      label: 'Supplier',
      page: SupplierListingPage(),
    ),
    NavModel(
      icon: const Icon(Icons.settings),
      label: 'Settings',
      page: const Text('Settings'),
    ),
    NavModel(
      icon: const Icon(Icons.more_horiz),
      label: 'More',
      page: const Text('More'),
    ),
  ];
}
