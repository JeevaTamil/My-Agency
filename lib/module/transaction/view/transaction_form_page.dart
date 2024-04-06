import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_agency/helper/utils/util_methods.dart';
import 'package:my_agency/helper/views/currency_text_input_formatter.dart';
import 'package:my_agency/helper/views/date_picker.dart';
import 'package:my_agency/helper/views/form_text_field.dart';
import 'package:my_agency/helper/views/form_title.dart';
import 'package:my_agency/helper/views/responsive_list_view.dart';
import 'package:my_agency/module/customer/model/customer.dart';
import 'package:my_agency/module/customer/view/customer_listing_page.dart';
import 'package:my_agency/module/logistic/model/logistic.dart';
import 'package:my_agency/module/supplier/model/supplier.dart';
import 'package:my_agency/module/supplier/view/supplier_listing_page.dart';
import 'package:my_agency/module/transaction/cubit/transaction_cubit.dart';
import 'package:my_agency/module/transaction/model/transaction.dart';
import 'package:my_agency/module/transaction/model/transaction_info.dart';

class TransactionFormPage extends StatefulWidget {
  final TransactionInfo? transactionInfo;
  const TransactionFormPage({super.key, this.transactionInfo});

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
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

  final _scrollController = new ScrollController();

  String selectedDiscountType = '%';
  String selectedTaxType = 'C/S GST 5';

  late double _discountAmount = 0.00;
  late double _netAmount = 0.00;
  late double _taxAmount = 0.00;
  late double _finalBillAmount = 0.00;
  late double _billAmount = 0.00;

  late Supplier _selectedSupplier;
  late Customer _selectedCustomer;
  late TextEditingController _supplierController;
  late TextEditingController _customerController;
  late TextEditingController _billNumberController;
  late TextEditingController _billDateController;
  late TextEditingController _productQtyController;
  late TextEditingController _billAmountController;
  late TextEditingController _discountValueController;
  late TextEditingController _transportNameController;
  late TextEditingController _lrNumberController;
  late TextEditingController _lrDateController;
  late TextEditingController _bundleQtyController;

  late Transaction? createdTransaction;
  late Logistics createdLogistics;

  @override
  void initState() {
    super.initState();
    createdTransaction = null;
    _supplierController =
        TextEditingController(text: widget.transactionInfo?.supplierName ?? '');
    _customerController =
        TextEditingController(text: widget.transactionInfo?.customerName ?? '');
    _billNumberController =
        TextEditingController(text: widget.transactionInfo?.billNumber ?? '');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedBillDate =
        formatter.format(widget.transactionInfo?.orderDate ?? DateTime.now());
    _billDateController = TextEditingController(text: formattedBillDate);
    _productQtyController = TextEditingController(
        text: widget.transactionInfo?.productQty.toString() ?? '');
    _billAmountController = TextEditingController(
        text: widget.transactionInfo?.billAmount.toString() ?? '');
    _discountValueController = TextEditingController(
        text: widget.transactionInfo?.discountAmount.toString() ?? '');
    _transportNameController = TextEditingController(
        text: widget.transactionInfo?.transportName ?? '');
    _lrNumberController =
        TextEditingController(text: widget.transactionInfo?.lrNumber ?? '');
    final String formattedlrDate =
        formatter.format(widget.transactionInfo?.lrDate ?? DateTime.now());
    _lrDateController = TextEditingController(text: formattedlrDate);
    _bundleQtyController =
        TextEditingController(text: widget.transactionInfo?.lrNumber ?? '');

    // For Edit Transaction
    // if (widget.transactionInfo != null) {
    //   _supplierController.text = widget.transactionInfo!.supplierName;
    //   _customerController.text = widget.transactionInfo!.customerName;
    // }
  }

