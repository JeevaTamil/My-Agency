import 'package:my_agency/module/bill_inward/model/bill_inward.dart';

class BillInwardWithDetails extends BillInward {
  final String customerName;
  final String supplierName;

  BillInwardWithDetails({
    int? id,
    required int customerId,
    required int supplierId,
    required String billNumber,
    required DateTime billDate,
    required int productQty,
    required double billAmount,
    required String discountType,
    required double discountAmount,
    required double netAmount,
    required String taxType,
    required double taxAmount,
    required double finalBillAmount,
    required String transportName,
    required String lrNumber,
    required DateTime lrDate,
    required int bundleQty,
    String? image,
    required DateTime createdAt,
    required DateTime updatedAt,
    required this.customerName,
    required this.supplierName,
  }) : super(
          id: id,
          customerId: customerId,
          supplierId: supplierId,
          billNumber: billNumber,
          billDate: billDate,
          productQty: productQty,
          billAmount: billAmount,
          discountType: discountType,
          discountAmount: discountAmount,
          netAmount: netAmount,
          taxType: taxType,
          taxAmount: taxAmount,
          finalBillAmount: finalBillAmount,
          transportName: transportName,
          lrNumber: lrNumber,
          lrDate: lrDate,
          bundleQty: bundleQty,
          image: image,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory BillInwardWithDetails.fromMap(Map<String, dynamic> map) {
    return BillInwardWithDetails(
      id: map['id'],
      customerId: map['customer'],
      supplierId: map['supplier'],
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
      image: map['image'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      customerName: map['customerName'],
      supplierName: map['supplierName'],
    );
  }

  BillInward toBillInward() {
    return BillInward(
      customerId: customerId,
      supplierId: supplierId,
      billNumber: billNumber,
      billDate: billDate,
      productQty: productQty,
      billAmount: billAmount,
      discountType: discountType,
      discountAmount: discountAmount,
      netAmount: netAmount,
      taxType: taxType,
      taxAmount: taxAmount,
      finalBillAmount: finalBillAmount,
      transportName: transportName,
      lrNumber: lrNumber,
      lrDate: lrDate,
      bundleQty: bundleQty,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
