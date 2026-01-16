import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking_admin/app/data/model/response/order_summary_model.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:foodking_admin/widget/date_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OrderSummaryWidget extends StatefulWidget {
  const OrderSummaryWidget({super.key, required this.order});
  final Data order;

  @override
  State<OrderSummaryWidget> createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
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
                blurRadius: 32.r)
          ]),
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
                    'ORDER_SUMMARY'.tr,
                    style: GoogleFonts.rubik(
                        color: AppColor.fontColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                FittedBox(
                  child: Row(
                    children: [
                      Text(
                        'LAST_30_DAYS'.tr,
                        style: GoogleFonts.rubik(
                            color: AppColor.fontColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                              barrierDismissible: false,
                              Dialog(
                                backgroundColor: Colors.transparent,
                                child: DatePickerWidget(index: 3),
                              ));
                        },
                        child: SvgPicture.asset(
                          Images.calander,
                          height: 24.h,
                          width: 24.w,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.r),
                    child: Transform.rotate(
                      angle: 0.6,
                      child: Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularPercentIndicator(
                              radius: 105.r,
                              lineWidth: 12.w,
                              animation: true,
                              percent: widget.order.delivered / 100,
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: AppColor.round1,
                              progressColor: AppColor.progress1,
                            ),
                            CircularPercentIndicator(
                              radius: 80.r,
                              lineWidth: 10.w,
                              animation: true,
                              percent: widget.order.returned / 100,
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: AppColor.round2,
                              progressColor: AppColor.progress2,
                            ),
                            CircularPercentIndicator(
                              radius: 55.r,
                              lineWidth: 8.w,
                              animation: true,
                              percent: widget.order.canceled / 100,
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: AppColor.round3,
                              progressColor: AppColor.progress3,
                            ),
                            CircularPercentIndicator(
                              radius: 33.r,
                              lineWidth: 6.w,
                              animation: true,
                              percent: widget.order.rejected / 100,
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: AppColor.round4,
                              progressColor: AppColor.progress4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 38,
                  ),
                  Container(
                      height: 188.h,
                      //width: 148.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'DELIVERED'.tr,
                                    style: GoogleFonts.rubik(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp),
                                  ),
                                  Text(
                                    ' (${widget.order.delivered}%)',
                                    style: GoogleFonts.rubik(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Container(
                                height: 4.h,
                                width: 117.w,
                                decoration: BoxDecoration(
                                    color: AppColor.progress1,
                                    borderRadius: BorderRadius.circular(4.r)),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'RETURNED'.tr,
                                    style: GoogleFonts.rubik(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp),
                                  ),
                                  Text(
                                    ' (${widget.order.returned}%)',
                                    style: GoogleFonts.rubik(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Container(
                                height: 4.h,
                                width: 117.w,
                                decoration: BoxDecoration(
                                    color: AppColor.progress2,
                                    borderRadius: BorderRadius.circular(4.r)),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'CANCELED'.tr,
                                    style: GoogleFonts.rubik(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp),
                                  ),
                                  Text(
                                    ' (${widget.order.canceled}%)',
                                    style: GoogleFonts.rubik(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Container(
                                height: 4.h,
                                width: 117.w,
                                decoration: BoxDecoration(
                                    color: AppColor.progress3,
                                    borderRadius: BorderRadius.circular(4.r)),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'REJECTED'.tr,
                                    style: GoogleFonts.rubik(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp),
                                  ),
                                  Text(
                                    ' (${widget.order.rejected}%)',
                                    style: GoogleFonts.rubik(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Container(
                                height: 4.h,
                                width: 117.w,
                                decoration: BoxDecoration(
                                    color: AppColor.progress4,
                                    borderRadius: BorderRadius.circular(4.r)),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
