import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking_admin/app/data/repository/my_statistics_repo.dart';
import 'package:foodking_admin/app/modules/Navbar/views/navbar_screen.dart';
import 'package:foodking_admin/app/modules/home/controllers/home_controller.dart';
import 'package:foodking_admin/app/modules/home/widget/customer_widget.dart';
import 'package:foodking_admin/app/modules/home/widget/order_summary_widget.dart';
import 'package:foodking_admin/app/modules/home/widget/order_widget.dart';
import 'package:foodking_admin/app/modules/home/widget/sales_widget.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:foodking_admin/util/style.dart';
import 'package:foodking_admin/widget/app_bar.dart';
import 'package:foodking_admin/widget/date_picker.dart';
import 'package:foodking_admin/widget/loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  final box = GetStorage();
  List data = [];
  String fromDate = '';
  String toDate = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bool isLogedIn = box.read('isLogedIn');
    if (isLogedIn) {
      MyStatisticsRepo.changeBranch(
        branch_id: box.read('branch_id').toString(),
      );
      homeController.getStatisticsList();
      homeController.getSalesSummaryList();
      homeController.getOrdersSummaryList();
      homeController.getTopCustomersList();
      homeController.getBranchList();
    }
  }

  openOrderPopUp() {
    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                height: 160.h,
                width: 300.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('You have a new order.'.tr, style: fontBold),
                      Text('Please check your order list.'.tr, style: fontBold),
                      ElevatedButton(
                        onPressed: () {
                          Get.offAll(() => const NavBarView(index: 1));
                          homeController.topicNameFirebase.value = false;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          minimumSize: Size(156.w, 48.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          "Let Me Check".tr,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: fontMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 16.w,
                top: 16.h,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                    homeController.topicNameFirebase.value = false;
                  },
                  child: SvgPicture.asset(
                    Images.IconClose,
                    height: 16.h,
                    width: 16.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.statisticsMap.isNotEmpty &&
          homeController.salesSummaryMap.isNotEmpty &&
          homeController.orderSummaryMap.isNotEmpty &&
          homeController.topCustomersMap.isNotEmpty &&
          homeController.branchMap.isNotEmpty) {
        if (homeController.topicNameFirebase.value == false) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Scaffold(
                backgroundColor: AppColor.primaryBackgroundColor,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(58.h),
                  child: AppBarView(),
                ),
                body: RefreshIndicator(
                  color: AppColor.primaryColor,
                  onRefresh: () async {
                    if (box.read('isLogedIn') != null &&
                        box.read('isLogedIn') != false) {
                      await homeController.getStatisticsList();
                      await homeController.getSalesSummaryList();
                      await homeController.getOrdersSummaryList();
                      await homeController.getTopCustomersList();
                    }
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 24.h,
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Text(
                                  'ORDER_STATISTICS'.tr,
                                  style: GoogleFonts.rubik(
                                    color: AppColor.fontColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              FittedBox(
                                child: Row(
                                  children: [
                                    Text(
                                      'LAST_30_DAYS'.tr,
                                      style: GoogleFonts.rubik(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    GestureDetector(
                                      onTap: () {
                                        Get.dialog(
                                          barrierDismissible: false,
                                          Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: DatePickerWidget(index: 1),
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        Images.calander,
                                        height: 24.h,
                                        width: 24.w,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 21.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OrderWidget(
                                icon: Images.totalOrder,
                                backgroundColor: AppColor.totalOrder,
                                text: 'TOTAL_ORDERS'.tr,
                                count:
                                    homeController
                                        .statisticsModel!
                                        .data
                                        .totalOrder
                                        .toString(),
                              ),
                              OrderWidget(
                                icon: Images.orderPending,
                                backgroundColor: AppColor.pendingOrder,
                                text: 'PENDING'.tr,
                                count:
                                    homeController
                                        .statisticsModel!
                                        .data
                                        .pendingOrder
                                        .toString(),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OrderWidget(
                                icon: Images.orderProcessing,
                                backgroundColor: AppColor.processingOrder,
                                text: 'PROCESSING'.tr,
                                count:
                                    homeController
                                        .statisticsModel
                                        ?.data
                                        .preparedOrder
                                        .toString(),
                              ),
                              OrderWidget(
                                icon: Images.orderOutForDelivery,
                                backgroundColor: AppColor.outForDeliveryOrder,
                                text: 'OUT_FOR_DELIVERY'.tr,
                                count:
                                    homeController
                                        .statisticsModel!
                                        .data
                                        .outForDeliveryOrder
                                        .toString(),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OrderWidget(
                                icon: Images.orderDelivered,
                                backgroundColor: AppColor.deliveredOrder,
                                text: 'DELIVERED'.tr,
                                count:
                                    homeController
                                        .statisticsModel!
                                        .data
                                        .deliveredOrder
                                        .toString(),
                              ),
                              OrderWidget(
                                icon: Images.orderCancel,
                                backgroundColor: AppColor.cancelOrder,
                                text: 'CANCELED'.tr,
                                count:
                                    homeController
                                        .statisticsModel!
                                        .data
                                        .canceledOrder
                                        .toString(),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OrderWidget(
                                icon: Images.orderReturned,
                                backgroundColor: AppColor.returnedOrder,
                                text: 'RETURNED'.tr,
                                count:
                                    homeController
                                        .statisticsModel!
                                        .data
                                        .returnedOrder
                                        .toString(),
                              ),
                              OrderWidget(
                                icon: Images.orderRejected,
                                backgroundColor: AppColor.rejectedOrder,
                                text: 'REJECTED'.tr,
                                count:
                                    homeController
                                        .statisticsModel!
                                        .data
                                        .rejectedOrder
                                        .toString(),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          SalesWidget(
                            sales: homeController.salesSummaryModel!.data,
                          ),
                          SizedBox(height: 16.h),
                          OrderSummaryWidget(
                            order: homeController.orderSummaryModel!.data,
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.black.withOpacity(0.016),
                                  offset: Offset(0, 6.r),
                                  blurRadius: 32.r,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'TOP_CUSTOMERS'.tr,
                                    style: GoogleFonts.rubik(
                                      color: AppColor.fontColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  StaggeredGrid.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16.h,
                                    crossAxisSpacing: 16.w,
                                    children: [
                                      for (
                                        var i = 0;
                                        i <
                                            homeController
                                                .topCustomersModel!
                                                .data!
                                                .length;
                                        i++
                                      )
                                        CustomerWidget(
                                          customer:
                                              homeController
                                                  .topCustomersModel!
                                                  .data![i],
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            openOrderPopUp();
          });
          return SizedBox();
        }
      } else {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white60,
          child: const Center(child: LoaderCircle()),
        );
      }
    });
  }
}
