import 'dart:convert';

class SalesSummaryModel {
  final Data data;

  SalesSummaryModel({
    required this.data,
  });

  factory SalesSummaryModel.fromRawJson(String str) =>
      SalesSummaryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesSummaryModel.fromJson(Map<String, dynamic> json) =>
      SalesSummaryModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final String totalSales;
  final String avgPerDay;
  final List<double> perDaySales;

  Data({
    required this.totalSales,
    required this.avgPerDay,
    required this.perDaySales,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalSales: json["total_sales"],
        avgPerDay: json["avg_per_day"],
        perDaySales:
            List<double>.from(json["per_day_sales"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "total_sales": totalSales,
        "avg_per_day": avgPerDay,
        "per_day_sales": List<dynamic>.from(perDaySales.map((x) => x)),
      };
}
