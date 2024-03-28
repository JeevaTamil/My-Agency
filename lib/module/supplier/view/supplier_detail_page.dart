import 'package:flutter/material.dart';
import 'package:my_agency/module/supplier/model/supplier.dart';

class SupplierDetailPage extends StatelessWidget {
  final Supplier supplier;

  const SupplierDetailPage({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Supplier Details',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Name: ${supplier.name}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Address: ${supplier.address}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'City: ${supplier.city}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Phone Number: ${supplier.phoneNumber}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'GST Number: ${supplier.gstNumber}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'))
        ],
      ),
    );
  }
}
