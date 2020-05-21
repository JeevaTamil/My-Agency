class BankModel {
  String name;
  DateTime createdOn = DateTime.now();

  BankModel({this.name, this.createdOn});

  factory BankModel.fromMap(Map<String, dynamic> json) {
    return BankModel(
      name: json['name'],
      createdOn: json['created_on'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'created_on': this.createdOn,
    };
  }
}
