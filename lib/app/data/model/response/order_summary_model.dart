import 'dart:convert';

class OrderSummaryModel {
  final Data data;

  OrderSummaryModel({
    required this.data,
  });

  factory OrderSummaryModel.fromRawJson(String str) =>
      OrderSummaryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) =>
      OrderSummaryModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final int delivered;
  final int returned;
  final int canceled;
  final int rejected;

  Data({
    required this.delivered,
    required this.returned,
    required this.canceled,
    required this.rejected,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        delivered: json["delivered"],
        returned: json["returned"],
        canceled: json["canceled"],
        rejected: json["rejected"],
      );

  Map<String, dynamic> toJson() => {
        "delivered": delivered,
        "returned": returned,
        "canceled": canceled,
        "rejected": rejected,
      };
}
