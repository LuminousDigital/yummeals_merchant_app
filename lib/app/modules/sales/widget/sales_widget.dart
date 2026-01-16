import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/response/sales_report_model.dart';

// ignore: must_be_immutable
class SalesWidget extends StatefulWidget {
  SalesWidget({super.key, required this.sales, required this.currancy});
  final Data sales;
  String? currancy;

  @override
  State<SalesWidget> createState() => _SalesWidgetState();
}

class _SalesWidgetState extends State<SalesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 140.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.dividerColor, width: 1.r),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  Images.reserve,
                  height: 16.h,
                  width: 16.w,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Row(
                  children: [
                    Text(
                      'ORDER_ID'.tr,
                      style: GoogleFonts.rubik(
                          color: AppColor.gray,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    ),
                    Text(
                      ':',
                      style: GoogleFonts.rubik(
                          color: AppColor.gray,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    ),
                  ],
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  '#${widget.sales.orderSerialNo.toString()}',
                  style: GoogleFonts.rubik(
                      color: AppColor.fontColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Container(
                  height: 18.h,
                  //width: 47.w,
                  decoration: BoxDecoration(
                    color: widget.sales.paymentStatus == 5
                        ? AppColor.paid
                        : widget.sales.paymentStatus == 10
                            ? AppColor.unpaid
                            : null,
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(4.r),
                      child: Text(
                        widget.sales.paymentStatus == 5
                            ? 'PAID'.tr
                            : widget.sales.paymentStatus == 10
                                ? 'UNPAID'.tr
                                : '',
                        style: GoogleFonts.rubik(
                            color: widget.sales.paymentStatus == 5
                                ? AppColor.success
                                : widget.sales.paymentStatus == 10
                                    ? AppColor.error
                                    : null,
                            fontWeight: FontWeight.w400,
                            fontSize: 8.sp),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'DATE'.tr,
                              style: GoogleFonts.rubik(
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              ':',
                              style: GoogleFonts.rubik(
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'TOTAL'.tr,
                              style: GoogleFonts.rubik(
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              ':',
                              style: GoogleFonts.rubik(
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'DELIVERY'.tr,
                              style: GoogleFonts.rubik(
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              ':',
                              style: GoogleFonts.rubik(
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'DISCOUNT'.tr,
                              style: GoogleFonts.rubik(
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              ':',
                              style: GoogleFonts.rubik(
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Text(
                                'PAYMENT_TYPE'.tr,
                                style: GoogleFonts.rubik(
                                    color: AppColor.fontColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                              ),
                              Text(
                                ':',
                                style: GoogleFonts.rubik(
                                    color: AppColor.fontColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.sales.orderDatetime.toString(),
                          style: GoogleFonts.rubik(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          '${widget.currancy}${widget.sales.totalAmountPrice}',
                          style: GoogleFonts.roboto(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          '${widget.currancy}${widget.sales.deliveryChargeAmountPrice}',
                          style: GoogleFonts.roboto(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          '${widget.currancy}${widget.sales.discountAmountPrice}',
                          style: GoogleFonts.roboto(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          widget.sales.paymentStatus == 10 &&
                                  widget.sales.transaction == null
                              ? 'CASH_ON_DELIVEY'.tr
                              : widget.sales.transaction != null
                                  ? widget.sales.transaction!.toString()
                                  : 'CASH_ON_DELIVEY'.tr,
                          style: GoogleFonts.rubik(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
