import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking_admin/app/modules/filter/views/filter_screen.dart';
import 'package:foodking_admin/app/modules/sales/controller/sales_controller.dart';
import 'package:foodking_admin/app/modules/sales/widget/sales_widget.dart';
import 'package:foodking_admin/app/modules/splash/controllers/splash_controller.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:foodking_admin/widget/app_bar.dart';
import 'package:foodking_admin/widget/loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  SalesController sales = Get.put(SalesController());
  SplashController splash = Get.put(SplashController());
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    sales.loadMoreSalesData();
    final box = GetStorage();
    bool isLogedIn = box.read('isLogedIn');
    if (isLogedIn) {
      sales.getSalesReportList();
      splash.getConfiguration();
      sales.getCustomersList();
    }
  }

  openFilter() {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => FilterScreen(index: 3),
    );
  }

  @override
  void dispose() {
    sales.resetState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => sales.salesList.isNotEmpty
            ? Scaffold(
                backgroundColor: AppColor.primaryBackgroundColor,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(58.h), child: AppBarView()),
                body: RefreshIndicator(
                  color: AppColor.primaryColor,
                  onRefresh: () async {
                    if (box.read('isLogedIn') != null &&
                        box.read('isLogedIn') != false) {
                      sales.resetState();
                      sales.getSalesReportList();
                      splash.getConfiguration();
                      sales.getCustomersList();
                    }
                  },
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'SALES_REPORT'.tr,
                                style: GoogleFonts.rubik(
                                    color: AppColor.fontColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {},
                                    child: SvgPicture.asset(
                                      Images.document_green,
                                      height: 24.h,
                                      width: 24.w,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
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
                          SizedBox(
                            height: 24.h,
                          ),
                          Expanded(
                            child: ListView.builder(
                              controller: sales.scrollController,
                              itemCount: sales.salesList.length +
                                  (sales.hasMoreData == true ? 1 : 0),
                              physics: AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (index == sales.salesList.length) {
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
                                  child: SalesWidget(
                                      sales: sales.salesList[index],
                                      currancy: splash.currency.toString()),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white60,
                child: const Center(
                  child: LoaderCircle(),
                ),
              ),
      ),
    );
  }
}
