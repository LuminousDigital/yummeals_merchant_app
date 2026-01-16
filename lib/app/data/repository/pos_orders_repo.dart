import 'dart:io';

import 'package:dio/dio.dart';
import 'package:foodking_admin/app/data/model/response/pos_orders_model.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:foodking_admin/widget/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../util/api-list.dart';
import '../api/server.dart';

class POSOrdersRepo {
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

  static Future<POSOrdersModel> getPOSOrders({
    int? paginate,
    int? page,
    int? perPage,
  }) async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());
    String url =
        APIList.posOrders.toString() +
        '?paginate=$paginate&page=$page&per_page=$perPage&order_by=desc&source=15';
    try {
      response = await dio.get(url);
      // Log full response to inspect presence of UUID in payload
      try {
        print('[POSOrdersRepo.getPOSOrders] URL: ' + url);
        print(
          '[POSOrdersRepo.getPOSOrders] Status: ' +
              response.statusCode.toString(),
        );
        print(
          '[POSOrdersRepo.getPOSOrders] Response: ' + response.data.toString(),
        );
      } catch (e) {
        print('[POSOrdersRepo.getPOSOrders] Logging error: ' + e.toString());
      }
      if (response.statusCode == 200) {
        return POSOrdersModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return POSOrdersModel.fromJson(response.data);
  }

  static Future<POSOrdersModel> getPOSOrdersByFilter({
    required String order_serial_no,
    required String status,
    required String user_id,
    required String order_datetime,
  }) async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());
    String url =
        APIList.posOrders.toString() +
        '?order_type=15&order_serial_no=$order_serial_no&status=$status&user_id=$user_id&order_datetime=$order_datetime';
    try {
      response = await dio.get(url);
      // Log full response to inspect presence of UUID in payload for filtered fetch
      try {
        print('[POSOrdersRepo.getPOSOrdersByFilter] URL: ' + url);
        print(
          '[POSOrdersRepo.getPOSOrdersByFilter] Status: ' +
              response.statusCode.toString(),
        );
        print(
          '[POSOrdersRepo.getPOSOrdersByFilter] Response: ' +
              response.data.toString(),
        );
      } catch (e) {
        print(
          '[POSOrdersRepo.getPOSOrdersByFilter] Logging error: ' + e.toString(),
        );
      }
      if (response.statusCode == 200) {
        return POSOrdersModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return POSOrdersModel.fromJson(response.data);
  }

  static getPOSOrderFile() async {
    var response;
    var dio = Dio(await getBasseOptionsWithToken());

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Directory dir = Directory("");
    if (Platform.isAndroid) {
      dir = Directory("/storage/emulated/0/Download");
    } else {
      dir = await getApplicationDocumentsDirectory();
    }

    //Directory dir = Directory("/storage/emulated/0/Download");
    String url = APIList.posFile.toString() + '?order_type=15';
    try {
      response = await dio.download(url, '${dir.path}/pos-orders.xlsx');

      if (response.statusCode == 200) {
        customSnackbar(
          "SUCCESS".tr,
          'DOWNLOAD_SUCCESSFUL'.tr,
          AppColor.success,
        );
        return response.data;
      }
    } catch (e) {
      print(e);
    }
    return response.data;
  }
}
