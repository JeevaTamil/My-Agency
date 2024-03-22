class Supplier {
  int? id;
  String name;
  String address;
  String city;
  int phoneNumber;
  String gstNumber;
  int commission;
  DateTime createdAt;
  DateTime updatedAt;

  Supplier({
    this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.gstNumber,
    required this.commission,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'phn_number': phoneNumber,
      'gst_number': gstNumber,
      'commission': commission,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      city: map['city'],
      phoneNumber: map['phn_number'],
      gstNumber: map['gst_number'],
      commission: map['commission'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }
}
