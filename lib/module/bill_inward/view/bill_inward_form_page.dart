import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_agency/helper/database/database_helper.dart';
import 'package:my_agency/helper/utils/widget_util/currency_text_input_formatter.dart';
import 'package:my_agency/helper/views/customer_search_dropdown_widget.dart';
import 'package:my_agency/helper/views/date_picker.dart';
import 'package:my_agency/helper/views/form_text_field.dart';
import 'package:my_agency/helper/views/form_title.dart';
import 'package:my_agency/helper/views/supplier_search_dropdown_widget.dart';
import 'package:my_agency/module/bill_inward/cubit/bill_inward_cubit.dart';
import 'package:my_agency/module/bill_inward/model/bill_inward.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BillInwardFormPage extends StatefulWidget {
  final BillInward?
      billInward; // Pass billInward for editing, null for creating

  const BillInwardFormPage({super.key, this.billInward});

  @override
  State<BillInwardFormPage> createState() => _BillInwardFormPageState();
}

class _BillInwardFormPageState extends State<BillInwardFormPage> {
  final _formKey = GlobalKey<FormState>();
  final CurrencyTextInputFormatter _discountValcurrencyTextInputFormatter =
      CurrencyTextInputFormatter(
    locale: 'hi_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  final CurrencyTextInputFormatter _billAmountcurrencyTextInputFormatter =
      CurrencyTextInputFormatter(
    locale: 'hi_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  late int selectedCustomerId = -1;
  late int selectedSupplierId = -1;
  late double _netAmount = 0.00;
  late double _taxAmount = 0.00;
  late double _finalBillAmount = 0.00;

  String selectedDiscountType = '%';
  String selectedTaxType = 'C/S GST 5';

  TextEditingController controller = TextEditingController();
  late TextEditingController _billNumberController;
  late TextEditingController _billDate;
  late TextEditingController _productQty;
  late TextEditingController _billAmount;
  late TextEditingController _discountValue;
  late TextEditingController _transportName;
  late TextEditingController _lrNumber;
  late TextEditingController _lrDate;
  late TextEditingController _bundleQty;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.billInward != null) {
      selectedCustomerId = int.parse(widget.billInward!.customer);
      selectedSupplierId = int.parse(widget.billInward!.supplier);
    }
    _billNumberController =
        TextEditingController(text: widget.billInward?.billNumber ?? '');
    _billDate = TextEditingController(
        text: widget.billInward?.billDate.toString() ?? '');
    _productQty = TextEditingController(
        text: widget.billInward?.productQty.toString() ?? '');
    _billAmount = TextEditingController(
        text: widget.billInward?.billAmount.toString() ?? '');
    _discountValue = TextEditingController(
        text: widget.billInward?.discountAmount.toString() ?? '');
    _transportName = TextEditingController(
        text: widget.billInward?.transportName.toString() ?? '');
    _lrNumber = TextEditingController(
        text: widget.billInward?.lrNumber.toString() ?? '');
    _lrDate =
        TextEditingController(text: widget.billInward?.lrDate.toString() ?? '');
    _bundleQty = TextEditingController(
        text: widget.billInward?.bundleQty.toString() ?? '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _billNumberController.dispose();
    _billDate.dispose();
    _productQty.dispose();
    _billAmount.dispose();
    _discountValue.dispose();
    _transportName.dispose();
    _lrNumber.dispose();
    _lrDate.dispose();
    _bundleQty.dispose();
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
              supplierSelected: (int supplierId) {
                _supplierSelected(supplierId);
              },
            ),
            const SizedBox(height: 16.0),
            CustomerSearchDropDown(
              customerSelected: (int customerId) {
                _customerSelected(customerId);
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: FormTextField(
                    controller: _billNumberController,
                    labelText: 'Bill Number',
                    isMandatory: true,
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
              children: [
                Expanded(
                  child: FormTextField(
                    controller: _productQty,
                    labelText: 'Product Qty',
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.number,
                    isMandatory: true,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: FormTextField(
                    isMandatory: true,
                    controller: _billAmount,
                    labelText: 'Bill Amount',
                    textInputType: TextInputType.number,
                    inputFormatters: [_billAmountcurrencyTextInputFormatter],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Discount Type'),
                      const SizedBox(
                        height: 8,
                      ),
                      SegmentedButton(
                        segments: const [
                          ButtonSegment(
                            value: '%',
                            icon: Icon(Icons.percent_outlined),
                          ),
                          ButtonSegment(
                            value: '₹',
                            icon: Icon(Icons.currency_rupee),
                          ),
                        ],
                        selected: <String>{selectedDiscountType},
                        onSelectionChanged: (value) {
                          setState(() {
                            selectedDiscountType = value.first;
                            _discountValue.text = '';
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: FormTextField(
                    isMandatory: true,
                    maxLength: selectedDiscountType == '%' ? 1 : 15,
                    controller: _discountValue,
                    labelText: 'Discount Value',
                    textInputType: TextInputType.number,
                    inputFormatters: selectedDiscountType == '%'
                        ? []
                        : [_discountValcurrencyTextInputFormatter],
                    onChanged: (value) {
                      setState(() {
                        _amountCalculation(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text('Net Amount'),
                const Spacer(),
                Expanded(child: Text('₹ $_netAmount'))
              ],
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('Tax Type'),
                      const SizedBox(
                        height: 8,
                      ),
                      SegmentedButton(
                        segments: const [
                          ButtonSegment(
                            value: 'C/S GST 5',
                            label: Text('C/S GST 5'),
                          ),
                          ButtonSegment(
                            value: 'I GST 5',
                            label: Text('I GST 5'),
                          ),
                          ButtonSegment(
                            value: 'I GST 12',
                            label: Text('I GST 12'),
                          ),
                        ],
                        selected: <String>{selectedTaxType},
                        onSelectionChanged: (value) {
                          setState(() {
                            selectedTaxType = value.first;
                            _taxCalculation();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text('₹ $_taxAmount'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text('Final Bill Amount'),
                const Spacer(),
                Expanded(child: Text('₹ $_finalBillAmount'))
              ],
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            FormTextField(
              controller: _transportName,
              labelText: 'Transport Name',
              isMandatory: true,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: FormTextField(
                    controller: _lrNumber,
                    labelText: 'LR Number',
                    isMandatory: true,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: DatePicker(
                    controller: _lrDate,
                    labelText: 'LR Date',
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: FormTextField(
                    controller: _bundleQty,
                    labelText: 'Bundle Qty',
                    isMandatory: true,
                    textInputType: TextInputType.number,
                    maxLength: 2,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
            ),
          ],
        ),
      ),
    );
  }

  void _saveBillInward() async {
    bool isCustomerSelected = selectedCustomerId != -1;
    bool isSupplierSelected = selectedSupplierId != -1;
    if (_formKey.currentState!.validate() &&
        isSupplierSelected &&
        isCustomerSelected) {
      print('validated');
      print('selectedCustomerId $selectedCustomerId');
      print('selectedSupplierId $selectedSupplierId');
      print(_billNumberController.text);
      print(_billAmount.text);
      print(_productQty.text);
      print(_billAmount.text);
      print(selectedDiscountType);
      print(_discountValue.text);
      print(_netAmount);
      print(selectedTaxType);
      print(_taxAmount);
      print(_finalBillAmount);

      if (widget.billInward == null) {
        final billInward = BillInward(
          customer: selectedCustomerId.toString(),
          supplier: selectedCustomerId.toString(),
          billNumber: _billNumberController.text,
          billDate: DateFormat('dd-MM-yyyy').parse(_billDate.text),
          productQty: int.parse(_productQty.text),
          billAmount: _billAmountcurrencyTextInputFormatter
              .getUnformattedValue()
              .toDouble(),
          discountType: selectedDiscountType,
          discountAmount: _discountValcurrencyTextInputFormatter
              .getUnformattedValue()
              .toDouble(),
          netAmount: _netAmount,
          taxType: selectedTaxType,
          taxAmount: _taxAmount,
          finalBillAmount: _finalBillAmount,
          transportName: _transportName.text,
          lrNumber: _lrNumber.text,
          lrDate: DateFormat('dd-MM-yyyy').parse(_lrDate.text),
          bundleQty: int.parse(_bundleQty.text),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        print(billInward);

        BlocProvider.of<BillInwardCubit>(context).createBillInward(billInward);
      } else {}
    } else {
      print('validation failed');
    }
    Navigator.pop(context);
  }

  void _customerSelected(int customerId) {
    setState(() {
      selectedCustomerId = customerId;
    });
  }

  void _supplierSelected(int supplierId) {
    setState(() {
      selectedSupplierId = supplierId;
    });
  }

  void _amountCalculation(String discountValue) {
    double netAmount = 0;
    try {
      double billAmount = _billAmountcurrencyTextInputFormatter
          .getUnformattedValue()
          .toDouble();
      double discount = 0.00;
      if (selectedDiscountType == '%') {
        discount = ((double.parse(discountValue) * billAmount) / 100);
      } else {
        discount = _discountValcurrencyTextInputFormatter
            .getUnformattedValue()
            .toDouble();
      }
      netAmount = billAmount - discount;
    } catch (FormatException) {
      //print(e);
    }
    _netAmount = netAmount;

    if ((selectedTaxType == 'C/S GST 5') || (selectedTaxType == 'I GST 5')) {
      _taxAmount = ((_netAmount * 5) / 100);
    } else {
      _taxAmount = ((_netAmount * 12) / 100);
    }
    _finalBillAmount = _netAmount + _taxAmount;
  }

  void _taxCalculation() {
    if ((selectedTaxType == 'C/S GST 5') || (selectedTaxType == 'I GST 5')) {
      _taxAmount = ((_netAmount * 5) / 100);
    } else {
      _taxAmount = ((_netAmount * 12) / 100);
    }
    _finalBillAmount = _netAmount + _taxAmount;
  }
}
