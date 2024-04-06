import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_agency/helper/views/list_empty_state_widget.dart';
import 'package:my_agency/helper/views/responsive_list_view.dart';
import 'package:my_agency/module/transaction/cubit/transaction_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_agency/module/transaction/model/transaction_info.dart';
import 'package:my_agency/module/transaction/view/transaction_detail_view.dart';
import 'package:my_agency/module/transaction/view/transaction_form_page.dart';

class TransactionListingPage extends StatefulWidget {
  const TransactionListingPage({super.key});

  @override
  _TransactionListingPageState createState() => _TransactionListingPageState();
}

class _TransactionListingPageState extends State<TransactionListingPage> {
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
    // BlocProvider.of<TransactionCubit>(context)
    // .searchTransaction(_searchController.text);
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
            : const Text('Transaction Listing'),
        actions: [
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransactionFormPage()),
                );
              },
            ),
          IconButton(
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
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          return FutureBuilder<List<TransactionInfo>>(
            future: state.transactions,
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
                final transactions = snapshot.data!;
                if (transactions.isEmpty) {
                  return const ListEmptyStateWidget();
                }
                return ResponsiveListView.single(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: _transactionListView(transactions));
              } else {
                return const Center(
                  child: Text('No transactions found'),
                );
              }
            },
          );
        },
      ),
    );
  }

  ListView _transactionListView(List<TransactionInfo> transactions) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionDetailView(
                      transactionInfo: transaction,
                    ),
                  ));
            },
            onLongPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionFormPage(
                      transactionInfo: transaction,
                    ),
                  ));
            },
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    _partyName(
                        transaction.supplierName, transaction.supplierCity),
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(Icons.compare_arrows_outlined),
                    const SizedBox(
                      width: 15,
                    ),
                    _partyName(
                        transaction.customerName, transaction.customerCity),
                    const SizedBox(
                      width: 15,
                    ),
                    const Spacer(),
                    FittedBox(
                      child: Text(
                        (transaction.billAmount -
                                transaction.discountAmount +
                                transaction.taxAmount)
                            .toStringAsFixed(2),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  Column _partyName(String name, String city) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          city,
        ),
      ],
    );
  }
}
