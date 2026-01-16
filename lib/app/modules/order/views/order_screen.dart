import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking_admin/app/modules/order/widgets/online_order_widget.dart';
import 'package:foodking_admin/app/modules/order/widgets/pos_order_widget.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:foodking_admin/widget/app_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool onlineOrder = true;
  bool posOrder = false;

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    bool isLogedIn = box.read('isLogedIn');
    if (isLogedIn) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(58.h),
          child: AppBarView(),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h),
          child: Column(
            children: [
              Container(
                height: 44.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  border: Border.all(color: AppColor.dividerColor, width: 1.r),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          onlineOrder = true;
                          posOrder = false;
                        });
                      },
                      child: Container(
                        height: 44.h,
                        width: 163.w,
                        decoration: BoxDecoration(
                          color:
                              onlineOrder == true
                                  ? AppColor.white
                                  : AppColor.bgColor,
                          borderRadius:
                              box.read('languageCode') == 'ar'
                                  ? BorderRadius.only(
                                    topRight: Radius.circular(22.r),
                                    bottomRight: Radius.circular(22.r),
                                  )
                                  : BorderRadius.only(
                                    topLeft: Radius.circular(22.r),
                                    bottomLeft: Radius.circular(22.r),
                                  ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w, right: 8.w),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SvgPicture.asset(
                                    Images.bag,
                                    height: 20.h,
                                    width: 20.w,
                                    color:
                                        onlineOrder == true
                                            ? AppColor.primaryColor
                                            : AppColor.fontColor,
                                  ),
                                ),

                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    'ONLINE_ORDER'.tr,
                                    style: GoogleFonts.rubik(
                                      color:
                                          onlineOrder == true
                                              ? AppColor.primaryColor
                                              : AppColor.fontColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          onlineOrder = false;
                          posOrder = true;
                        });
                      },
                      child: Container(
                        height: 44.h,
                        width: 163.w,
                        decoration: BoxDecoration(
                          color:
                              posOrder == true
                                  ? AppColor.white
                                  : AppColor.bgColor,
                          borderRadius:
                              box.read('languageCode') == 'ar'
                                  ? BorderRadius.only(
                                    topLeft: Radius.circular(22.r),
                                    bottomLeft: Radius.circular(22.r),
                                  )
                                  : BorderRadius.only(
                                    topRight: Radius.circular(22.r),
                                    bottomRight: Radius.circular(22.r),
                                  ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w, right: 8.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: SvgPicture.asset(
                                  Images.receipt,
                                  height: 20.h,
                                  width: 20.w,
                                  color:
                                      posOrder == true
                                          ? AppColor.primaryColor
                                          : AppColor.fontColor,
                                ),
                              ),

                              Expanded(
                                flex: 5,
                                child: Text(
                                  'POS_ORDER'.tr,
                                  style: GoogleFonts.rubik(
                                    color:
                                        posOrder == true
                                            ? AppColor.primaryColor
                                            : AppColor.fontColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child:
                    onlineOrder == true
                        ? OnlineOrderWidget()
                        : const POSOrderWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
