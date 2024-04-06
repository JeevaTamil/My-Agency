import 'package:flutter/material.dart';
import 'package:my_agency/helper/database/database_helper.dart';
import 'package:my_agency/helper/supabase/supabase_helper.dart';
import 'package:my_agency/module/bill_inward/view/bill_inward_listing_page.dart';
import 'package:my_agency/module/customer/view/customer_listing_page.dart';
import 'package:my_agency/module/supplier/view/supplier_listing_page.dart';
import 'package:my_agency/module/transaction/view/transaction_listing_page.dart';

class NavModel {
  String label;
  Icon icon;
  Widget page;

  NavModel({required this.icon, required this.label, required this.page});

  static final navModelList = [
    NavModel(
      icon: const Icon(Icons.factory_outlined),
      label: 'Suppliers',
      page: SupplierListingPage(),
    ),
    NavModel(
      icon: const Icon(Icons.co_present_outlined),
      label: 'Customers',
      page: CustomerListingPage(),
    ),
    NavModel(
      icon: const Icon(Icons.compare_arrows_outlined),
      label: 'Transactions',
      page: const TransactionListingPage(),
    ),
    NavModel(
      icon: const Icon(Icons.more_horiz),
      label: 'More',
      page: Scaffold(
        body: Center(
          child: ElevatedButton(
            child: Text('reset db'),
            onPressed: () {
              // DatabaseHelper().flushDatabaseAndStartFreshly();
              SupabaseHelper().getTransaction();
            },
          ),
        ),
      ),
    ),
  ];
}
