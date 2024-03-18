import 'package:flutter/material.dart';
import 'package:my_agency/helper/views/list_empty_state_widget.dart';
import 'package:my_agency/module/bill_inward/cubit/bill_inward_cubit.dart';
import 'package:my_agency/module/bill_inward/model/bill_inward.dart';
import 'package:my_agency/module/bill_inward/view/Bill_inward_detail_page.dart';
import 'package:my_agency/module/bill_inward/view/bill_inward_form_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillInwardListingPage extends StatefulWidget {
  const BillInwardListingPage({super.key});

  @override
  State<BillInwardListingPage> createState() => _BillInwardListingPageState();
}

class _BillInwardListingPageState extends State<BillInwardListingPage> {
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
    // BlocProvider.of<CustomerCubit>(context)
    //   .searchCustomer(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              )
            : const Text('Bill Inward Listing'),
        actions: [
          if (!_isSearching)
            IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              icon: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: SingleChildScrollView(
                        child: BillInwardFormPage(),
                      ),
                    );
                  },
                );
              },
            ),
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchController.clear();
                }
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<BillInwardCubit, BillInwardState>(
        builder: (context, state) {
          return FutureBuilder<List<BillInward>>(
            future: state.billInwards,
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
                final billInwards = snapshot.data!;
                if (billInwards.isEmpty) {
                  return const ListEmptyStateWidget();
                } else {
                  return ListView.builder(
                    itemCount: billInwards.length,
                    itemBuilder: (context, index) {
                      final billInward = billInwards[index];
                      return ListTile(
                        title: Text(billInward.supplier),
                        subtitle: Text(billInward.customer),
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
                                      child: BillInwardDetail(
                                        billInward: billInward,
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
                                            child: BillInwardFormPage(
                                                billInward: billInward)));
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
                }
              } else {
                return const Center(
                  child: Text('No Bill Inward found'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
