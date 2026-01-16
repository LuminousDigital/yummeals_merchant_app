// To parse this JSON data, do
//
//     final statisticsModel = statisticsModelFromJson(jsonString);

import 'dart:convert';

StatisticsModel statisticsModelFromJson(String str) =>
    StatisticsModel.fromJson(json.decode(str));

String statisticsModelToJson(StatisticsModel data) =>
    json.encode(data.toJson());

class StatisticsModel {
  final Data data;

  StatisticsModel({
    required this.data,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) =>
      StatisticsModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final int totalOrder;
  final int pendingOrder;
  final int preparingOrder;
  final int acceptOrder;
  final int preparedOrder;
  final int outForDeliveryOrder;
  final int deliveredOrder;
  final int canceledOrder;
  final int returnedOrder;
  final int rejectedOrder;

  Data({
    required this.totalOrder,
    required this.pendingOrder,
    required this.preparingOrder,
    required this.acceptOrder,
    required this.preparedOrder,
    required this.outForDeliveryOrder,
    required this.deliveredOrder,
    required this.canceledOrder,
    required this.returnedOrder,
    required this.rejectedOrder,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalOrder: json["total_order"],
        pendingOrder: json["pending_order"],
        preparingOrder: json["preparing_order"],
        acceptOrder: json["accept_order"],
        preparedOrder: json["prepared_order"],
        outForDeliveryOrder: json["out_for_delivery_order"],
        deliveredOrder: json["delivered_order"],
        canceledOrder: json["canceled_order"],
        returnedOrder: json["returned_order"],
        rejectedOrder: json["rejected_order"],
      );

  Map<String, dynamic> toJson() => {
        "total_order": totalOrder,
        "pending_order": pendingOrder,
        "preparing_order": preparingOrder,
        "accept_order": acceptOrder,
        "prepared_order": preparedOrder,
        "out_for_delivery_order": outForDeliveryOrder,
        "delivered_order": deliveredOrder,
        "canceled_order": canceledOrder,
        "returned_order": returnedOrder,
        "rejected_order": rejectedOrder,
      };
}
