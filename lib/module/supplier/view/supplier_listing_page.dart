import 'package:flutter/material.dart';
import 'package:my_agency/module/supplier/model/supplier.dart';
import 'package:my_agency/module/supplier/cubit/supplier_cubit.dart';
import 'package:my_agency/module/supplier/view/supplier_detail_page.dart';
import 'package:my_agency/module/supplier/view/supplier_form_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupplierListingPage extends StatefulWidget {
  @override
  _SupplierListingPageState createState() => _SupplierListingPageState();
}

class _SupplierListingPageState extends State<SupplierListingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplier Listing'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: SingleChildScrollView(
                      child: SupplierFormPage(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<SupplierCubit, SupplierState>(
        builder: (context, state) {
          return FutureBuilder<List<Supplier>>(
            future: state.suppliers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final suppliers = snapshot.data!;
                return ListView.builder(
                  itemCount: suppliers.length,
                  itemBuilder: (context, index) {
                    final supplier = suppliers[index];
                    return ListTile(
                      title: Text(supplier.name),
                      subtitle: Text(supplier.city),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      content: SingleChildScrollView(
                                    child: SupplierDetailPage(
                                      supplier: supplier,
                                    ),
                                  ));
                                },
                              );
                            },
                            icon: const Icon(Icons.info_outline),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      content: SingleChildScrollView(
                                          child: SupplierFormPage(
                                              supplier: supplier)));
                                },
                              );
                            },
                            icon: const Icon(Icons.edit_rounded),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No suppliers found'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
