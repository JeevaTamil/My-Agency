class Logistics {
  final int tranctionId;
  final int? logisticId;
  final String transportName;
  final String lrNumber;
  final DateTime lrDate;
  final int bundleQty;

  Logistics({
    required this.tranctionId,
    this.logisticId,
    required this.transportName,
    required this.lrNumber,
    required this.lrDate,
    required this.bundleQty,
  });

  factory Logistics.fromMap(Map<String, dynamic> json) {
    return Logistics(
      tranctionId: json['transaction_id'],
      logisticId: json['logistic_id'],
      transportName: json['transport_name'],
      lrNumber: json['lr_number'],
      lrDate: DateTime.parse(json['lr_date']),
      bundleQty: json['number_of_bundles'],
    );
  }
}
