import 'package:dio/dio.dart';
import 'package:foodking_admin/app/data/model/response/customers_model.dart';
import 'package:foodking_admin/app/data/model/response/sales_report_model.dart';
import 'package:get_storage/get_storage.dart';

import '../../../util/api-list.dart';
import '../api/server.dart';

class SalesReportRepo {
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

  static Future<SalesReportModel> getSalesReport(
      {int? paginate, int? page, int? perPage}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = APIList.salesReport.toString() +
        '?paginate=$paginate&page=$page&per_page=$perPage';
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return SalesReportModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return SalesReportModel.fromJson(response.data);
  }

  static Future<SalesReportModel> getSalesReportByFilter({
    required String order_serial_no,
    required String status,
    required String user_id,
    required String order_datetime,
  }) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = APIList.salesReport.toString() +
        '?order_serial_no=$order_serial_no&status=$status&user_id=$user_id&order_datetime=$order_datetime';
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return SalesReportModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return SalesReportModel.fromJson(response.data);
  }

  static Future<CustomersModel> getCustomers() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = APIList.customers.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return CustomersModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return CustomersModel.fromJson(response.data);
  }

  // static Future getSalesReportExport() async {
  //   var response;
  //   var dio = Dio(
  //     await getBasseOptionsWithToken(),
  //   );
  //   String url = APIList.salesReportExport.toString();
  //   try {
  //     response = await dio.get(url);
  //     if (response.statusCode == 200) {
  //       return response.data;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return response.data;
  // }
}
