import 'package:dio/dio.dart';
import 'package:foodking_admin/app/data/model/response/pos_order_details_model.dart';
import 'package:get_storage/get_storage.dart';

import '../../../util/api-list.dart';
import '../api/server.dart';

class POSOrderDetailsRepo {
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

  static Future<POSOrderDetailsModel> getPOSOrderDetails({
    required int id,
  }) async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());
    String url = APIList.posOorderDetails.toString() + "${id.toString()}";
    try {
      response = await dio.get(url);
      // Log full response to inspect for UUID or related identifier in payload
      try {
        print('[POSOrderDetailsRepo.getPOSOrderDetails] URL: ' + url);
        print(
          '[POSOrderDetailsRepo.getPOSOrderDetails] Status: ' +
              response.statusCode.toString(),
        );
        print(
          '[POSOrderDetailsRepo.getPOSOrderDetails] Response: ' +
              response.data.toString(),
        );
      } catch (e) {
        print(
          '[POSOrderDetailsRepo.getPOSOrderDetails] Logging error: ' +
              e.toString(),
        );
      }
      if (response.statusCode == 200) {
        return POSOrderDetailsModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return POSOrderDetailsModel.fromJson(response.data);
  }

  static changePaymentStatus({
    required int orderId,
    required int statusCode,
  }) async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());

    String url =
        APIList.changePosPaymentStatus.toString() + "${orderId.toString()}";

    try {
      response = await dio.post(url, data: {'payment_status': statusCode});

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  static changeOrderStatus({
    required int orderId,
    required int statusCode,
  }) async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());

    String url =
        APIList.changePosOrderStatus.toString() + "${orderId.toString()}";

    try {
      response = await dio.post(url, data: {'status': statusCode});

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
