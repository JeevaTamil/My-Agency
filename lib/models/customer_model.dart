class CustomersModel {
  String name;
  String address;
  String city;
  int phone;
  String gst;
  int maxDueDate;
  DateTime createdOn = DateTime.now();

  CustomersModel(
      {this.name,
      this.address,
      this.city,
      this.phone,
      this.gst,
      this.maxDueDate,
      this.createdOn});

  factory CustomersModel.fromMap(Map<String, dynamic> json) {
    return CustomersModel(
        name: json["name"],
        address: json["address"],
        city: json["city"],
        phone: json["phone"],
        gst: json["gst"],
        maxDueDate: json["max_due_date"],
        createdOn: json["created_on"].toDate());
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "address": address,
      "city": city,
      "phone": phone,
      "gst": gst,
      "max_due_date": maxDueDate,
      "created_on": createdOn
    };
  }
}
