import 'package:dio/dio.dart';
import 'package:foodking_admin/app/data/model/response/default_branch_model.dart';
import 'package:foodking_admin/app/data/model/response/statistics_model.dart';
import 'package:get_storage/get_storage.dart';

import '../../../util/api-list.dart';
import '../api/server.dart';

class MyStatisticsRepo {
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

  static Future<StatisticsModel> getMyStatistics() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = APIList.orderStatistics.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return StatisticsModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return StatisticsModel.fromJson(response.data);
  }

  static Future<StatisticsModel> getMyStatisticsByDate(
      {required String first_date, required String last_date}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = APIList.orderStatistics.toString() +
        '?first_date=$first_date' +
        '&last_date=$last_date';
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return StatisticsModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return StatisticsModel.fromJson(response.data);
  }

  static Future<DefaultBranchModel> getDefaultBranch() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = APIList.changeBranch.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return DefaultBranchModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return DefaultBranchModel.fromJson(response.data);
  }

  static changeBranch({required String branch_id}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = APIList.changeBranch.toString();
    try {
      response = await dio.post(url, data: {'branch_id': branch_id});
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
    }
    return response.data;
  }
}
