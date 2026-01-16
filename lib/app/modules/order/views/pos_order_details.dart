// ignore_for_file: sort_child_properties_last, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, unused_element, prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking_admin/app/data/repository/pos_order_details_repo.dart';
import 'package:foodking_admin/app/modules/order/controller/pos_order_controller.dart';
import 'package:foodking_admin/app/modules/order/views/pos_print_invoice.dart';
import 'package:foodking_admin/widget/custom_snackbar.dart';
import 'package:foodking_admin/widget/loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../data/repository/order_details_repo.dart';

class POSOrderDetailsView extends StatefulWidget {
  final int? orderId;
  const POSOrderDetailsView({super.key, this.orderId});

  @override
  State<POSOrderDetailsView> createState() => _StatusViewViewState();
}

class _StatusViewViewState extends State<POSOrderDetailsView> {
  final GlobalKey<State<StatefulWidget>> printKey = GlobalKey();

  POSOrderController order = Get.put(POSOrderController());

  @override
  void initState() {
    super.initState();
    order.getPOSOrderDetails(id: widget.orderId!);
    order.getDeliveryBoyList();
    order.getCompanyInfo();
  }

  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: -5,
        title: Text(
          'ORDER_STATUS'.tr,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: SvgPicture.asset(Images.back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () =>
            order.posOrderDetailsMap.isNotEmpty
                ? Stack(
                  children: [
                    RefreshIndicator(
                      color: AppColor.primaryColor,
                      onRefresh: () async {
                        order.getPOSOrderDetails(id: widget.orderId!);
                      },
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(16.r),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColor.itembg,
                                            offset: const Offset(0.0, 0.0),
                                            blurRadius: 5.0.r,
                                            spreadRadius: 1.0.r,
                                          ),
                                        ],

                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.r),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    Images.reserve,
                                                    height: 16.h,
                                                    width: 16.w,
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Text(
                                                    'ORDER_ID'.tr,
                                                    style: GoogleFonts.rubik(
                                                      color: AppColor.gray,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style: GoogleFonts.rubik(
                                                      color: AppColor.gray,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Text(
                                                    '#${order.posOrderDetailsModel!.data!.orderSerialNo}',
                                                    style: GoogleFonts.rubik(
                                                      color: AppColor.fontColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  SizedBox(width: 12.w),
                                                  Container(
                                                    height: 18.h,
                                                    //width: 47.w,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .paymentStatus ==
                                                                  5
                                                              ? AppColor.paid
                                                              : order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .paymentStatus ==
                                                                  10
                                                              ? AppColor.unpaid
                                                              : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            9.r,
                                                          ),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                          4.r,
                                                        ),
                                                        child: Text(
                                                          order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .paymentStatus ==
                                                                  5
                                                              ? 'PAID'.tr
                                                              : order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .paymentStatus ==
                                                                  10
                                                              ? 'UNPAID'.tr
                                                              : 'UNPAID'.tr,
                                                          style: GoogleFonts.rubik(
                                                            color:
                                                                order
                                                                            .posOrderDetailsModel!
                                                                            .data!
                                                                            .paymentStatus ==
                                                                        5
                                                                    ? AppColor
                                                                        .success
                                                                    : order
                                                                            .posOrderDetailsModel!
                                                                            .data!
                                                                            .paymentStatus ==
                                                                        10
                                                                    ? AppColor
                                                                        .error
                                                                    : null, //paid AppColor.success
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 8.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 12.w),
                                                  Container(
                                                    height: 18.h,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .status ==
                                                                  1
                                                              ? AppColor
                                                                  .orderPending
                                                              : order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .status ==
                                                                  4
                                                              ? AppColor
                                                                  .processingOrder
                                                              : order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .status ==
                                                                  7
                                                              ? AppColor
                                                                  .processingOrder
                                                              : order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .status ==
                                                                  8
                                                              ? AppColor
                                                                  .processingOrder
                                                              : order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .status ==
                                                                  13
                                                              ? AppColor
                                                                  .orderDelivered
                                                              : order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .status ==
                                                                  16
                                                              ? AppColor
                                                                  .canceled
                                                              : order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .status ==
                                                                  19
                                                              ? AppColor
                                                                  .canceled
                                                              : order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .status ==
                                                                  22
                                                              ? AppColor
                                                                  .canceled
                                                              : AppColor
                                                                  .primaryColor1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5.r,
                                                          ),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                          4.r,
                                                        ),
                                                        child: Text(
                                                          order
                                                              .posOrderDetailsModel!
                                                              .data!
                                                              .statusName
                                                              .toString(),
                                                          style: GoogleFonts.rubik(
                                                            color:
                                                                order
                                                                            .posOrderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        1
                                                                    ? AppColor
                                                                        .orderPendingText
                                                                    : order
                                                                            .posOrderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        4
                                                                    ? AppColor
                                                                        .green
                                                                    : order
                                                                            .posOrderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        7
                                                                    ? AppColor
                                                                        .green
                                                                    : order
                                                                            .posOrderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        8
                                                                    ? AppColor
                                                                        .green
                                                                    : order
                                                                            .posOrderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        13
                                                                    ? AppColor
                                                                        .orderDeliveredText
                                                                    : order
                                                                            .posOrderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        16
                                                                    ? AppColor
                                                                        .error
                                                                    : order
                                                                            .posOrderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        19
                                                                    ? AppColor
                                                                        .error
                                                                    : order
                                                                            .posOrderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        22
                                                                    ? AppColor
                                                                        .error
                                                                    : AppColor
                                                                        .primaryColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 8.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 12.h),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex:
                                                      box.read(
                                                                'languageCode',
                                                              ) ==
                                                              'fr'
                                                          ? 5
                                                          : 3,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'PAYMENT_TYPE'.tr,
                                                            style: GoogleFonts.rubik(
                                                              color:
                                                                  AppColor
                                                                      .fontColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                          Text(
                                                            ':',
                                                            style: GoogleFonts.rubik(
                                                              color:
                                                                  AppColor
                                                                      .fontColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'ORDER_TYPE'.tr,
                                                            style: GoogleFonts.rubik(
                                                              color:
                                                                  AppColor
                                                                      .fontColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                          Text(
                                                            ':',
                                                            style: GoogleFonts.rubik(
                                                              color:
                                                                  AppColor
                                                                      .fontColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'DELIVERY_TIME'.tr,
                                                            style: GoogleFonts.rubik(
                                                              color:
                                                                  AppColor
                                                                      .fontColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                          Text(
                                                            ':',
                                                            style: GoogleFonts.rubik(
                                                              color:
                                                                  AppColor
                                                                      .fontColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 4.w),
                                                Expanded(
                                                  flex: 8,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        order
                                                                    .posOrderDetailsModel!
                                                                    .data!
                                                                    .posPaymentMethod ==
                                                                1
                                                            ? "CASH".tr
                                                            : order
                                                                    .posOrderDetailsModel!
                                                                    .data!
                                                                    .posPaymentMethod ==
                                                                2
                                                            ? "CARD".tr +
                                                                " (${order.posOrderDetailsModel!.data!.posPaymentNote})"
                                                            : order
                                                                    .posOrderDetailsModel!
                                                                    .data!
                                                                    .posPaymentMethod ==
                                                                3
                                                            ? "MOBILE_BANKING"
                                                                    .tr +
                                                                " (${order.posOrderDetailsModel!.data!.posPaymentNote})"
                                                            : order
                                                                    .posOrderDetailsModel!
                                                                    .data!
                                                                    .posPaymentMethod ==
                                                                4
                                                            ? "OTHER".tr +
                                                                " (${order.posOrderDetailsModel!.data!.posPaymentNote})"
                                                            : "CASH".tr,
                                                        style: GoogleFonts.rubik(
                                                          color:
                                                              AppColor
                                                                  .fontColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Text(
                                                        order
                                                                    .posOrderDetailsModel!
                                                                    .data!
                                                                    .orderType ==
                                                                5
                                                            ? 'DELIVERY'.tr
                                                            : order
                                                                    .posOrderDetailsModel!
                                                                    .data!
                                                                    .orderType ==
                                                                10
                                                            ? 'TAKEAWAY'.tr
                                                            : order
                                                                    .posOrderDetailsModel!
                                                                    .data!
                                                                    .orderType ==
                                                                15
                                                            ? 'POS'.tr
                                                            : order
                                                                    .posOrderDetailsModel!
                                                                    .data!
                                                                    .orderType ==
                                                                20
                                                            ? 'DINING_TABLE'.tr
                                                            : '',
                                                        style: GoogleFonts.rubik(
                                                          color:
                                                              AppColor
                                                                  .fontColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Text(
                                                        order
                                                                .posOrderDetailsModel!
                                                                .data!
                                                                .deliveryDate
                                                                .toString() +
                                                            " " +
                                                            order
                                                                .posOrderDetailsModel!
                                                                .data!
                                                                .deliveryTime
                                                                .toString(),
                                                        style: GoogleFonts.rubik(
                                                          color:
                                                              AppColor
                                                                  .fontColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  //cart summary section
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 16.w,
                                      right: 16.w,
                                      bottom: 20.h,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColor.itembg,
                                            offset: const Offset(0.0, 0.0),
                                            blurRadius: 5.0.r,
                                            spreadRadius: 1.0.r,
                                          ),
                                          //BoxShadow
                                          //BoxShadow
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              "ORDER_DETAILS".tr,
                                              style: GoogleFonts.rubik(
                                                color: AppColor.fontColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                          ListView.builder(
                                            primary: false,
                                            shrinkWrap: true,
                                            itemCount:
                                                order
                                                    .posOrderDetailsModel!
                                                    .data!
                                                    .orderItems!
                                                    .length,
                                            itemBuilder: (
                                              BuildContext context,
                                              index,
                                            ) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                  left: 8.w,
                                                  right: 8.w,
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 65.h,
                                                      child: Row(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets.only(
                                                                      left: 8.w,
                                                                      right:
                                                                          8.w,
                                                                    ),
                                                                child: SizedBox(
                                                                  width: 70.w,
                                                                  height: 70.h,
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                          Radius.circular(
                                                                            8.r,
                                                                          ),
                                                                        ),
                                                                    child: CachedNetworkImage(
                                                                      imageUrl:
                                                                          order
                                                                              .posOrderDetailsModel!
                                                                              .data!
                                                                              .orderItems![index]
                                                                              .itemImage!,
                                                                      imageBuilder:
                                                                          (
                                                                            context,
                                                                            imageProvider,
                                                                          ) => Container(
                                                                            decoration: BoxDecoration(
                                                                              image: DecorationImage(
                                                                                image:
                                                                                    imageProvider,
                                                                                fit:
                                                                                    BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      placeholder:
                                                                          (
                                                                            context,
                                                                            url,
                                                                          ) => Shimmer.fromColors(
                                                                            child: Container(
                                                                              height:
                                                                                  130,
                                                                              width:
                                                                                  200,
                                                                              color:
                                                                                  Colors.grey,
                                                                            ),
                                                                            baseColor:
                                                                                Colors.grey[300]!,
                                                                            highlightColor:
                                                                                Colors.grey[400]!,
                                                                          ),
                                                                      errorWidget:
                                                                          (
                                                                            context,
                                                                            url,
                                                                            error,
                                                                          ) => const Icon(
                                                                            Icons.error,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 22.h,
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        20.r,
                                                                      ), //or 15.0
                                                                  child: Container(
                                                                    height:
                                                                        20.h,
                                                                    width: 20.w,
                                                                    color:
                                                                        AppColor
                                                                            .fontColor,
                                                                    child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child: Text(
                                                                        order
                                                                            .posOrderDetailsModel!
                                                                            .data!
                                                                            .orderItems![index]
                                                                            .quantity
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(width: 10.w),
                                                          SizedBox(
                                                            height: 70.h,
                                                            width: 200.w,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .orderItems![index]
                                                                      .itemName
                                                                      .toString(),
                                                                  style: GoogleFonts.rubik(
                                                                    color:
                                                                        AppColor
                                                                            .fontColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14.sp,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                SizedBox(
                                                                  height: 2.h,
                                                                ),
                                                                order
                                                                            .posOrderDetailsModel!
                                                                            .data!
                                                                            .orderItems![index]
                                                                            .itemVariations !=
                                                                        null
                                                                    ? SizedBox(
                                                                      width:
                                                                          240.w,
                                                                      height:
                                                                          16.h,
                                                                      child: ListView.builder(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount:
                                                                            order.posOrderDetailsModel!.data!.orderItems![index].itemVariations!.length,
                                                                        itemBuilder: (
                                                                          BuildContext
                                                                          context,
                                                                          i,
                                                                        ) {
                                                                          return Text(
                                                                            index ==
                                                                                    order.posOrderDetailsModel!.data!.orderItems![index].itemVariations!.length -
                                                                                        1
                                                                                ? "${order.posOrderDetailsModel!.data!.orderItems![index].itemVariations![i].variationName} : ${order.posOrderDetailsModel!.data!.orderItems![index].itemVariations![i].name}."
                                                                                : "${order.posOrderDetailsModel!.data!.orderItems![index].itemVariations![i].variationName} : ${order.posOrderDetailsModel!.data!.orderItems![index].itemVariations![i].name}, ",
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.gray,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            maxLines:
                                                                                2,
                                                                          );
                                                                        },
                                                                      ),
                                                                    )
                                                                    : const SizedBox.shrink(),
                                                                SizedBox(
                                                                  height: 4.h,
                                                                ),
                                                                Text(
                                                                  order
                                                                      .posOrderDetailsModel!
                                                                      .data!
                                                                      .orderItems![index]
                                                                      .price
                                                                      .toString(),
                                                                  style: GoogleFonts.roboto(
                                                                    color:
                                                                        AppColor
                                                                            .fontColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14.sp,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 10.w,
                                                      ),
                                                      child:
                                                          orderDetailsVariationSection(
                                                            index,
                                                          ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 10.w,
                                                      ),
                                                      child:
                                                          orderItemInstructionSection(
                                                            index,
                                                          ),
                                                    ),
                                                    const Divider(),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 12.w,
                                              right: 12.w,
                                              top: 16.h,
                                              bottom: 12.h,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                border: Border.all(
                                                  color: AppColor.itembg,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                      8.0.r,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'SUBTOTAL'.tr,
                                                          style: GoogleFonts.rubik(
                                                            color:
                                                                AppColor
                                                                    .fontColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          order
                                                              .posOrderDetailsModel!
                                                              .data!
                                                              .subtotalCurrencyPrice
                                                              .toString(),
                                                          style: GoogleFonts.roboto(
                                                            color:
                                                                AppColor
                                                                    .fontColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                      8.0.r,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'DISCOUNT'.tr,
                                                          style: GoogleFonts.rubik(
                                                            color:
                                                                AppColor
                                                                    .fontColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          order
                                                              .posOrderDetailsModel!
                                                              .data!
                                                              .discountCurrencyPrice
                                                              .toString(),
                                                          style: GoogleFonts.roboto(
                                                            color:
                                                                AppColor
                                                                    .fontColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  order
                                                              .posOrderDetailsModel!
                                                              .data!
                                                              .orderType ==
                                                          15
                                                      ? SizedBox(height: 0.h)
                                                      : Padding(
                                                        padding: EdgeInsets.all(
                                                          8.0.r,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'DELIVERY_CHARGE'
                                                                  .tr,
                                                              style: GoogleFonts.rubik(
                                                                color:
                                                                    AppColor
                                                                        .fontColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.sp,
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Text(
                                                              order
                                                                  .posOrderDetailsModel!
                                                                  .data!
                                                                  .deliveryChargeCurrencyPrice
                                                                  .toString(),
                                                              style: GoogleFonts.roboto(
                                                                color:
                                                                    AppColor
                                                                        .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                  Text(
                                                    '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: AppColor.gray
                                                          .withOpacity(0.2),
                                                      overflow:
                                                          TextOverflow.fade,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                      8.0.r,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'TOTAL'.tr,
                                                          style: GoogleFonts.rubik(
                                                            color:
                                                                AppColor
                                                                    .fontColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          order
                                                              .posOrderDetailsModel!
                                                              .data!
                                                              .totalCurrencyPrice
                                                              .toString(),
                                                          style: GoogleFonts.roboto(
                                                            color:
                                                                AppColor
                                                                    .fontColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 150.h),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                border: Border(
                                  top: BorderSide(
                                    color: AppColor.dividerColor,
                                    width: 1.h,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 16.h),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 16.w,
                                      right: 16.w,
                                      bottom: 16.h,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.r),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                PopupMenuButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(10.r),
                                                        ),
                                                  ),
                                                  position:
                                                      PopupMenuPosition.under,
                                                  itemBuilder:
                                                      (ctx) => [
                                                        PopupMenuItem(
                                                          onTap: () async {
                                                            var response =
                                                                await POSOrderDetailsRepo.changePaymentStatus(
                                                                  orderId:
                                                                      widget
                                                                          .orderId!,
                                                                  statusCode: 5,
                                                                );

                                                            if (response
                                                                    .statusCode ==
                                                                200) {
                                                              customSnackbar(
                                                                "SUCCESS".tr,
                                                                'STATUS_UPDATED_SUCCESSFULLY'
                                                                    .tr,
                                                                AppColor
                                                                    .success,
                                                              );
                                                              order.getPOSOrderDetails(
                                                                id:
                                                                    widget
                                                                        .orderId!,
                                                              );
                                                              order
                                                                  .getPOSOrdersList();
                                                            } else {
                                                              print(
                                                                response
                                                                    .statusMessage,
                                                              );
                                                            }
                                                          },
                                                          child: Text(
                                                            "PAID".tr,
                                                            style: GoogleFonts.rubik(
                                                              color:
                                                                  AppColor
                                                                      .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14.sp,
                                                            ),
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          onTap: () async {
                                                            var response =
                                                                await POSOrderDetailsRepo.changePaymentStatus(
                                                                  orderId:
                                                                      widget
                                                                          .orderId!,
                                                                  statusCode:
                                                                      10,
                                                                );

                                                            if (response
                                                                    .statusCode ==
                                                                200) {
                                                              customSnackbar(
                                                                "SUCCESS".tr,
                                                                'STATUS_UPDATED_SUCCESSFULLY'
                                                                    .tr,
                                                                AppColor
                                                                    .success,
                                                              );
                                                              order.getPOSOrderDetails(
                                                                id:
                                                                    widget
                                                                        .orderId!,
                                                              );
                                                              order
                                                                  .getPOSOrdersList();
                                                            } else {
                                                              print(
                                                                response
                                                                    .statusMessage,
                                                              );
                                                            }
                                                          },
                                                          child: Text(
                                                            "UNPAID".tr,
                                                            style: GoogleFonts.rubik(
                                                              color:
                                                                  AppColor
                                                                      .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                  child: Container(
                                                    height: 40.h,
                                                    width: 150.w,
                                                    decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10.r,
                                                          ),
                                                      border: Border.all(
                                                        color:
                                                            AppColor
                                                                .primaryColor,
                                                        width: 1.w,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                              left: 10.w,
                                                              right: 10.w,
                                                            ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              order
                                                                          .posOrderDetailsModel!
                                                                          .data!
                                                                          .paymentStatus ==
                                                                      5
                                                                  ? 'PAID'.tr
                                                                  : order
                                                                          .posOrderDetailsModel!
                                                                          .data!
                                                                          .paymentStatus ==
                                                                      10
                                                                  ? 'UNPAID'.tr
                                                                  : 'UNPAID'.tr,
                                                              style: GoogleFonts.rubik(
                                                                color:
                                                                    AppColor
                                                                        .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.sp,
                                                              ),
                                                            ),
                                                            SvgPicture.asset(
                                                              Images
                                                                  .iconArrowDown,
                                                              height: 6.h,
                                                              width: 6.w,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                PopupMenuButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(10.r),
                                                        ),
                                                  ),
                                                  position:
                                                      PopupMenuPosition.under,
                                                  itemBuilder:
                                                      (ctx) => [
                                                        PopupMenuItem(
                                                          onTap: () async {
                                                            var response =
                                                                await POSOrderDetailsRepo.changeOrderStatus(
                                                                  orderId:
                                                                      widget
                                                                          .orderId!,
                                                                  statusCode: 4,
                                                                );

                                                            if (response
                                                                    .statusCode ==
                                                                200) {
                                                              customSnackbar(
                                                                "SUCCESS".tr,
                                                                'STATUS_UPDATED_SUCCESSFULLY'
                                                                    .tr,
                                                                AppColor
                                                                    .success,
                                                              );
                                                              order.getPOSOrderDetails(
                                                                id:
                                                                    widget
                                                                        .orderId!,
                                                              );
                                                              order
                                                                  .getPOSOrdersList();
                                                            } else {
                                                              print(
                                                                response
                                                                    .statusMessage,
                                                              );
                                                            }
                                                          },
                                                          child: Text(
                                                            'ACCEPT'.tr,
                                                            style: GoogleFonts.rubik(
                                                              color:
                                                                  AppColor
                                                                      .fontColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          onTap: () async {
                                                            var response =
                                                                await POSOrderDetailsRepo.changeOrderStatus(
                                                                  orderId:
                                                                      widget
                                                                          .orderId!,
                                                                  statusCode: 7,
                                                                );

                                                            if (response
                                                                    .statusCode ==
                                                                200) {
                                                              customSnackbar(
                                                                "SUCCESS".tr,
                                                                'STATUS_UPDATED_SUCCESSFULLY'
                                                                    .tr,
                                                                AppColor
                                                                    .success,
                                                              );
                                                              order.getPOSOrderDetails(
                                                                id:
                                                                    widget
                                                                        .orderId!,
                                                              );
                                                              order
                                                                  .getPOSOrdersList();
                                                            } else {
                                                              print(
                                                                response
                                                                    .statusMessage,
                                                              );
                                                            }
                                                          },
                                                          child: Text(
                                                            'PROCESSING'.tr,
                                                            style: GoogleFonts.rubik(
                                                              color:
                                                                  AppColor
                                                                      .fontColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          onTap: () async {
                                                            var response =
                                                                await POSOrderDetailsRepo.changeOrderStatus(
                                                                  orderId:
                                                                      widget
                                                                          .orderId!,
                                                                  statusCode:
                                                                      13,
                                                                );

                                                            if (response
                                                                    .statusCode ==
                                                                200) {
                                                              customSnackbar(
                                                                "SUCCESS".tr,
                                                                'STATUS_UPDATED_SUCCESSFULLY'
                                                                    .tr,
                                                                AppColor
                                                                    .success,
                                                              );
                                                              order.getPOSOrderDetails(
                                                                id:
                                                                    widget
                                                                        .orderId!,
                                                              );
                                                              order
                                                                  .getPOSOrdersList();
                                                            } else {
                                                              print(
                                                                response
                                                                    .statusMessage,
                                                              );
                                                            }
                                                          },
                                                          child: Text(
                                                            'DELIVERED'.tr,
                                                            style: GoogleFonts.rubik(
                                                              color:
                                                                  AppColor
                                                                      .fontColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                  child: Container(
                                                    height: 40.h,
                                                    width: 150.w,
                                                    decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10.r,
                                                          ),
                                                      border: Border.all(
                                                        color:
                                                            AppColor
                                                                .primaryColor,
                                                        width: 1.w,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                              left: 10.w,
                                                              right: 10.w,
                                                            ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              order
                                                                          .posOrderDetailsModel!
                                                                          .data!
                                                                          .status ==
                                                                      1
                                                                  ? 'PENDING'.tr
                                                                  : order
                                                                          .posOrderDetailsModel!
                                                                          .data!
                                                                          .status ==
                                                                      4
                                                                  ? 'ACCEPT'.tr
                                                                  : order
                                                                          .posOrderDetailsModel!
                                                                          .data!
                                                                          .status ==
                                                                      7
                                                                  ? 'PROCESSING'
                                                                      .tr
                                                                  : order
                                                                          .posOrderDetailsModel!
                                                                          .data!
                                                                          .status ==
                                                                      8
                                                                  ? 'PREPARED'
                                                                      .tr
                                                                  : order
                                                                          .posOrderDetailsModel!
                                                                          .data!
                                                                          .status ==
                                                                      10
                                                                  ? 'OUT_FOR_DELIVERY'
                                                                      .tr
                                                                  : order
                                                                          .posOrderDetailsModel!
                                                                          .data!
                                                                          .status ==
                                                                      13
                                                                  ? 'DELIVERED'
                                                                      .tr
                                                                  : order
                                                                          .posOrderDetailsModel!
                                                                          .data!
                                                                          .status ==
                                                                      16
                                                                  ? 'CANCELED'
                                                                      .tr
                                                                  : order
                                                                          .posOrderDetailsModel!
                                                                          .data!
                                                                          .status ==
                                                                      19
                                                                  ? 'REJECTED'
                                                                      .tr
                                                                  : order
                                                                          .posOrderDetailsModel!
                                                                          .data!
                                                                          .status ==
                                                                      22
                                                                  ? 'RETURNED'
                                                                      .tr
                                                                  : '',
                                                              style: GoogleFonts.rubik(
                                                                color:
                                                                    AppColor
                                                                        .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.sp,
                                                              ),
                                                            ),
                                                            SvgPicture.asset(
                                                              Images
                                                                  .iconArrowDown,
                                                              height: 6.h,
                                                              width: 6.w,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                if (order
                                                        .posOrderDetailsModel
                                                        ?.data
                                                        ?.orderType ==
                                                    5)
                                                  PopupMenuButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                Radius.circular(
                                                                  10.r,
                                                                ),
                                                              ),
                                                        ),
                                                    position:
                                                        PopupMenuPosition.under,
                                                    itemBuilder:
                                                        (ctx) => List.generate(
                                                          order
                                                              .deliveryBoyModel!
                                                              .data!
                                                              .length,
                                                          (
                                                            index,
                                                          ) => PopupMenuItem(
                                                            onTap: () async {
                                                              var response = await OrderDetailsRepo.changeDeliveryBoyPos(
                                                                orderId:
                                                                    widget
                                                                        .orderId!,
                                                                deliveryBoyId:
                                                                    order
                                                                        .deliveryBoyModel!
                                                                        .data![index]
                                                                        .id!,
                                                              );

                                                              if (response
                                                                      .statusCode ==
                                                                  200) {
                                                                customSnackbar(
                                                                  "SUCCESS".tr,
                                                                  'STATUS_UPDATED_SUCCESSFULLY'
                                                                      .tr,
                                                                  AppColor
                                                                      .success,
                                                                );
                                                                order.getPOSOrderDetails(
                                                                  id:
                                                                      widget
                                                                          .orderId!,
                                                                );
                                                                order
                                                                    .getPOSOrdersList();
                                                              } else {
                                                                print(
                                                                  response
                                                                      .statusMessage,
                                                                );
                                                              }
                                                            },
                                                            child: Text(
                                                              order
                                                                  .deliveryBoyModel!
                                                                  .data![index]
                                                                  .name
                                                                  .toString(),
                                                              style: GoogleFonts.rubik(
                                                                color:
                                                                    AppColor
                                                                        .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.sp,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    child: Container(
                                                      height: 40.h,
                                                      width: 150.w,
                                                      decoration: BoxDecoration(
                                                        color: AppColor.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10.r,
                                                            ),
                                                        border: Border.all(
                                                          color:
                                                              AppColor
                                                                  .primaryColor,
                                                          width: 1.w,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                left: 10.w,
                                                                right: 10.w,
                                                              ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  order.posOrderDetailsModel?.data?.deliveryBoy !=
                                                                          null
                                                                      ? order
                                                                              .posOrderDetailsModel
                                                                              ?.data
                                                                              ?.deliveryBoy
                                                                              ?.name ??
                                                                          ''
                                                                      : "SELECT_DELIVERY_BOY"
                                                                          .tr,
                                                                  style: GoogleFonts.rubik(
                                                                    color:
                                                                        AppColor
                                                                            .primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        14.sp,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              SvgPicture.asset(
                                                                Images
                                                                    .iconArrowDown,
                                                                height: 6.h,
                                                                width: 6.w,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    Get.to(
                                                      () => POSPrintInvoice(
                                                        orderDetails:
                                                            order
                                                                .posOrderDetailsModel!
                                                                .data!,
                                                        comapnyInfo:
                                                            order
                                                                .companyInfo!
                                                                .data!,
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 40.h,
                                                    width: 150.w,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColor.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10.r,
                                                          ),
                                                      border: Border.all(
                                                        color: Color(
                                                          0xFFFF006B,
                                                        ),
                                                        width: 1.w,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "PRINT_INVOICE".tr,
                                                        style:
                                                            GoogleFonts.rubik(
                                                              color:
                                                                  AppColor
                                                                      .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14.sp,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white60,
                  child: const Center(child: LoaderCircle()),
                ),
      ),
    );
  }
}

Widget orderItemInstructionSection(int i) {
  final orderController = Get.find<POSOrderController>();
  return Column(
    children: [
      orderController.posOrderDetailsModel!.data!.orderItems![i].instruction !=
                  null &&
              orderController
                  .posOrderDetailsModel!
                  .data!
                  .orderItems![i]
                  .instruction!
                  .isNotEmpty
          ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "INSTRUCTION".tr + ' : ',
                style: GoogleFonts.rubik(
                  color: AppColor.gray,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(
                width: Get.width - 160,
                child: Text(
                  orderController
                      .posOrderDetailsModel!
                      .data!
                      .orderItems![i]
                      .instruction
                      .toString(),
                  style: GoogleFonts.rubik(
                    color: AppColor.gray,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          )
          : const SizedBox.shrink(),
    ],
  );
}

Widget orderDetailsVariationSection(int i) {
  final orderController = Get.find<POSOrderController>();
  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: Column(
      children: [
        orderController.posOrderDetailsModel!.data!.orderItems![i].itemExtras !=
                    null &&
                orderController
                    .posOrderDetailsModel!
                    .data!
                    .orderItems![i]
                    .itemExtras!
                    .isNotEmpty
            ? Padding(
              padding: EdgeInsets.only(bottom: 4.h, right: 8.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "EXTRAS".tr,
                    style: GoogleFonts.rubik(
                      color: AppColor.gray,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    width: 240.w,
                    height: 15.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:
                          orderController
                              .posOrderDetailsModel!
                              .data!
                              .orderItems![i]
                              .itemExtras!
                              .length,
                      itemBuilder: (BuildContext context, index) {
                        return Text(
                          index ==
                                  orderController
                                          .posOrderDetailsModel!
                                          .data!
                                          .orderItems![i]
                                          .itemExtras!
                                          .length -
                                      1
                              ? "${orderController.posOrderDetailsModel!.data!.orderItems![i].itemExtras![index].name}."
                              : "${orderController.posOrderDetailsModel!.data!.orderItems![i].itemExtras![index].name},",
                          style: GoogleFonts.rubik(
                            color: AppColor.gray,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
            : const SizedBox.shrink(),
      ],
    ),
  );
}
