import 'package:flutter/material.dart';
import 'package:my_agency/helper/views/form_text_field.dart';
import 'package:my_agency/helper/views/form_title.dart';
import 'package:my_agency/helper/views/responsive_list_view.dart';
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
      final phoneNumber = _phoneNumberController.text;
      final gstNumber = _gstNumberController.text;

      if (widget.customer == null) {
        final customer = Customer(
          name: name,
          address: address,
          city: city,
          phoneNumber: phoneNumber,
          gstNumber: gstNumber,
        );

        BlocProvider.of<CustomerCubit>(context).createCustomer(customer);
      } else {
        final customer = Customer(
          customerId: widget.customer!.customerId,
          name: name,
          address: address,
          city: city,
          phoneNumber: phoneNumber,
          gstNumber: gstNumber,
        );

        BlocProvider.of<CustomerCubit>(context).updateCustomer(customer);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FormTitle(
          isEdit: widget.customer != null,
          title: 'Customer',
        ),
        elevation: 20.0,
      ),
      body: ResponsiveListView.single(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                FormTextField(
                  controller: _nameController,
                  labelText: 'Name',
                  isMandatory: true,
                ),
                const SizedBox(height: 16.0),
                FormTextField(
                  controller: _addressController,
                  labelText: 'Address',
                ),
                const SizedBox(height: 16.0),
                FormTextField(
                  controller: _cityController,
                  labelText: 'City',
                  isMandatory: true,
                ),
                const SizedBox(height: 16.0),
                FormTextField(
                  controller: _phoneNumberController,
                  labelText: 'Phone Number',
                  textInputType: TextInputType.phone,
                  isMandatory: true,
                ),
                const SizedBox(height: 16.0),
                FormTextField(
                  controller: _gstNumberController,
                  labelText: 'GST Number',
                  isMandatory: true,
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
      ),
    );
  }
}
