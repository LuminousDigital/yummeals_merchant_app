import 'package:dio/dio.dart';
import 'package:foodking_admin/app/data/model/response/order_summary_model.dart';
import 'package:get_storage/get_storage.dart';

import '../../../util/api-list.dart';
import '../api/server.dart';

class MyOrdersSummaryRepo {
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
        'Authorization': token
      },
    );

    return options;
  }

  static Server server = Server();

  static Future<OrderSummaryModel> getOrdersSummary() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = APIList.ordersSummary.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return OrderSummaryModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return OrderSummaryModel.fromJson(response.data);
  }

  static Future<OrderSummaryModel> getOrdersSummaryByDate(
      {required String first_date, required String last_date}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = APIList.ordersSummary.toString() +
        '?first_date=$first_date' +
        '&last_date=$last_date';
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        print(response.data);
        return OrderSummaryModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return OrderSummaryModel.fromJson(response.data);
  }
}
