import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_agency/helper/utils/widget_util/currency_text_input_formatter.dart';
import 'package:my_agency/helper/views/customer_search_dropdown_widget.dart';
import 'package:my_agency/helper/views/date_picker.dart';
import 'package:my_agency/helper/views/form_text_field.dart';
import 'package:my_agency/helper/views/form_title.dart';
import 'package:my_agency/helper/views/supplier_search_dropdown_widget.dart';
import 'package:my_agency/module/bill_inward/model/bill_inward.dart';
import 'package:flutter/services.dart';

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

  String selectedDiscountType = '%';

  TextEditingController controller = TextEditingController();
  late TextEditingController _billNumberController;
  late TextEditingController _billDate;
  late TextEditingController _productQty;
  late TextEditingController _billAmount;
  late TextEditingController _discountValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                        _getNetAmount(value);
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
                Text('Net Amount'),
                Spacer(),
                Expanded(child: Text('₹' + _netAmount.toString()))
              ],
            ),
            const SizedBox(height: 16.0),
            const Divider(),
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
      print(_billAmount.text);
    } else {
      print('validation failed');
    }
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

  void _getNetAmount(String discountValue) {
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
  }
}
