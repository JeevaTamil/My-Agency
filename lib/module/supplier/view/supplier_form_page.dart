import 'package:flutter/material.dart';
import 'package:my_agency/helper/views/form_text_field.dart';
import 'package:my_agency/helper/views/form_title.dart';
import 'package:my_agency/module/supplier/model/supplier.dart';
import 'package:my_agency/module/supplier/cubit/supplier_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List<String> _commisionOptionItems = <String>['2', '3', '4', '5'];

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

  int _commissionPercentage = int.parse(_commisionOptionItems.first);

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
          commission: _commissionPercentage,
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
          commission: _commissionPercentage,
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
              FormTitle(
                isEdit: widget.supplier != null,
                title: 'Supplier',
              ),
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
                textInputType: TextInputType.streetAddress,
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
                children: [
                  const Expanded(
                    child: Text('Agent Commission Percentage'),
                  ),
                  DropdownButton(
                    // icon: const Icon(Icons.percent),
                    decoration: const InputDecoration(
  border: OutlineInputBorder(),
),
                    value: _commissionPercentage.toString(),
                    items: _commisionOptionItems
                        .map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          _commissionPercentage = int.parse(value);
                        }
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('%'),
                  ),
                ],
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
