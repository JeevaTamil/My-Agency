class Customer {
  int? customerId;
  String name;
  String address;
  String city;
  String phoneNumber;
  String gstNumber;

  Customer({
    this.customerId,
    required this.name,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.gstNumber,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'address': address,
      'city': city,
      'phone_number': phoneNumber,
      'gst_number': gstNumber,
    };

    // Exclude 'id' field if it's null
    if (customerId != null) {
      map['customer_id'] = customerId!;
    }

    return map;
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      customerId: map['customer_id'],
      name: map['name'],
      address: map['address'],
      city: map['city'],
      phoneNumber: map['phone_number'],
      gstNumber: map['gst_number'],
    );
  }
}
