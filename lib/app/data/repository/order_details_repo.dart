import 'package:dio/dio.dart';
import 'package:foodking_admin/app/data/model/response/deliveryboy_model.dart';
import 'package:foodking_admin/app/data/model/response/order_details_model.dart';
import 'package:get_storage/get_storage.dart';

import '../../../util/api-list.dart';
import '../api/server.dart';

class OrderDetailsRepo {
  static Future<BaseOptions> getBasseOptionsWithToken() async {
    final Store = GetStorage();
    var token = Store.read('token');
    BaseOptions options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "x-api-key": APIList.licenseCode.toString(),
        'Authorization': token,
      },
    );

    return options;
  }

  static Server server = Server();

  static Future<OrderDetailsModel> getOrderDetails({required int id}) async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());
    String url = APIList.orderDetails.toString() + "${id.toString()}";
    try {
      response = await dio.get(url);
      // Log full response to inspect for UUID or related identifier in payload
      try {
        print('[OrderDetailsRepo.getOrderDetails] URL: ' + url);
        print(
          '[OrderDetailsRepo.getOrderDetails] Status: ' +
              response.statusCode.toString(),
        );
        print(
          '[OrderDetailsRepo.getOrderDetails] Response: ' +
              response.data.toString(),
        );
      } catch (e) {
        print(
          '[OrderDetailsRepo.getOrderDetails] Logging error: ' + e.toString(),
        );
      }
      if (response.statusCode == 200) {
        return OrderDetailsModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return OrderDetailsModel.fromJson(response.data);
  }

  static Future<OrderDetailsModel> getOrderDetailsByUuid({
    required String uuid,
  }) async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());
    String url = APIList.orderDetails.toString() + uuid;
    try {
      response = await dio.get(url);
      try {
        print('[OrderDetailsRepo.getOrderDetailsByUuid] URL: ' + url);
        print(
          '[OrderDetailsRepo.getOrderDetailsByUuid] Status: ' +
              response.statusCode.toString(),
        );
        print(
          '[OrderDetailsRepo.getOrderDetailsByUuid] Response: ' +
              response.data.toString(),
        );
      } catch (e) {
        print(
          '[OrderDetailsRepo.getOrderDetailsByUuid] Logging error: ' +
              e.toString(),
        );
      }
      if (response.statusCode == 200) {
        return OrderDetailsModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return OrderDetailsModel.fromJson(response.data);
  }

  static changePaymentStatus({
    int? orderId,
    String? uuid,
    required int statusCode,
  }) async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());

    String url =
        APIList.changeOnlinePaymentStatus.toString() + (uuid ?? "${orderId}");

    try {
      response = await dio.post(url, data: {'payment_status': statusCode});

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  static changeOrderStatus({
    int? orderId,
    String? uuid,
    required int statusCode,
  }) async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());

    String url =
        APIList.changeOnlineOrderStatus.toString() + (uuid ?? "${orderId}");

    try {
      response = await dio.post(url, data: {'status': statusCode});

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  static rejectOrder({
    int? orderId,
    String? uuid,
    required int statusCode,
    required String reason,
  }) async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());

    String url =
        APIList.changeOnlineOrderStatus.toString() + (uuid ?? "${orderId}");

    try {
      response = await dio.post(
        url,
        data: {'status': statusCode, 'reason': reason},
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  static changeDeliveryBoy({
    int? orderId,
    String? uuid,
    required int deliveryBoyId,
  }) async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());

    String url =
        APIList.changeOnlineOrderDeliveryBoy.toString() +
        (uuid ?? "${orderId}");

    try {
      response = await dio.post(url, data: {'delivery_boy_id': deliveryBoyId});

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  static changeDeliveryBoyPos({
    required int orderId,
    required int deliveryBoyId,
  }) async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());

    String url =
        APIList.changePosOrderDeliveryBoy.toString() + "${orderId.toString()}";

    try {
      response = await dio.post(
        url,
        data: {'delivery_boy_id': deliveryBoyId, 'id': orderId},
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<DeliveryBoyModel> getDeliveryBoy() async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());

    String url = APIList.deliveryboys.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return DeliveryBoyModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return DeliveryBoyModel.fromJson(response.data);
  }
}
