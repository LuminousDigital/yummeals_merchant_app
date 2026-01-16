import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking_admin/app/data/repository/my_statistics_repo.dart';
import 'package:foodking_admin/app/modules/home/controllers/home_controller.dart';
import 'package:foodking_admin/app/modules/order/controller/online_order_controller.dart';
import 'package:foodking_admin/app/modules/splash/controllers/splash_controller.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarView extends StatefulWidget {
  const AppBarView({super.key});

  @override
  State<AppBarView> createState() => _AppBarViewState();
}

class _AppBarViewState extends State<AppBarView> {
  SplashController splashController = Get.put(SplashController());
  HomeController home = Get.put(HomeController());
  OnlineOrderController order = Get.put(OnlineOrderController());
  // SalesController sales = Get.put(SalesController());

  final box = GetStorage();

  final bool isActive = true;

  @override
  void initState() {
    super.initState();
    home.getBranchList();
    splashController.getConfiguration();
    MyStatisticsRepo.changeBranch(branch_id: box.read('branch_id').toString());
    home.getStatisticsList();
    home.getSalesSummaryList();
    home.getOrdersSummaryList();
    home.getTopCustomersList();
    home.getBranchList();
    // sales.getCustomersList();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColor.primaryBackgroundColor,
      leadingWidth: 130.w,
      leading: Padding(
        padding:
            EdgeInsets.only(left: 16.w, top: 5.h, bottom: 5.h, right: 16.w),
        child: Image.asset(
          Images.logo,
          height: 24.h,
          width: 71.w,
        ),
      ),
      actions: [
        Obx(() {
          if (home.branchMap.isNotEmpty) {
            for (var i = 0; i < home.branchModel!.data!.length; i++) {
              if (home.branchModel!.data![i].id == box.read('branch_id')) {
                box.write('branch_name', home.branchModel!.data![i].name);
              }
            }

            return Padding(
              padding: EdgeInsets.only(
                  right: 16.w, top: 12.h, bottom: 10.h, left: 16.w),
              child: box.read('role_id') == 6
                  ? Container(
                      height: 32.h,
                      //width: 78.w,
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor1,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                box.read('branch_name').toString().tr,
                                style: GoogleFonts.rubik(
                                    color: AppColor.fontColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              SvgPicture.asset(
                                Images.iconBranch,
                                fit: BoxFit.cover,
                                color: AppColor.primaryColor,
                                height: 16.h,
                                width: 16.w,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : PopupMenuButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                      ),
                      position: PopupMenuPosition.under,
                      itemBuilder: (ctx) => List.generate(
                          home.branchModel!.data!.length,
                          (index) => PopupMenuItem(
                                onTap: () async {
                                  setState(() {
                                    box.write('branch_id',
                                        home.branchModel!.data![index].id);
                                    box.write('branch_name',
                                        home.branchModel!.data![index].name);
                                  });

                                  await MyStatisticsRepo.changeBranch(
                                      branch_id: home
                                          .branchModel!.data![index].id
                                          .toString());
                                  await home.getStatisticsList();
                                  await home.getSalesSummaryList();
                                  await home.getOrdersSummaryList();
                                  await home.getTopCustomersList();
                                  await home.getBranchList();
                                  await Get.find<OnlineOrderController>()
                                      .getOnlineOrdersList();
                                  // sales.getCustomersList();
                                },
                                child: Text(
                                  home.branchModel!.data![index].name
                                      .toString(),
                                  style: GoogleFonts.rubik(
                                      color: AppColor.fontColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp),
                                ),
                              )),
                      child: Container(
                        height: 32.h,
                        //width: 78.w,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor1,
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  box.read('branch_name').toString().tr,
                                  style: GoogleFonts.rubik(
                                      color: AppColor.fontColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                SvgPicture.asset(
                                  Images.iconBranch,
                                  fit: BoxFit.cover,
                                  color: AppColor.primaryColor,
                                  height: 16.h,
                                  width: 16.w,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            );
          } else {
            return Container(
              height: 32.h,
              //width: 78.w,
              decoration: BoxDecoration(
                  color: AppColor.primaryColor1,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        box.read('branch_name').toString().tr,
                        style: GoogleFonts.rubik(
                            color: AppColor.fontColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      SvgPicture.asset(
                        Images.iconBranch,
                        fit: BoxFit.cover,
                        color: AppColor.primaryColor,
                        height: 16.h,
                        width: 16.w,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        }),
      ],
    );
  }
}
