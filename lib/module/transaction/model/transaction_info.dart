import 'package:my_agency/module/logistic/model/logistic.dart';
import 'package:my_agency/module/transaction/model/transaction.dart';

class TransactionInfo {
  final int transactionId;
  final int customerId;
  final int supplierId;
  final DateTime orderDate;
  final String billNumber;
  final int productQty;
  final double billAmount;
  final double discountAmount;
  final double taxAmount;
  final String paymentStatus;
  final String customerName;
  final String customerCity;
  final String supplierName;
  final String supplierCity;
  final int logisticId;
  final String transportName;
  final String lrNumber;
  final DateTime lrDate;
  final int bundleQty;

  TransactionInfo({
    required this.transactionId,
    required this.customerId,
    required this.supplierId,
    required this.orderDate,
    required this.billNumber,
    required this.productQty,
    required this.billAmount,
    required this.discountAmount,
    required this.taxAmount,
    required this.paymentStatus,
    required this.customerName,
    required this.customerCity,
    required this.supplierName,
    required this.supplierCity,
    required this.logisticId,
    required this.transportName,
    required this.lrNumber,
    required this.lrDate,
    required this.bundleQty,
  });

  factory TransactionInfo.fromMap(Map<String, dynamic> json) {
    print(json);

    return TransactionInfo(
      transactionId: json['transaction_id'],
      customerId: json['customer_id'],
      supplierId: json['supplier_id'],
      orderDate: DateTime.parse(json['order_date']),
      billNumber: json['bill_number'],
      productQty: json['product_qty'],
      billAmount: json['bill_amount'],
      discountAmount: json['discount_amount'],
      taxAmount: json['tax_amount'],
      paymentStatus: json['payment_status'],
      customerName: json['customer_name'],
      customerCity: json['customer_city'],
      supplierName: json['supplier_name'],
      supplierCity: json['supplier_city'],
      logisticId: json['logistic_id'],
      transportName: json['transport_name'],
      lrNumber: json['lr_number'],
      lrDate: DateTime.parse(json['lr_date']),
      bundleQty: json['number_of_bundles'],
    );
  }

  Transaction toTransaction() {
    return Transaction(
      tranctionId: transactionId,
      customerId: customerId,
      supplierId: supplierId,
      orderDate: orderDate,
      productQty: productQty,
      billNumber: billNumber,
      billAmount: billAmount,
      discountAmount: discountAmount,
      taxAmount: taxAmount,
      paymentStatus: paymentStatus,
    );
  }

  Logistics toLogistic() {
    return Logistics(
      tranctionId: transactionId,
      logisticId: logisticId,
      transportName: transportName,
      lrNumber: lrNumber,
      lrDate: lrDate,
      bundleQty: bundleQty,
    );
  }
}
