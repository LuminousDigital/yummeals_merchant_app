import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking_admin/app/data/model/response/sales_summary_model.dart';
import 'package:foodking_admin/app/modules/splash/controllers/splash_controller.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:foodking_admin/widget/date_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as store;
import 'package:google_fonts/google_fonts.dart';

class SalesWidget extends StatefulWidget {
  const SalesWidget({super.key, required this.sales});
  final Data sales;

  @override
  State<SalesWidget> createState() => _SalesWidgetState();
}

class _SalesWidgetState extends State<SalesWidget> {
  SplashController splash = Get.put(SplashController());
  final box = store.GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bool isLogedIn = box.read('isLogedIn');
    if (isLogedIn) {
      splash.getConfiguration();
    }
  }

  LineChartData mainData() {
    List<FlSpot> monthlySpots = [
      for (var i = 0; i < widget.sales.perDaySales.length; i++)
        FlSpot(i.toDouble(), widget.sales.perDaySales[i]),
    ];
    return LineChartData(
      borderData: FlBorderData(
        show: false, // to remove border around chart
      ),
      gridData: FlGridData(
        show: false, // to remove grids
        horizontalInterval: 1.6,
        drawVerticalLine: false, // or just remove vertical lines
      ),
      titlesData: FlTitlesData(
        show: false, // for hide charts titles
        rightTitles: SideTitles(
          showTitles: false,
        ), // for hide right side titles
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          // customize bottom titles
          showTitles: false,
          reservedSize: 22,
          interval: 1,
          getTextStyles:
              (context, value) => TextStyle(
                color: Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 8.sp,
              ),
          margin: 10.sp,
        ),
      ),
      minX: 0,
      maxX: monthlySpots.length.toDouble() - 1,
      minY: 0,
      //  maxY: 150000,
      lineTouchData: LineTouchData(
        getTouchedSpotIndicator: (
          LineChartBarData barData,
          List<int> spotIndexes,
        ) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Colors.white.withOpacity(0.1),
                strokeWidth: 2,
                dashArray: [3, 3],
              ),
              FlDotData(
                show: false,
                getDotPainter:
                    (spot, percent, barData, index) => FlDotCirclePainter(
                      radius: 8.r,
                      color: [Colors.black, Colors.black][index],
                      strokeWidth: 2,
                      strokeColor: Colors.black,
                    ),
              ),
            );
          }).toList();
        },
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          // customize tooltip
          tooltipPadding: EdgeInsets.all(8.r),
          tooltipBgColor: Color(0xff2e3747).withOpacity(0.8),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              return LineTooltipItem(
                '${splash.currency}${touchedSpot.y}',
                TextStyle(color: Colors.white, fontSize: 12.sp),
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
      ),
      lineBarsData: [
        LineChartBarData(
          // draw line chart
          spots: monthlySpots,
          isCurved: true,
          colors: [AppColor.activeColor],
          barWidth: 2,
          preventCurveOverShooting: true,

          //show: false,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradientFrom: Offset(0, 0),
            gradientTo: Offset(0, 1),
            colors: [
              AppColor.chart.withOpacity(0.20),
              AppColor.chart.withOpacity(0.0),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    'SALES_SUMMARY'.tr,
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
                              child: DatePickerWidget(index: 2),
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
            SizedBox(height: 20.h),
            FittedBox(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Images.chart,
                            height: 20.h,
                            width: 20.w,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            widget.sales.totalSales.toString(),
                            style: GoogleFonts.rubik(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'TOTAL_SALES'.tr,
                        style: GoogleFonts.rubik(
                          color: AppColor.gray,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 54.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Images.chart,
                              height: 20.h,
                              width: 20.w,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              widget.sales.avgPerDay.toString(),
                              style: GoogleFonts.rubik(
                                color: AppColor.fontColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'AVG_SALES_PER_DAY'.tr,
                        style: GoogleFonts.rubik(
                          color: AppColor.gray,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              height: 132.h,
              width: double.infinity,
              child: LineChart(
                // chart options data
                mainData(),
                swapAnimationCurve: Curves.easeInOutCubic,
                swapAnimationDuration: Duration(milliseconds: 1000),
              ),
            ),
            SizedBox(height: 10.h),
            FittedBox(
              child: Row(
                children: [
                  for (var i = 1; i <= 30; i++)
                    Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: Text(
                        '$i',
                        style: GoogleFonts.rubik(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
