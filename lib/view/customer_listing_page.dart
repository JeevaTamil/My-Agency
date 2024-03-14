import 'package:flutter/material.dart';
import 'package:my_agency/module/customer/model/customer.dart';
import 'package:my_agency/module/customer/cubit/customer_cubit.dart';
import 'package:my_agency/view/customer_detail_page.dart';
import 'package:my_agency/view/customer_form_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerListingPage extends StatefulWidget {
  @override
  _CustomerListingPageState createState() => _CustomerListingPageState();
}

class _CustomerListingPageState extends State<CustomerListingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Listing'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: SingleChildScrollView(
                      child: CustomerFormPage(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CustomerCubit, CustomerState>(
        builder: (context, state) {
          return FutureBuilder<List<Customer>>(
            future: state.customers,
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
                final customers = snapshot.data!;
                return ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    return ListTile(
                      title: Text(customer.name),
                      subtitle: Text(customer.city),
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
                                    child: CustomerDetailPage(
                                      customer: customer,
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
                                          child: CustomerFormPage(
                                              customer: customer)));
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
                  child: Text('No customers found'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
