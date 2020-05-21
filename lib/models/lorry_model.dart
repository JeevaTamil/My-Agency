class LorryModel {
  String name;
  DateTime createdOn = DateTime.now();

  LorryModel({this.name, this.createdOn});

  factory LorryModel.fromMap(Map<String, dynamic> json) {
    return LorryModel(
      name: json['name'],
      createdOn: json['created_on'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': this.name, 'created_on': this.createdOn};
  }
}
