import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking_admin/app/data/repository/online_orders_repo.dart';
import 'package:foodking_admin/app/modules/filter/views/filter_screen.dart';
import 'package:foodking_admin/app/modules/order/controller/online_order_controller.dart';
import 'package:foodking_admin/app/modules/order/widgets/order.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class OnlineOrderWidget extends StatefulWidget {
  OnlineOrderWidget({super.key});

  @override
  State<OnlineOrderWidget> createState() => _OnlineOrderWidgetState();
}

class _OnlineOrderWidgetState extends State<OnlineOrderWidget> {
  OnlineOrderController order = Get.put(OnlineOrderController());

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    order.loadMoreOnlineData();
    bool isLogedIn = box.read('isLogedIn');
    if (isLogedIn) {
      order.getOnlineOrdersList();
    }
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  String path = '';

  void _setPath() async {
    Directory _path = await getApplicationDocumentsDirectory();
    String _localPath = _path.path + Platform.pathSeparator + 'Download';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    path = _localPath;
  }

  openFilter() {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => FilterScreen(index: 1),
    );
  }

  @override
  void dispose() {
    order.resetState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        color: AppColor.primaryColor,
        onRefresh: () async {
          if (box.read('isLogedIn') != null && box.read('isLogedIn') != false) {
            order.resetState();
            order.getOnlineOrdersList();
          }
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ONLINE_ORDERS'.tr,
                    style: GoogleFonts.rubik(
                      color: AppColor.fontColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          OnlineOrdersRepo.getOnlineOrderFile();
                        },
                        child: SvgPicture.asset(
                          Images.document_green,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          openFilter();
                        },
                        child: SvgPicture.asset(
                          Images.filter,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              order.onlineOrdersList.isNotEmpty
                  ? Expanded(
                    child: ListView.builder(
                      controller: order.scrollController,
                      itemCount:
                          order.onlineOrdersList.length +
                          (order.hasMoreData == true ? 1 : 0),
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index == order.onlineOrdersList.length) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.w,
                                child: CircularProgressIndicator(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ],
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Order(order: order.onlineOrdersList[index]),
                        );
                      },
                    ),
                  )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
