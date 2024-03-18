import 'package:flutter/material.dart';
import 'package:my_agency/module/supplier/model/supplier.dart';
import 'package:my_agency/module/supplier/cubit/supplier_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupplierFormPage extends StatefulWidget {
  final Supplier? supplier; // Optional parameter to pass a supplier for editing

  const SupplierFormPage({super.key, this.supplier});

  @override
  _SupplierFormPageState createState() => _SupplierFormPageState();
}

class _SupplierFormPageState extends State<SupplierFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _gstNumberController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.supplier?.name ?? '');
    _addressController =
        TextEditingController(text: widget.supplier?.address ?? '');
    _cityController = TextEditingController(text: widget.supplier?.city ?? '');
    _phoneNumberController = TextEditingController(
        text: widget.supplier?.phoneNumber.toString() ?? '');
    _gstNumberController =
        TextEditingController(text: widget.supplier?.gstNumber ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _phoneNumberController.dispose();
    _gstNumberController.dispose();
    super.dispose();
  }

  void _saveSupplier() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final address = _addressController.text;
      final city = _cityController.text;
      final phoneNumber = int.parse(_phoneNumberController.text);
      final gstNumber = _gstNumberController.text;

      if (widget.supplier == null) {
        final supplier = Supplier(
          name: name,
          address: address,
          city: city,
          phoneNumber: phoneNumber,
          gstNumber: gstNumber,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        BlocProvider.of<SupplierCubit>(context).createSupplier(supplier);
      } else {
        final supplier = Supplier(
          id: widget.supplier!.id,
          name: name,
          address: address,
          city: city,
          phoneNumber: phoneNumber,
          gstNumber: gstNumber,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        BlocProvider.of<SupplierCubit>(context).updateSupplier(supplier);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    widget.supplier != null ? 'Edit Supplier' : 'Add Supplier',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close_rounded)),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                maxLines: 3,
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _gstNumberController,
                decoration: const InputDecoration(
                  labelText: 'GST Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a GST number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _saveSupplier,
                      child: Text(widget.supplier != null
                          ? 'Save Changes'
                          : 'Add Supplier'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
