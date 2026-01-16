import 'dart:async';

import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking_admin/app/modules/home/view/home_screen.dart';
import 'package:foodking_admin/app/modules/order/views/order_screen.dart';
import 'package:foodking_admin/app/modules/profile/views/profile_view.dart';
import 'package:foodking_admin/app/modules/sales/views/sales_screen.dart';
import 'package:foodking_admin/helper/device_token.dart';
import 'package:foodking_admin/helper/notification_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../util/constant.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({super.key, this.index});
  final index;
  @override
  State<NavBarView> createState() => _MyDashboardViewState();
}

class _MyDashboardViewState extends State<NavBarView> {
  GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey();
  bool canExit = false;

  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    OrderScreen(),
    SalesScreen(),
    ProfileView(),
  ];

  NotificationHelper notificationHelper = NotificationHelper();

  DeviceToken deviceToken = DeviceToken();

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    notificationHelper.notificationPermission();
    currentIndex = widget.index ?? currentIndex;
    if (box.read('isLogedIn')) {
      deviceToken.getDeviceToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (canExit) {
            _setPage(0);
            return true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('PRESS_BACK_AGAIN_TO_EXIT'.tr,
                    style: const TextStyle(color: Colors.white)),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColor.primaryColor,
                duration: const Duration(seconds: 2),
                margin: const EdgeInsets.all(10),
              ),
            );
            canExit = true;
            Timer(const Duration(seconds: 2), () {
              canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomBar(
          selectedIndex: currentIndex,
          onTap: (int index) {
            setState(() => currentIndex = index);
          },
          items: <BottomBarItem>[
            BottomBarItem(
              inactiveIcon: SvgPicture.asset(
                Images.nav1,
                height: 20.h,
                width: 20.w,
              ),
              icon: Padding(
                padding: EdgeInsets.only(
                    right: box.read('languageCode') == 'ar' ? 16.w : 0.w),
                child: SvgPicture.asset(
                  Images.nav1,
                  height: 20.h,
                  width: 20.w,
                  color: AppColor.activeColor,
                ),
              ),
              title: Text(
                'DASHBOARD'.tr,
                style: GoogleFonts.rubik(
                    color: AppColor.activeColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp),
              ),
              inactiveColor: AppColor.gray,
              activeColor: AppColor.activeColor,
              activeTitleColor: AppColor.primaryColor,
            ),
            BottomBarItem(
              inactiveIcon: SvgPicture.asset(
                Images.nav2,
                height: 20.h,
                width: 20.w,
              ),
              icon: Padding(
                padding: EdgeInsets.only(
                    right: box.read('languageCode') == 'ar' ? 16.w : 0.w),
                child: SvgPicture.asset(
                  Images.nav2,
                  height: 20.h,
                  width: 20.w,
                  color: AppColor.activeColor,
                ),
              ),
              title: SizedBox(
                width: box.read('languageCode') == 'fr' ? 143.w : null,
                child: Text(
                  'ALL_ORDERS'.tr,
                  style: GoogleFonts.rubik(
                      color: AppColor.activeColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              inactiveColor: AppColor.gray,
              activeColor: AppColor.activeColor,
              activeTitleColor: AppColor.primaryColor,
            ),
            BottomBarItem(
              inactiveIcon: SvgPicture.asset(
                Images.nav3,
                height: 20.h,
                width: 20.w,
              ),
              icon: Padding(
                padding: EdgeInsets.only(
                    right: box.read('languageCode') == 'ar' ? 16.w : 0.w),
                child: SvgPicture.asset(
                  Images.nav3,
                  height: 20.h,
                  width: 20.w,
                  color: AppColor.activeColor,
                ),
              ),
              title: Text('SALES_REPORT'.tr,
                  style: GoogleFonts.rubik(
                      color: AppColor.activeColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp)),
              inactiveColor: AppColor.gray,
              activeColor: AppColor.activeColor,
              activeTitleColor: AppColor.primaryColor,
            ),
            BottomBarItem(
              inactiveIcon: SvgPicture.asset(
                Images.nav4,
                height: 20.h,
                width: 20.w,
              ),
              icon: Padding(
                padding: EdgeInsets.only(
                    right: box.read('languageCode') == 'ar' ? 16.w : 0.w),
                child: SvgPicture.asset(
                  Images.nav4,
                  height: 20.h,
                  width: 20.w,
                  color: AppColor.activeColor,
                ),
              ),
              title: Text('PROFILE'.tr,
                  style: GoogleFonts.rubik(
                      color: AppColor.activeColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp)),
              inactiveColor: AppColor.gray,
              activeColor: AppColor.activeColor,
              activeTitleColor: AppColor.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void _setPage(int index) {
    setState(() {
      setState(() => currentIndex = index);
    });
  }
}
