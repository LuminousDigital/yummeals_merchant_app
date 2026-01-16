import 'package:dio/dio.dart';
import 'package:foodking_admin/app/data/model/response/branch_model.dart';
import 'package:get_storage/get_storage.dart';

import '../../../util/api-list.dart';
import '../api/server.dart';

class BranchRepo {
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

  static Future<BranchModel> getBranch() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = APIList.branch.toString() + "?order_type=asc&status=5";
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return BranchModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return BranchModel.fromJson(response.data);
  }
}
