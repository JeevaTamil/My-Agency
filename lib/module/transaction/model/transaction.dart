class Transaction {
  int? tranctionId;
  int customerId;
  int supplierId;
  String billNumber;
  DateTime orderDate;
  int productQty;
  double billAmount;
  double discountAmount;
  double taxAmount;
  String paymentStatus;

  Transaction({
    this.tranctionId,
    required this.customerId,
    required this.supplierId,
    required this.billNumber,
    required this.productQty,
    required this.orderDate,
    required this.billAmount,
    required this.discountAmount,
    required this.taxAmount,
    required this.paymentStatus,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'customer_id': customerId,
      'supplier_id': supplierId,
      'bill_number': billNumber,
      'order_date': orderDate,
      'product_qty': productQty,
      'bill_amount': billAmount,
      'discount_amount': discountAmount,
      'tax_amount': taxAmount,
      'payment_status': paymentStatus
    };

    if (tranctionId != null) {
      map['transaction_id'] = tranctionId!;
    }

    return map;
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      tranctionId: map['transaction_id'],
      customerId: map['customer_id'],
      supplierId: map['supplier_id'],
      orderDate: DateTime.parse(map['order_date']),
      productQty: map['product_qty'],
      billNumber: map['bill_number'],
      billAmount: map['bill_amount'],
      discountAmount: map['discount_amount'],
      taxAmount: map['tax_amount'],
      paymentStatus: map['payment_status'],
    );
  }
}