  void _saveTransaction() {
    if (widget.transactionInfo != null) {
      final updatedTransaction = Transaction(
          tranctionId: widget.transactionInfo!.transactionId,
          customerId: _selectedCustomer.customerId!,
          supplierId: _selectedSupplier.supplierId!,
          billNumber: _billNumberController.text,
          productQty: int.parse(_productQtyController.text),
          orderDate: DateTime.parse(_billDateController.text),
          billAmount: double.parse(_billAmountController.text),
          discountAmount: _discountAmount,
          taxAmount: _taxAmount,
          paymentStatus: widget.transactionInfo!.paymentStatus);
      BlocProvider.of<TransactionCubit>(context)
          .updateTransaction(updatedTransaction);
    } else {
      if (createdTransaction == null) {
        final newTransaction = Transaction(
            customerId: _selectedCustomer.customerId!,
            supplierId: _selectedSupplier.supplierId!,
            billNumber: _billNumberController.text,
            productQty: int.parse(_productQtyController.text),
            orderDate: _billDateController.text == Utils.getCurrentDate()
                ? DateTime.now()
                : Utils.parseDate(_billDateController.text, 'dd-MM-yyyy'),
            billAmount: _billAmount,
            discountAmount: _discountAmount,
            taxAmount: _taxAmount,
            paymentStatus: "unpaid");
        BlocProvider.of<TransactionCubit>(context)
            .createTransaction(newTransaction)
            .then((value) => createdTransaction = value);
      }
    }
    setState(() {
      _currentStep += 1;
    });
  }

