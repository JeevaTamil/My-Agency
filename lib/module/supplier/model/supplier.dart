class Supplier {
  int? supplierId;
  String name;
  String address;
  String city;
  String phoneNumber;
  String gstNumber;
  double commissionPercentage;
  // DateTime createdAt;
  // DateTime updatedAt;

  Supplier({
    this.supplierId,
    required this.name,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.gstNumber,
    required this.commissionPercentage,
    // required this.createdAt,
    // required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    // return {
    //   // 'supplier_id': supplierId,
    //   'name': name,
    //   'address': address,
    //   'city': city,
    //   'phone_number': phoneNumber,
    //   'gst_number': gstNumber,
    //   'commission_percentage': commissionPercentage,
    //   // 'created_at': createdAt.millisecondsSinceEpoch,
    //   // 'updated_at': updatedAt.millisecondsSinceEpoch,
    // };

    final map = {
      'name': name,
      'address': address,
      'city': city,
      'phone_number': phoneNumber,
      'commission_percentage': commissionPercentage,
      'gst_number': gstNumber,
    };

    // Exclude 'id' field if it's null
    if (supplierId != null) {
      map['supplier_id'] = supplierId!;
    }

    return map;
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      supplierId: map['supplier_id'],
      name: map['name'],
      address: map['address'],
      city: map['city'],
      phoneNumber: map['phone_number'],
      gstNumber: map['gst_number'],
      commissionPercentage: map['commission_percentage'],
      // createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      // updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }
}
