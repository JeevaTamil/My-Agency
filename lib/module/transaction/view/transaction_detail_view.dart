import 'package:flutter/material.dart';
import 'package:my_agency/helper/utils/util_methods.dart';
import 'package:my_agency/module/transaction/model/transaction_info.dart';

class TransactionDetailView extends StatefulWidget {
  const TransactionDetailView({super.key, required this.transactionInfo});
  final TransactionInfo transactionInfo;

  @override
  State<TransactionDetailView> createState() => _TransactionDetailViewState();
}

class _TransactionDetailViewState extends State<TransactionDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 20.0,
          title: const Text('Transaction Detail'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _customerAndSupplierDetails(context),
              const Divider(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: [
                        _cardRowItem(
                            'Bill Number', widget.transactionInfo.billNumber),
                        _cardRowItem(
                            'Bill Date',
                            Utils.dateTimeToString(
                                widget.transactionInfo.orderDate,
                                'dd/MM/yyyy')),
                        _cardRowItem('Bill Amount',
                            widget.transactionInfo.billAmount.toString()),
                        _cardRowItem('Tax Amount',
                            widget.transactionInfo.taxAmount.toString()),
                        _cardRowItem('Discount Amount',
                            widget.transactionInfo.discountAmount.toString()),
                        _cardRowItem(
                            'Total Amount',
                            (widget.transactionInfo.billAmount +
                                    widget.transactionInfo.taxAmount -
                                    widget.transactionInfo.discountAmount)
                                .toStringAsFixed(2)),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _cardRowItem('Transport Name',
                          widget.transactionInfo.transportName),
                      _cardRowItem(
                          'LR Number', widget.transactionInfo.lrNumber),
                      _cardRowItem(
                          'LR Date',
                          Utils.dateTimeToString(
                              widget.transactionInfo.lrDate, 'dd/MM/yyyy')),
                      _cardRowItem('Bundle Qty',
                          widget.transactionInfo.bundleQty.toString()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Row _cardRowItem(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Theme.of(context).colorScheme.tertiary),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ],
    );
  }

  Widget _customerAndSupplierDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Supplier',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
              const SizedBox(height: 10.0),
              Text(
                widget.transactionInfo.supplierName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Text(widget.transactionInfo.supplierCity),
            ],
          ),
          const Spacer(),
          const Icon(Icons.local_shipping),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
              const SizedBox(height: 10.0),
              Text(
                widget.transactionInfo.customerName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Text(widget.transactionInfo.customerCity),
            ],
          )
        ],
      ),
    );
  }
}
