import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking_admin/app/data/repository/pos_orders_repo.dart';
import 'package:foodking_admin/app/modules/filter/views/filter_screen.dart';
import 'package:foodking_admin/app/modules/order/controller/pos_order_controller.dart';
import 'package:foodking_admin/app/modules/order/widgets/pos.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class POSOrderWidget extends StatefulWidget {
  const POSOrderWidget({super.key});

  @override
  State<POSOrderWidget> createState() => _POSOrderWidgetState();
}

class _POSOrderWidgetState extends State<POSOrderWidget> {
  POSOrderController order = Get.put(POSOrderController());

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    order.loadMorePOSData();
    bool isLogedIn = box.read('isLogedIn');
    if (isLogedIn) {
      order.getPOSOrdersList();
    }
  }

  openFilter() {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => FilterScreen(index: 2),
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
            order.getPOSOrdersList();
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
                    'POS_ORDERS'.tr,
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
                          await POSOrdersRepo.getPOSOrderFile();
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
              order.posOrdersList.isNotEmpty
                  ? Expanded(
                    child: ListView.builder(
                      controller: order.scrollController,
                      itemCount:
                          order.posOrdersList.length +
                          (order.hasMoreData == true ? 1 : 0),
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index == order.posOrdersList.length) {
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
                          child: POS(order: order.posOrdersList[index]),
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
