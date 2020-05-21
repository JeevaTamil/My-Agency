class PurchaseEntryModel {
  DateTime billDate;
  String billNumber;
  String supplierId;
  double goodsValue;
  int discountPercent;
  int discountValue;
  String taxType;
  String transportId;
  String lrNumber;
  DateTime lrDate;
  int lrFright;
  String bookingStation;
  String customerId;
  DateTime deliveryDate;

  PurchaseEntryModel(
      {this.billDate,
      this.billNumber,
      this.bookingStation,
      this.customerId,
      this.deliveryDate,
      this.discountPercent,
      this.discountValue,
      this.goodsValue,
      this.lrDate,
      this.lrFright,
      this.lrNumber,
      this.supplierId,
      this.taxType,
      this.transportId});

  factory PurchaseEntryModel.fromMap(Map<String, dynamic> json) {
    return PurchaseEntryModel(
        billDate: json["bill_date"],
        billNumber: json["bill_number"],
        supplierId: json["supplier_id"],
        goodsValue: json["goods_value"],
        discountPercent: json["discount_percent"],
        discountValue: json["discount_value"],
        taxType: json["tax_type"],
        transportId: json["trasport_id"],
        lrNumber: json["lr_number"],
        lrDate: json["lr_date"],
        lrFright: json["lr_fright"],
        bookingStation: json["booking_station"],
        customerId: json["customer_id"],
        deliveryDate: json["delivery_date"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "bill_date": billDate,
      "bill_number": billNumber,
      "supplier_id": supplierId,
      "goods_value": goodsValue,
      "discount_percent": discountPercent,
      "discount_value": discountValue,
      "tax_type": taxType,
      "trasport_id": transportId,
      "lr_number": lrNumber,
      "lr_date": lrDate,
      "lr_fright": lrFright,
      "booking_station": bookingStation,
      "customer_id": customerId,
      "delivery_date": deliveryDate
    };
  }
}