  void _saveLogistics() {
    if (widget.transactionInfo != null) {
      final toBeUpdatedLogistics = Logistics(
        tranctionId: widget.transactionInfo!.logisticId,
        transportName: _transportNameController.text,
        lrNumber: _lrNumberController.text,
        lrDate: _lrDateController.text == Utils.getCurrentDate()
            ? DateTime.now()
            : Utils.parseDate(_lrDateController.text, 'dd-MM-yyyy'),
        bundleQty: int.parse(_bundleQtyController.text),
      );
    } else {
      if (createdTransaction != null) {
        final newLogistics = Logistics(
          tranctionId: createdTransaction!.tranctionId!,
          transportName: _transportNameController.text,
          lrNumber: _lrNumberController.text,
          lrDate: _lrDateController.text == Utils.getCurrentDate()
              ? DateTime.now()
              : Utils.parseDate(_lrDateController.text, 'dd-MM-yyyy'),
          bundleQty: int.parse(_bundleQtyController.text),
        );

        BlocProvider.of<TransactionCubit>(context)
            .createLogistics(newLogistics)
            .then((value) => createdLogistics = value);
      }
    }
    Navigator.pop(context);
  }

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FormTitle(
            isEdit: widget.transactionInfo != null, title: "Transaction"),
        elevation: 20.0,
      ),
      body: ResponsiveListView.single(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stepper(
              connectorColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.inversePrimary),
              controller: _scrollController,
              elevation: 10.0,
              connectorThickness: 3.0,
              type: StepperType.vertical,
              currentStep: _currentStep,
              onStepContinue: () {
                final isLastStep = _currentStep == _getsteps().length - 1;
                if (!isLastStep) {
                  setState(() {
                    _currentStep += 1;
                  });
                }
              },
              onStepCancel: () =>
                  _currentStep == 0 ? null : setState(() => _currentStep -= 1),
              onStepTapped: (value) => setState(() => _currentStep = value),
              steps: _getsteps(),
              controlsBuilder: (context, details) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: [
                      _saveTransactionButtonHandling(details.onStepContinue),
                      const SizedBox(
                        width: 16.0,
                      ),
                      if (_currentStep != 0)
                        ElevatedButton(
                            onPressed: details.onStepCancel,
                            child: const Text('Cancel')),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Step _billInfoStep() {
    return Step(
        title: const Text('Bill Info'),
        content: Column(
          children: [
            const SizedBox(
              height: 16.0,
            ),
            FormTextField(
              controller: _billNumberController,
              labelText: 'Bill Number',
              isMandatory: true,
            ),
            const SizedBox(
              height: 16.0,
            ),
            DatePicker(
              controller: _billDateController,
              labelText: 'Bill Date',
            ),
            const SizedBox(
              height: 16.0,
            ),
            FormTextField(
              controller: _productQtyController,
              labelText: 'Product Qty',
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputType: TextInputType.number,
              isMandatory: true,
            ),
          ],
        ));
  }

  Widget _saveTransactionButtonHandling(Function()? onStepContinue) {
    if (_currentStep == 2) {
      return ElevatedButton(
          onPressed: () {
            _saveTransaction();
          },
          child: const Text('Save'));
    } else if (_currentStep == _getsteps().length - 1) {
      return ElevatedButton(
          onPressed: () {
            _saveLogistics();
          },
          child: const Text('Save'));
    } else {
      return ElevatedButton(
          onPressed: onStepContinue, child: const Text('Next'));
    }
  }

  Step _transactionStep() {
    return Step(
      title: const Text("Transaction"),
      content: Column(
        children: [
          const SizedBox(
            height: 16.0,
          ),
          _supplierField(),
          const SizedBox(
            height: 16.0,
          ),
          _customerField(),
        ],
      ),
    );
  }

  TextField _supplierField() {
    return TextField(
      controller: _supplierController,
      decoration: const InputDecoration(
        labelText: 'Select Supplier',
        border: OutlineInputBorder(),
        counterText: "",
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SupplierListingPage(
              selectedSupplier: (supplier) {
                setState(() {
                  _selectedSupplier = supplier;
                  _supplierController.text = _selectedSupplier.name;
                  Navigator.pop(context);
                });
              },
              isFormField: true,
            ),
          ),
        );
      },
    );
  }

  TextField _customerField() {
    return TextField(
      controller: _customerController,
      decoration: const InputDecoration(
        labelText: 'Select Customer',
        border: OutlineInputBorder(),
        counterText: "",
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CustomerListingPage(
                    selectedCustomer: (customer) {
                      setState(() {
                        _selectedCustomer = customer;
                        _customerController.text = _selectedCustomer.name;
                        Navigator.pop(context);
                      });
                    },
                    isFormField: true,
                  )),
        );
      },
    );
  }

  List<Step> _getsteps() {
    return [
      _transactionStep(),
      _billInfoStep(),
      _amountStep(),
      Step(
          title: const Text('Transport'),
          content: Column(
            children: [
              FormTextField(
                controller: _transportNameController,
                labelText: 'Transport Name',
                isMandatory: true,
              ),
              const SizedBox(height: 16.0),
              FormTextField(
                controller: _lrNumberController,
                labelText: 'LR Number',
                isMandatory: true,
              ),
              const SizedBox(height: 16.0),
              DatePicker(
                controller: _lrDateController,
                labelText: 'LR Date',
              ),
              const SizedBox(height: 16.0),
              FormTextField(
                controller: _bundleQtyController,
                labelText: 'Bundle Qty',
                isMandatory: true,
                textInputType: TextInputType.number,
                maxLength: 2,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ],
          )),
    ];
  }

  Step _amountStep() {
    return Step(
      title: const Text('Amount'),
      content: Column(
        children: [
          const SizedBox(
            height: 16.0,
          ),
          FormTextField(
            isMandatory: true,
            controller: _billAmountController,
            labelText: 'Bill Amount',
            textInputType: TextInputType.number,
            inputFormatters: [_billAmountcurrencyTextInputFormatter],
            onChanged: (p0) {
              setState(() {
                _amountCalculation(_discountValueController.text);
              });
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text('Discount Type'),
                      ),
                      const Spacer(),
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
                            _discountValueController.text = '';
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  FormTextField(
                    isMandatory: true,
                    maxLength: selectedDiscountType == '%' ? 1 : 15,
                    controller: _discountValueController,
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
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              const Text('Net Amount'),
              const Spacer(),
              Text('₹ $_netAmount'),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text('Tax Type'),
                  ),
                  const SizedBox(
                    height: 16,
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
                  const SizedBox(
                    height: 16.0,
                  ),
                  const SizedBox(width: 16.0),
                  Text('₹ ${_taxAmount.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Text('Final Bill Amount'),
              const Spacer(),
              Text('₹ ${_finalBillAmount.toStringAsFixed(2)}'),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }

  void _amountCalculation(String discountValue) {
    try {
      _billAmount = _billAmountcurrencyTextInputFormatter
          .getUnformattedValue()
          .toDouble();
      if (selectedDiscountType == '%') {
        _discountAmount = ((double.parse(discountValue) * _billAmount) / 100);
      } else {
        _discountAmount = _discountValcurrencyTextInputFormatter
            .getUnformattedValue()
            .toDouble();
      }
      _netAmount = _billAmount - _discountAmount;
    } on FormatException catch (_, e) {
      _netAmount = _billAmount;
      print(e);
    }

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
