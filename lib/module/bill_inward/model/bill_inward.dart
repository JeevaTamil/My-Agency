class BillInward {
  int? id;
  String customer;
  String supplier;
  String billNumber;
  DateTime billDate;
  int productQty;
  double billAmount;
  String discountType;
  double discountAmount;
  double netAmount;
  String taxType;
  double taxAmount;
  double finalBillAmount;
  String transportName;
  String lrNumber;
  DateTime lrDate;
  int bundleQty;
  // Assuming you will convert the image to a base64 string or similar for Dart
  String? image;
  DateTime createdAt;
  DateTime updatedAt;

  BillInward({
    this.id,
    required this.customer,
    required this.supplier,
    required this.billNumber,
    required this.billDate,
    required this.productQty,
    required this.billAmount,
    required this.discountType,
    required this.discountAmount,
    required this.netAmount,
    required this.taxType,
    required this.taxAmount,
    required this.finalBillAmount,
    required this.transportName,
    required this.lrNumber,
    required this.lrDate,
    required this.bundleQty,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BillInward.fromMap(Map<String, dynamic> map) {
    return BillInward(
      id: map['id'],
      customer: map['customer'],
      supplier: map['supplier'],
      billNumber: map['billNumber'],
      billDate: DateTime.parse(map['billDate']),
      productQty: map['productQty'],
      billAmount: map['billAmount'].toDouble(),
      discountType: map['discountType'],
      discountAmount: map['discountAmount'].toDouble(),
      netAmount: map['netAmount'].toDouble(),
      taxType: map['taxType'],
      taxAmount: map['taxAmount'].toDouble(),
      finalBillAmount: map['finalBillAmount'].toDouble(),
      transportName: map['transportName'],
      lrNumber: map['lrNumber'],
      lrDate: DateTime.parse(map['lrDate']),
      bundleQty: map['bundleQty'],
      image: map['image'], // You may need to handle image conversion separately
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer': customer,
      'supplier': supplier,
      'billNumber': billNumber,
      'billDate': billDate.toIso8601String(),
      'productQty': productQty,
      'billAmount': billAmount,
      'discountType': discountType,
      'discountAmount': discountAmount,
      'netAmount': netAmount,
      'taxType': taxType,
      'taxAmount': taxAmount,
      'finalBillAmount': finalBillAmount,
      'transportName': transportName,
      'LRNumber': lrNumber,
      'LRDate': lrDate.toIso8601String(),
      'bundleQty': bundleQty,
      'image': image, // You may need to handle image conversion separately
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
