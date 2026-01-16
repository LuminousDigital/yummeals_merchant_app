import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking_admin/app/modules/order/views/order_details.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as save;
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/response/online_orders_model.dart';

class Order extends StatefulWidget {
  const Order({super.key, required this.order});
  final Data order;

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final box = save.GetStorage();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderDetailsView(
              orderUuid: widget.order.uuid!,
            ));
      },
      child: Container(
        //height: 126.h,
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
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    '#${widget.order.orderSerialNo}',
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
                        color: widget.order.orderType == 5
                            ? AppColor.delivery
                            : widget.order.orderType == 10
                                ? AppColor.takeway
                                : null,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(4.r),
                          child: Wrap(
                            children: [
                              Text(
                                widget.order.orderType == 5
                                    ? 'DELIVERY'.tr
                                    : widget.order.orderType == 10
                                        ? 'TAKEAWAY'.tr
                                        : '',
                                style: GoogleFonts.rubik(
                                    color: widget.order.orderType == 5
                                        ? AppColor.green
                                        : widget.order.orderType == 10
                                            ? AppColor.error
                                            : null,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 8.sp),
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'CUSTOMER'.tr,
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
                                'AMOUNT'.tr,
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
                            widget.order.customerName.toString(),
                            style: GoogleFonts.rubik(
                                color: AppColor.fontColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            widget.order.totalCurrencyPrice.toString(),
                            style: GoogleFonts.roboto(
                                color: AppColor.fontColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            widget.order.orderDatetime.toString(),
                            style: GoogleFonts.rubik(
                                color: AppColor.fontColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 18.h,
                    decoration: BoxDecoration(
                      color: widget.order.status == 1
                          ? AppColor.orderPending
                          : widget.order.status == 4
                              ? AppColor.processingOrder
                              : widget.order.status == 7
                                  ? AppColor.processingOrder
                                  : widget.order.status == 13
                                      ? AppColor.orderDelivered
                                      : widget.order.status == 16
                                          ? AppColor.canceled
                                          : widget.order.status == 19
                                              ? AppColor.canceled
                                              : widget.order.status == 22
                                                  ? AppColor.canceled
                                                  : AppColor.primaryColor1,
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(4.r),
                        child: Text(
                          widget.order.statusName.toString(),
                          style: GoogleFonts.rubik(
                              color: widget.order.status == 1
                                  ? AppColor.orderPendingText
                                  : widget.order.status == 4
                                      ? AppColor.green
                                      : widget.order.status == 7
                                          ? AppColor.green
                                          : widget.order.status == 13
                                              ? AppColor.orderDeliveredText
                                              : widget.order.status == 16
                                                  ? AppColor.error
                                                  : widget.order.status == 19
                                                      ? AppColor.error
                                                      : widget.order.status ==
                                                              22
                                                          ? AppColor.error
                                                          : AppColor
                                                              .primaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 8.sp),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'SEE_ORDER_DETAILS'.tr,
                        style: GoogleFonts.rubik(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      box.read('languageCode') == 'ar'
                          ? Transform.rotate(
                              angle: pi,
                              child: SvgPicture.asset(
                                Images.iconArrowRight,
                                height: 12.h,
                                width: 12.w,
                                color: AppColor.primaryColor,
                              ),
                            )
                          : SvgPicture.asset(
                              Images.iconArrowRight,
                              height: 12.h,
                              width: 12.w,
                              color: AppColor.primaryColor,
                            )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
