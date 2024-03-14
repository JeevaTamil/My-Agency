import 'package:flutter/material.dart';
import 'package:my_agency/module/customer/model/customer.dart';
import 'package:my_agency/module/customer/cubit/customer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerFormPage extends StatefulWidget {
  final Customer? customer; // Optional parameter to pass a customer for editing

  const CustomerFormPage({super.key, this.customer});

  @override
  _CustomerFormPageState createState() => _CustomerFormPageState();
}

class _CustomerFormPageState extends State<CustomerFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _gstNumberController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer?.name ?? '');
    _addressController =
        TextEditingController(text: widget.customer?.address ?? '');
    _cityController = TextEditingController(text: widget.customer?.city ?? '');
    _phoneNumberController = TextEditingController(
        text: widget.customer?.phoneNumber.toString() ?? '');
    _gstNumberController =
        TextEditingController(text: widget.customer?.gstNumber ?? '');
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

  void _saveCustomer() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final address = _addressController.text;
      final city = _cityController.text;
      final phoneNumber = int.parse(_phoneNumberController.text);
      final gstNumber = _gstNumberController.text;

      if (widget.customer == null) {
        final customer = Customer(
          name: name,
          address: address,
          city: city,
          phoneNumber: phoneNumber,
          gstNumber: gstNumber,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        BlocProvider.of<CustomerCubit>(context).createCustomer(customer);
      } else {
        final customer = Customer(
          id: widget.customer!.id,
          name: name,
          address: address,
          city: city,
          phoneNumber: phoneNumber,
          gstNumber: gstNumber,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        BlocProvider.of<CustomerCubit>(context).updateCustomer(customer);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    widget.customer != null ? 'Edit Customer' : 'Add Customer',
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
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                maxLines: 3,
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _gstNumberController,
                decoration: const InputDecoration(labelText: 'GST Number'),
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
                      onPressed: _saveCustomer,
                      child: Text(widget.customer != null
                          ? 'Save Changes'
                          : 'Add Customer'),
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
