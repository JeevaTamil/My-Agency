import 'package:flutter/material.dart';
import 'package:my_agency/helper/views/list_empty_state_widget.dart';
import 'package:my_agency/helper/views/responsive_list_view.dart';
import 'package:my_agency/module/customer/model/customer.dart';
import 'package:my_agency/module/customer/cubit/customer_cubit.dart';
import 'package:my_agency/module/customer/view/customer_detail_page.dart';
import 'package:my_agency/module/customer/view/customer_form_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef void CustomerCallback(Customer customer);

class CustomerListingPage extends StatefulWidget {
  const CustomerListingPage(
      {super.key, this.selectedCustomer, this.isFormField = false});
  final CustomerCallback? selectedCustomer;
  final bool isFormField;

  @override
  _CustomerListingPageState createState() => _CustomerListingPageState();
}

class _CustomerListingPageState extends State<CustomerListingPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    BlocProvider.of<CustomerCubit>(context)
        .searchCustomer(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20.0,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              )
            : widget.isFormField
                ? const Text('Select Customer')
                : const Text('Customer Listing'),
        actions: [
          if (!_isSearching)
            IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomerFormPage()),
                );
              },
            ),
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  // Clear search
                  _searchController.clear();
                }
                _isSearching = !_isSearching;
              });
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
                if (customers.isEmpty) {
                  return const ListEmptyStateWidget();
                }
                return ResponsiveListView.single(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: _customerList(customers));
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

  ListView _customerList(List<Customer> customers) {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CustomerFormPage(customer: customer)),
                  );
                },
                icon: const Icon(Icons.edit_rounded),
              ),
            ],
          ),
          onTap: () {
            if (widget.isFormField) {
              setState(() {
                widget.selectedCustomer!(customer);
              });
            }
          },
        );
      },
    );
  }
}
