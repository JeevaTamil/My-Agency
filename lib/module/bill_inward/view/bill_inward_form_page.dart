import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_agency/helper/views/customer_search_dropdown_widget.dart';
import 'package:my_agency/helper/views/date_picker.dart';
import 'package:my_agency/helper/views/form_text_field.dart';
import 'package:my_agency/helper/views/form_title.dart';
import 'package:my_agency/helper/views/supplier_search_dropdown_widget.dart';
import 'package:my_agency/module/bill_inward/model/bill_inward.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:my_agency/module/supplier/cubit/supplier_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BillInwardFormPage extends StatefulWidget {
  final BillInward?
      billInward; // Pass billInward for editing, null for creating

  const BillInwardFormPage({Key? key, this.billInward}) : super(key: key);

  @override
  State<BillInwardFormPage> createState() => _BillInwardFormPageState();
}

class _BillInwardFormPageState extends State<BillInwardFormPage> {
  final _formKey = GlobalKey<FormState>();

  OptionItem supplierOptionItemSelected = OptionItem(title: "Select Supplier");
  OptionItem customerOptionItemSelected = OptionItem(title: "Select Customer");

  TextEditingController controller = TextEditingController();
  late TextEditingController _billNumberController;
  late TextEditingController _billDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _billNumberController =
        TextEditingController(text: widget.billInward?.billNumber ?? '');
    _billDate = TextEditingController(
        text: widget.billInward?.billDate.toString() ?? '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _billNumberController.dispose();
    _billDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            FormTitle(
              isEdit: widget.billInward != null,
              title: 'Bill Inward',
            ),
            SupplierSearchDropDown(
                optionItemSelected: supplierOptionItemSelected),
            const SizedBox(height: 16.0),
            CustomerSearchDropDown(
                optionItemSelected: customerOptionItemSelected),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: FormTextField(
                    controller: _billNumberController,
                    labelText: 'Bill Number',
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: DatePicker(
                    controller: _billDate,
                    labelText: 'Bill Date',
                  ),
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
                    onPressed: _saveBillInward,
                    child: Text(widget.billInward != null
                        ? 'Save Bill Inward'
                        : 'Add Bill Inward'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _saveBillInward() async {
    if (_formKey.currentState!.validate()) {
      print('validated');
    } else {
      print('validation failed');
    }
  }
}
