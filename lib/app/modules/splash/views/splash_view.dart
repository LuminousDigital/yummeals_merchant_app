import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodking_admin/app/modules/Navbar/views/navbar_screen.dart';
import 'package:foodking_admin/app/modules/auth/views/login_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/constant.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final box = GetStorage();
  @override
  void initState() {
    //for foreground state

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
      () {
        if (box.read('isLogedIn') != null && box.read('isLogedIn') != false) {
          Get.offAll(() => NavBarView());
        } else {
          Get.offAll(() => LoginView());
        }
      },
    );
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
          child: Image.asset(
        Images.logo,
        height: 60.h,
        fit: BoxFit.contain,
      )),
    );
  }
}
