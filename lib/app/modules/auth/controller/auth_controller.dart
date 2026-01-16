// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodking_admin/app/data/repository/branch_repo.dart';
import 'package:foodking_admin/app/data/repository/my_statistics_repo.dart';
import 'package:foodking_admin/app/modules/Navbar/views/navbar_screen.dart';
import 'package:foodking_admin/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/api-list.dart';
import '../../../../util/constant.dart';
import '../../../../widget/custom_snackbar.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/login_model.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final box = GetStorage();
  LoginModel loginModelData = LoginModel();
  Server server = Server();
  LoginModel loginModel = LoginModel();
  bool loader = false;

  int branchId = 0;

  ProfileController profileController = Get.put(ProfileController());

  @override
  void onInit() {
    if (box.read('isLogedIn') == null) {
      box.write('isLogedIn', false);
    } else if (box.read('isLogedIn') == true) {
      getRefreshToken();
    }
    if (box.read('viewValue') == null) {
      box.write('viewValue', 0);
    }
    super.onInit();
  }

  Future<LoginModel?> login(email, password) async {
    loader = true;
    update();

    Map body = {'email': email, 'password': password};
    String jsonBody = json.encode(body);
    try {
      server
          .postRequest(endPoint: APIList.login, body: jsonBody)
          .then((response) async {
        if (response != null && response.statusCode == 201) {
          final jsonResponse = json.decode(response.body);
          loginModel = LoginModel.fromJson(jsonResponse);

          if (loginModel.user!.roleId == 1 || loginModel.user!.roleId == 6) {
            box.write('isLogedIn', true);
            var bearerToken = 'Bearer ' '${loginModel.token}';

            box.write('role_id', loginModel.user!.roleId);
            box.write('justToken', loginModel.token);
            box.write('token', bearerToken);
            Server.initClass(token: box.read('token'));
            var branches = await BranchRepo.getBranch();
            var data = await MyStatisticsRepo.getDefaultBranch();

            if (data.data != null && branches.data != null) {
              branchId = data.data!.branchId!.toInt();
              box.write('branch_id', branchId);
              for (var i = 0; i < branches.data!.length; i++) {
                if (branches.data![i].id == branchId) {
                  box.write('branch_name', branches.data![i].name);
                  if (branchId == 0) {
                    box.write('branch_name', 'SELECT_BRANCH');
                  }
                }
              }
            }
            profileController.getProfileData();
            update();
            customSnackbar("SUCCESS".tr, jsonResponse["message"].toString(),
                AppColor.success);
            update();
            Get.offAll(() => NavBarView());
            loader = false;
            update();
            return loginModel;
          } else {
            box.write('isLogedIn', false);
            customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, AppColor.error);
            loader = false;
            update();

            return null;
          }
        } else {
          final jsonResponse = json.decode(response.body);

          box.write('isLogedIn', false);
          customSnackbar("ERROR".tr,
              jsonResponse["errors"]["validation"].toString(), AppColor.error);
          loader = false;
          update();

          return null;
        }
      });

      return loginModel;
    } catch (e) {
      return null;
    }
  }

  Future getRefreshToken() async {
    try {
      server
          .getRequest(endPoint: APIList.refreshToken! + box.read('justToken'))
          .then((response) {
        if (response != null && response.statusCode == 201) {
          final jsonResponse = json.decode(response.body);
          var bearerToken = 'Bearer ' + jsonResponse["token"].toString();
          box.write('token', bearerToken);
          update();
        } else {
          box.write('isLogedIn', false);
          box.remove('token');
          update();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future postDeviceToken(token) async {
    loader = true;
    update();
    Map body = {
      'token': token,
    };
    String jsonBody = json.encode(body);
    try {
      server
          .postRequestWithToken(endPoint: APIList.token, body: jsonBody)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          loader = false;
          update();
        } else {
          loader = false;
          update();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      loader = false;
      update();
    }
    loader = false;
    update();
  }
}
