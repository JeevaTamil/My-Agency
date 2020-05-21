class SuppliersModel {
  String name;
  String address;
  String city;
  int phone;
  String gst;
  int commission;
  DateTime createdOn = DateTime.now();

  SuppliersModel(
      {this.name,
      this.address,
      this.city,
      this.phone,
      this.gst,
      this.commission,
      this.createdOn});

  factory SuppliersModel.fromMap(Map<String, dynamic> json) {
    return SuppliersModel(
        name: json["name"],
        address: json["address"],
        city: json["city"],
        phone: json["phone"],
        gst: json["gst"],
        commission: json["commission"],
        createdOn: json["created_on"].toDate());
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "address": address,
      "city": city,
      "phone": phone,
      "gst": gst,
      "commission": commission,
      "created_on": createdOn,
      "search_key": name.substring(0, 1).toUpperCase()
    };
  }
}
