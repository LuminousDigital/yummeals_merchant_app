// ignore_for_file: sort_child_properties_last, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, unused_element, prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking_admin/app/data/repository/order_details_repo.dart';
import 'package:foodking_admin/app/modules/order/controller/online_order_controller.dart';
import 'package:foodking_admin/app/modules/order/views/online_print_invoice.dart';
import 'package:foodking_admin/widget/custom_snackbar.dart';
import 'package:foodking_admin/widget/loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../splash/controllers/splash_controller.dart';

class OrderDetailsView extends StatefulWidget {
  final int? orderId;
  final String? orderUuid;
  const OrderDetailsView({super.key, this.orderId, this.orderUuid});

  @override
  State<OrderDetailsView> createState() => _StatusViewViewState();
}

class _StatusViewViewState extends State<OrderDetailsView> {
  TextEditingController reasonController = TextEditingController();
  OnlineOrderController order = Get.put(OnlineOrderController());
  final box = GetStorage();
  bool accept = false;
  @override
  void initState() {
    super.initState();
    if (widget.orderUuid != null) {
      order.getOrderDetailsByUuid(uuid: widget.orderUuid!);
    } else {
      order.getOrderDetails(id: widget.orderId!);
    }
    order.getDeliveryBoyList();
    order.getCompanyInfo();
  }

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
            order.orderDetailsMap.isNotEmpty
                ? Stack(
                  children: [
                    RefreshIndicator(
                      color: AppColor.primaryColor,
                      onRefresh: () async {
                        order.getOrderDetailsByUuid(uuid: widget.orderUuid!);
                        order.getDeliveryBoyList();
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
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
                                          //BoxShadow
                                          //BoxShadow
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
                                                    '#${order.orderDetailsModel?.data?.orderSerialNo}',
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
                                                    decoration: BoxDecoration(
                                                      color:
                                                          order
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.paymentStatus ==
                                                                  5
                                                              ? AppColor.paid
                                                              : order
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.paymentStatus ==
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
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.paymentStatus ==
                                                                  5
                                                              ? 'PAID'.tr
                                                              : order
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.paymentStatus ==
                                                                  10
                                                              ? 'UNPAID'.tr
                                                              : 'UNPAID'.tr,
                                                          style: GoogleFonts.rubik(
                                                            color:
                                                                order
                                                                            .orderDetailsModel
                                                                            ?.data
                                                                            ?.paymentStatus ==
                                                                        5
                                                                    ? AppColor
                                                                        .success
                                                                    : order
                                                                            .orderDetailsModel
                                                                            ?.data
                                                                            ?.paymentStatus ==
                                                                        10
                                                                    ? AppColor
                                                                        .error
                                                                    : null,
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
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.status ==
                                                                  1
                                                              ? AppColor
                                                                  .orderPending
                                                              : order
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.status ==
                                                                  4
                                                              ? AppColor
                                                                  .processingOrder
                                                              : order
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.status ==
                                                                  7
                                                              ? AppColor
                                                                  .processingOrder
                                                              : order
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.status ==
                                                                  8
                                                              ? AppColor
                                                                  .processingOrder
                                                              : order
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.status ==
                                                                  8
                                                              ? AppColor
                                                                  .processingOrder
                                                              : order
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.status ==
                                                                  13
                                                              ? AppColor
                                                                  .orderDelivered
                                                              : order
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.status ==
                                                                  16
                                                              ? AppColor
                                                                  .canceled
                                                              : order
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.status ==
                                                                  19
                                                              ? AppColor
                                                                  .canceled
                                                              : order
                                                                      .orderDetailsModel
                                                                      ?.data
                                                                      ?.status ==
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
                                                                  .orderDetailsModel
                                                                  ?.data
                                                                  ?.statusName
                                                                  .toString() ??
                                                              '',
                                                          style: GoogleFonts.rubik(
                                                            color:
                                                                order
                                                                            .orderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        1
                                                                    ? AppColor
                                                                        .orderPendingText
                                                                    : order
                                                                            .orderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        4
                                                                    ? AppColor
                                                                        .green
                                                                    : order
                                                                            .orderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        7
                                                                    ? AppColor
                                                                        .green
                                                                    : order
                                                                            .orderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        8
                                                                    ? AppColor
                                                                        .green
                                                                    : order
                                                                            .orderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        13
                                                                    ? AppColor
                                                                        .orderDeliveredText
                                                                    : order
                                                                            .orderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        16
                                                                    ? AppColor
                                                                        .error
                                                                    : order
                                                                            .orderDetailsModel!
                                                                            .data!
                                                                            .status ==
                                                                        19
                                                                    ? AppColor
                                                                        .error
                                                                    : order
                                                                            .orderDetailsModel!
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
                                                                        .orderDetailsModel!
                                                                        .data!
                                                                        .paymentStatus ==
                                                                    10 &&
                                                                order
                                                                        .orderDetailsModel!
                                                                        .data!
                                                                        .transaction ==
                                                                    null
                                                            ? 'CASH_ON_DELIVEY'
                                                                .tr
                                                            : order
                                                                    .orderDetailsModel!
                                                                    .data!
                                                                    .transaction !=
                                                                null
                                                            ? order
                                                                .orderDetailsModel!
                                                                .data!
                                                                .transaction!
                                                                .paymentMethod
                                                                .toString()
                                                            : 'CASH_ON_DELIVEY'
                                                                .tr,
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
                                                                    .orderDetailsModel!
                                                                    .data!
                                                                    .orderType ==
                                                                5
                                                            ? 'DELIVERY'.tr
                                                            : order
                                                                    .orderDetailsModel!
                                                                    .data!
                                                                    .orderType ==
                                                                10
                                                            ? 'TAKEAWAY'.tr
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
                                                                .orderDetailsModel!
                                                                .data!
                                                                .deliveryDate
                                                                .toString() +
                                                            " " +
                                                            order
                                                                .orderDetailsModel!
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

                                  customerInformationSection(),

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
                                                    .orderDetailsModel!
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
                                                                              .orderDetailsModel!
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
                                                                            .orderDetailsModel!
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
                                                                      .orderDetailsModel!
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
                                                                            .orderDetailsModel!
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
                                                                            order.orderDetailsModel!.data!.orderItems![index].itemVariations!.length,
                                                                        itemBuilder: (
                                                                          BuildContext
                                                                          context,
                                                                          i,
                                                                        ) {
                                                                          return Text(
                                                                            index ==
                                                                                    order.orderDetailsModel!.data!.orderItems![index].itemVariations!.length -
                                                                                        1
                                                                                ? "${order.orderDetailsModel!.data!.orderItems![index].itemVariations![i].variationName} : ${order.orderDetailsModel!.data!.orderItems![index].itemVariations![i].name}."
                                                                                : "${order.orderDetailsModel!.data!.orderItems![index].itemVariations![i].variationName} : ${order.orderDetailsModel!.data!.orderItems![index].itemVariations![i].name}, ",
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
                                                                      .orderDetailsModel!
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
                                                              .orderDetailsModel!
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
                                                              .orderDetailsModel!
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
                                                              .orderDetailsModel!
                                                              .data!
                                                              .orderType ==
                                                          10
                                                      ? SizedBox()
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
                                                                  .orderDetailsModel!
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
                                                              .orderDetailsModel!
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
                                  SizedBox(height: 250.h),
                                ],
                              ),
                            ),
                          ),
                          order.orderDetailsModel!.data!.status == 16 ||
                                  order.orderDetailsModel!.data!.status == 19
                              ? Container()
                              : Positioned(
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
                                            child:
                                                order
                                                            .orderDetailsModel!
                                                            .data!
                                                            .status !=
                                                        1
                                                    ? Column(
                                                      children: [
                                                        order
                                                                    .orderDetailsModel!
                                                                    .data!
                                                                    .orderType ==
                                                                5
                                                            ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                PopupMenuButton(
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                          Radius.circular(
                                                                            10.r,
                                                                          ),
                                                                        ),
                                                                  ),
                                                                  position:
                                                                      PopupMenuPosition
                                                                          .under,
                                                                  itemBuilder:
                                                                      (
                                                                        ctx,
                                                                      ) => List.generate(
                                                                        order
                                                                            .deliveryBoyModel!
                                                                            .data!
                                                                            .length,
                                                                        (
                                                                          index,
                                                                        ) => PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeDeliveryBoy(
                                                                              uuid:
                                                                                  widget.orderUuid!,
                                                                              deliveryBoyId:
                                                                                  order.deliveryBoyModel!.data![index].id!,
                                                                            );

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              order.getOrderDetailsByUuid(
                                                                                uuid:
                                                                                    widget.orderUuid!,
                                                                              );
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            order.deliveryBoyModel!.data![index].name.toString(),
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.primaryColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  14.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  child: Container(
                                                                    height:
                                                                        40.h,
                                                                    width:
                                                                        150.w,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          AppColor
                                                                              .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            10.r,
                                                                          ),
                                                                      border: Border.all(
                                                                        color:
                                                                            AppColor.primaryColor,
                                                                        width:
                                                                            1.w,
                                                                      ),
                                                                    ),
                                                                    child: Center(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(
                                                                          left:
                                                                              10.w,
                                                                          right:
                                                                              10.w,
                                                                        ),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Text(
                                                                                order.orderDetailsModel!.data!.deliveryBoy !=
                                                                                        null
                                                                                    ? order.orderDetailsModel!.data!.deliveryBoy!.name.toString()
                                                                                    : "SELECT_DELIVERY_BOY".tr,
                                                                                style: GoogleFonts.rubik(
                                                                                  color:
                                                                                      AppColor.primaryColor,
                                                                                  fontWeight:
                                                                                      FontWeight.w400,
                                                                                  fontSize:
                                                                                      14.sp,
                                                                                ),
                                                                                maxLines:
                                                                                    1,
                                                                                overflow:
                                                                                    TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                                  10.w,
                                                                            ),
                                                                            SvgPicture.asset(
                                                                              Images.iconArrowDown,
                                                                              height:
                                                                                  6.h,
                                                                              width:
                                                                                  6.w,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                order
                                                                            .orderDetailsModel!
                                                                            .data!
                                                                            .transaction !=
                                                                        null
                                                                    ? PopupMenuButton(
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(
                                                                          Radius.circular(
                                                                            10.r,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      position:
                                                                          PopupMenuPosition
                                                                              .under,
                                                                      itemBuilder:
                                                                          (
                                                                            ctx,
                                                                          ) => [
                                                                            PopupMenuItem(
                                                                              onTap: () async {
                                                                                var response = await OrderDetailsRepo.changeOrderStatus(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                  statusCode:
                                                                                      4,
                                                                                );
                                                                                if (response.statusCode ==
                                                                                    200) {
                                                                                  customSnackbar(
                                                                                    "SUCCESS".tr,
                                                                                    'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                    AppColor.success,
                                                                                  );
                                                                                  order.getOrderDetailsByUuid(
                                                                                    uuid:
                                                                                        widget.orderUuid!,
                                                                                  );
                                                                                  order.getOnlineOrdersList();
                                                                                } else {
                                                                                  print(
                                                                                    response.statusMessage,
                                                                                  );
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                'ACCEPT'.tr,
                                                                                style: GoogleFonts.rubik(
                                                                                  color:
                                                                                      AppColor.fontColor,
                                                                                  fontWeight:
                                                                                      FontWeight.w400,
                                                                                  fontSize:
                                                                                      12.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              onTap: () async {
                                                                                var response = await OrderDetailsRepo.changeOrderStatus(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                  statusCode:
                                                                                      7,
                                                                                );

                                                                                if (response.statusCode ==
                                                                                    200) {
                                                                                  customSnackbar(
                                                                                    "SUCCESS".tr,
                                                                                    'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                    AppColor.success,
                                                                                  );
                                                                                  order.getOrderDetailsByUuid(
                                                                                    uuid:
                                                                                        widget.orderUuid!,
                                                                                  );
                                                                                  order.getOnlineOrdersList();
                                                                                } else {
                                                                                  print(
                                                                                    response.statusMessage,
                                                                                  );
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                'PROCESSING'.tr,
                                                                                style: GoogleFonts.rubik(
                                                                                  color:
                                                                                      AppColor.fontColor,
                                                                                  fontWeight:
                                                                                      FontWeight.w400,
                                                                                  fontSize:
                                                                                      12.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              onTap: () async {
                                                                                var response = await OrderDetailsRepo.changeOrderStatus(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                  statusCode:
                                                                                      8,
                                                                                );

                                                                                if (response.statusCode ==
                                                                                    200) {
                                                                                  customSnackbar(
                                                                                    "SUCCESS".tr,
                                                                                    'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                    AppColor.success,
                                                                                  );
                                                                                  order.getOrderDetailsByUuid(
                                                                                    uuid:
                                                                                        widget.orderUuid!,
                                                                                  );
                                                                                  order.getOnlineOrdersList();
                                                                                } else {
                                                                                  print(
                                                                                    response.statusMessage,
                                                                                  );
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                'PREPARED'.tr,
                                                                                style: GoogleFonts.rubik(
                                                                                  color:
                                                                                      AppColor.fontColor,
                                                                                  fontWeight:
                                                                                      FontWeight.w400,
                                                                                  fontSize:
                                                                                      12.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              onTap: () async {
                                                                                var response = await OrderDetailsRepo.changeOrderStatus(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                  statusCode:
                                                                                      10,
                                                                                );

                                                                                if (response.statusCode ==
                                                                                    200) {
                                                                                  customSnackbar(
                                                                                    "SUCCESS".tr,
                                                                                    'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                    AppColor.success,
                                                                                  );
                                                                                  order.getOrderDetailsByUuid(
                                                                                    uuid:
                                                                                        widget.orderUuid!,
                                                                                  );
                                                                                  order.getOnlineOrdersList();
                                                                                } else {
                                                                                  print(
                                                                                    response.statusMessage,
                                                                                  );
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                'OUT_FOR_DELIVERY'.tr,
                                                                                style: GoogleFonts.rubik(
                                                                                  color:
                                                                                      AppColor.fontColor,
                                                                                  fontWeight:
                                                                                      FontWeight.w400,
                                                                                  fontSize:
                                                                                      12.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              onTap: () async {
                                                                                var response = await OrderDetailsRepo.changeOrderStatus(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                  statusCode:
                                                                                      13,
                                                                                );

                                                                                if (response.statusCode ==
                                                                                    200) {
                                                                                  customSnackbar(
                                                                                    "SUCCESS".tr,
                                                                                    'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                    AppColor.success,
                                                                                  );
                                                                                  order.getOrderDetailsByUuid(
                                                                                    uuid:
                                                                                        widget.orderUuid!,
                                                                                  );
                                                                                  order.getOnlineOrdersList();
                                                                                } else {
                                                                                  print(
                                                                                    response.statusMessage,
                                                                                  );
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                'DELIVERED'.tr,
                                                                                style: GoogleFonts.rubik(
                                                                                  color:
                                                                                      AppColor.fontColor,
                                                                                  fontWeight:
                                                                                      FontWeight.w400,
                                                                                  fontSize:
                                                                                      12.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              onTap: () async {
                                                                                var response = await OrderDetailsRepo.changeOrderStatus(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                  statusCode:
                                                                                      22,
                                                                                );

                                                                                if (response.statusCode ==
                                                                                    200) {
                                                                                  customSnackbar(
                                                                                    "SUCCESS".tr,
                                                                                    'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                    AppColor.success,
                                                                                  );
                                                                                  order.getOrderDetailsByUuid(
                                                                                    uuid:
                                                                                        widget.orderUuid!,
                                                                                  );
                                                                                  order.getOnlineOrdersList();
                                                                                } else {
                                                                                  print(
                                                                                    response.statusMessage,
                                                                                  );
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                'RETURNED'.tr,
                                                                                style: GoogleFonts.rubik(
                                                                                  color:
                                                                                      AppColor.fontColor,
                                                                                  fontWeight:
                                                                                      FontWeight.w400,
                                                                                  fontSize:
                                                                                      12.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                      child: Container(
                                                                        height:
                                                                            40.h,
                                                                        width:
                                                                            150.w,
                                                                        decoration: BoxDecoration(
                                                                          color:
                                                                              AppColor.white,
                                                                          borderRadius: BorderRadius.circular(
                                                                            10.r,
                                                                          ),
                                                                          border: Border.all(
                                                                            color:
                                                                                AppColor.primaryColor,
                                                                            width:
                                                                                1.w,
                                                                          ),
                                                                        ),
                                                                        child: Center(
                                                                          child: Padding(
                                                                            padding: EdgeInsets.only(
                                                                              left:
                                                                                  10.w,
                                                                              right:
                                                                                  10.w,
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  order.orderDetailsModel!.data!.status ==
                                                                                          1
                                                                                      ? 'PENDING'.tr
                                                                                      : order.orderDetailsModel!.data!.status ==
                                                                                          4
                                                                                      ? 'ACCEPT'.tr
                                                                                      : order.orderDetailsModel!.data!.status ==
                                                                                          7
                                                                                      ? 'PROCESSING'.tr
                                                                                      : order.orderDetailsModel!.data!.status ==
                                                                                          8
                                                                                      ? 'PREPARED'.tr
                                                                                      : order.orderDetailsModel!.data!.status ==
                                                                                          10
                                                                                      ? 'OUT_FOR_DELIVERY'.tr
                                                                                      : order.orderDetailsModel!.data!.status ==
                                                                                          13
                                                                                      ? 'DELIVERED'.tr
                                                                                      : order.orderDetailsModel!.data!.status ==
                                                                                          16
                                                                                      ? 'CANCELED'.tr
                                                                                      : order.orderDetailsModel!.data!.status ==
                                                                                          19
                                                                                      ? 'REJECTED'.tr
                                                                                      : order.orderDetailsModel!.data!.status ==
                                                                                          22
                                                                                      ? 'RETURNED'.tr
                                                                                      : '',
                                                                                  style: GoogleFonts.rubik(
                                                                                    color:
                                                                                        AppColor.primaryColor,
                                                                                    fontWeight:
                                                                                        FontWeight.w400,
                                                                                    fontSize:
                                                                                        14.sp,
                                                                                  ),
                                                                                ),
                                                                                SvgPicture.asset(
                                                                                  Images.iconArrowDown,
                                                                                  height:
                                                                                      6.h,
                                                                                  width:
                                                                                      6.w,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                    : PopupMenuButton(
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(
                                                                          Radius.circular(
                                                                            10.r,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      position:
                                                                          PopupMenuPosition
                                                                              .under,
                                                                      itemBuilder:
                                                                          (
                                                                            ctx,
                                                                          ) => [
                                                                            PopupMenuItem(
                                                                              onTap: () async {
                                                                                var response = await OrderDetailsRepo.changePaymentStatus(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                  statusCode:
                                                                                      5,
                                                                                );

                                                                                if (response.statusCode ==
                                                                                    200) {
                                                                                  customSnackbar(
                                                                                    "SUCCESS".tr,
                                                                                    'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                    AppColor.success,
                                                                                  );
                                                                                  order.getOrderDetailsByUuid(
                                                                                    uuid:
                                                                                        widget.orderUuid!,
                                                                                  );
                                                                                  order.getOnlineOrdersList();
                                                                                } else {
                                                                                  print(
                                                                                    response.statusMessage,
                                                                                  );
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                "PAID".tr,
                                                                                style: GoogleFonts.rubik(
                                                                                  color:
                                                                                      AppColor.primaryColor,
                                                                                  fontWeight:
                                                                                      FontWeight.w400,
                                                                                  fontSize:
                                                                                      14.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              onTap: () async {
                                                                                var response = await OrderDetailsRepo.changePaymentStatus(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                  statusCode:
                                                                                      10,
                                                                                );

                                                                                if (response.statusCode ==
                                                                                    200) {
                                                                                  customSnackbar(
                                                                                    "SUCCESS".tr,
                                                                                    'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                    AppColor.success,
                                                                                  );
                                                                                  order.getOrderDetailsByUuid(
                                                                                    uuid:
                                                                                        widget.orderUuid!,
                                                                                  );
                                                                                  order.getOnlineOrdersList();
                                                                                } else {
                                                                                  print(
                                                                                    response.statusMessage,
                                                                                  );
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                "UNPAID".tr,
                                                                                style: GoogleFonts.rubik(
                                                                                  color:
                                                                                      AppColor.primaryColor,
                                                                                  fontWeight:
                                                                                      FontWeight.w400,
                                                                                  fontSize:
                                                                                      14.sp,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                      child: Container(
                                                                        height:
                                                                            40.h,
                                                                        width:
                                                                            150.w,
                                                                        decoration: BoxDecoration(
                                                                          color:
                                                                              AppColor.white,
                                                                          borderRadius: BorderRadius.circular(
                                                                            10.r,
                                                                          ),
                                                                          border: Border.all(
                                                                            color:
                                                                                AppColor.primaryColor,
                                                                            width:
                                                                                1.w,
                                                                          ),
                                                                        ),
                                                                        child: Center(
                                                                          child: Padding(
                                                                            padding: EdgeInsets.only(
                                                                              left:
                                                                                  10.w,
                                                                              right:
                                                                                  10.w,
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  order.orderDetailsModel!.data!.paymentStatus ==
                                                                                          5
                                                                                      ? 'PAID'.tr
                                                                                      : order.orderDetailsModel!.data!.paymentStatus ==
                                                                                          10
                                                                                      ? 'UNPAID'.tr
                                                                                      : 'UNPAID'.tr,
                                                                                  style: GoogleFonts.rubik(
                                                                                    color:
                                                                                        AppColor.primaryColor,
                                                                                    fontWeight:
                                                                                        FontWeight.w400,
                                                                                    fontSize:
                                                                                        14.sp,
                                                                                  ),
                                                                                ),
                                                                                SvgPicture.asset(
                                                                                  Images.iconArrowDown,
                                                                                  height:
                                                                                      6.h,
                                                                                  width:
                                                                                      6.w,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                              ],
                                                            )
                                                            : Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                PopupMenuButton(
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                          Radius.circular(
                                                                            10.r,
                                                                          ),
                                                                        ),
                                                                  ),
                                                                  position:
                                                                      PopupMenuPosition
                                                                          .under,
                                                                  itemBuilder:
                                                                      (ctx) => [
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changePaymentStatus(
                                                                              uuid:
                                                                                  widget.orderUuid,
                                                                              statusCode:
                                                                                  5,
                                                                            );

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              order.getOrderDetailsByUuid(
                                                                                uuid:
                                                                                    widget.orderUuid!,
                                                                              );
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            "PAID".tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.primaryColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  14.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changePaymentStatus(
                                                                              uuid:
                                                                                  widget.orderUuid!,
                                                                              statusCode:
                                                                                  10,
                                                                            );

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              order.getOrderDetailsByUuid(
                                                                                uuid:
                                                                                    widget.orderUuid!,
                                                                              );
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            "UNPAID".tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.primaryColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  14.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                  child: Container(
                                                                    height:
                                                                        40.h,
                                                                    width:
                                                                        150.w,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          AppColor
                                                                              .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            10.r,
                                                                          ),
                                                                      border: Border.all(
                                                                        color:
                                                                            AppColor.primaryColor,
                                                                        width:
                                                                            1.w,
                                                                      ),
                                                                    ),
                                                                    child: Center(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(
                                                                          left:
                                                                              10.w,
                                                                          right:
                                                                              10.w,
                                                                        ),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              order.orderDetailsModel!.data!.paymentStatus ==
                                                                                      5
                                                                                  ? 'PAID'.tr
                                                                                  : order.orderDetailsModel!.data!.paymentStatus ==
                                                                                      10
                                                                                  ? 'UNPAID'.tr
                                                                                  : 'UNPAID'.tr,
                                                                              style: GoogleFonts.rubik(
                                                                                color:
                                                                                    AppColor.primaryColor,
                                                                                fontWeight:
                                                                                    FontWeight.w400,
                                                                                fontSize:
                                                                                    14.sp,
                                                                              ),
                                                                            ),
                                                                            SvgPicture.asset(
                                                                              Images.iconArrowDown,
                                                                              height:
                                                                                  6.h,
                                                                              width:
                                                                                  6.w,
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
                                                                          Radius.circular(
                                                                            10.r,
                                                                          ),
                                                                        ),
                                                                  ),
                                                                  position:
                                                                      PopupMenuPosition
                                                                          .under,
                                                                  itemBuilder:
                                                                      (ctx) => [
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeOrderStatus(
                                                                              uuid:
                                                                                  widget.orderUuid!,
                                                                              statusCode:
                                                                                  4,
                                                                            );
                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              order.getOrderDetailsByUuid(
                                                                                uuid:
                                                                                    widget.orderUuid!,
                                                                              );
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            'ACCEPT'.tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.fontColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeOrderStatus(
                                                                              uuid:
                                                                                  widget.orderUuid!,
                                                                              statusCode:
                                                                                  7,
                                                                            );
                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              order.getOrderDetailsByUuid(
                                                                                uuid:
                                                                                    widget.orderUuid!,
                                                                              );
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            'PROCESSING'.tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.fontColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeOrderStatus(
                                                                              uuid:
                                                                                  widget.orderUuid!,
                                                                              statusCode:
                                                                                  8,
                                                                            );
                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              order.getOrderDetailsByUuid(
                                                                                uuid:
                                                                                    widget.orderUuid!,
                                                                              );
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            'PREPARED'.tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.fontColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeOrderStatus(
                                                                              uuid:
                                                                                  widget.orderUuid!,
                                                                              statusCode:
                                                                                  10,
                                                                            );
                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              order.getOrderDetailsByUuid(
                                                                                uuid:
                                                                                    widget.orderUuid!,
                                                                              );
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            'OUT_FOR_DELIVERY'.tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.fontColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeOrderStatus(
                                                                              uuid:
                                                                                  widget.orderUuid!,
                                                                              statusCode:
                                                                                  13,
                                                                            );
                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              order.getOrderDetailsByUuid(
                                                                                uuid:
                                                                                    widget.orderUuid!,
                                                                              );
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            'DELIVERED'.tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.fontColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeOrderStatus(
                                                                              uuid:
                                                                                  widget.orderUuid!,
                                                                              statusCode:
                                                                                  22,
                                                                            );
                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              order.getOrderDetailsByUuid(
                                                                                uuid:
                                                                                    widget.orderUuid!,
                                                                              );
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            'RETURNED'.tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.fontColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                  child: Container(
                                                                    height:
                                                                        40.h,
                                                                    width:
                                                                        150.w,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          AppColor
                                                                              .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            10.r,
                                                                          ),
                                                                      border: Border.all(
                                                                        color:
                                                                            AppColor.primaryColor,
                                                                        width:
                                                                            1.w,
                                                                      ),
                                                                    ),
                                                                    child: Center(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(
                                                                          left:
                                                                              10.w,
                                                                          right:
                                                                              10.w,
                                                                        ),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              order.orderDetailsModel!.data!.status ==
                                                                                      1
                                                                                  ? 'PENDING'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      4
                                                                                  ? 'ACCEPT'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      7
                                                                                  ? 'PROCESSING'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      8
                                                                                  ? 'PREPARED'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      10
                                                                                  ? 'OUT_FOR_DELIVERY'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      13
                                                                                  ? 'DELIVERED'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      16
                                                                                  ? 'CANCELED'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      19
                                                                                  ? 'REJECTED'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      22
                                                                                  ? 'RETURNED'.tr
                                                                                  : '',
                                                                              style: GoogleFonts.rubik(
                                                                                color:
                                                                                    AppColor.primaryColor,
                                                                                fontWeight:
                                                                                    FontWeight.w400,
                                                                                fontSize:
                                                                                    14.sp,
                                                                              ),
                                                                            ),
                                                                            SvgPicture.asset(
                                                                              Images.iconArrowDown,
                                                                              height:
                                                                                  6.h,
                                                                              width:
                                                                                  6.w,
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
                                                            order.orderDetailsModel!.data!.orderType ==
                                                                        5 &&
                                                                    order
                                                                            .orderDetailsModel!
                                                                            .data!
                                                                            .transaction ==
                                                                        null
                                                                ? PopupMenuButton(
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                          Radius.circular(
                                                                            10.r,
                                                                          ),
                                                                        ),
                                                                  ),
                                                                  position:
                                                                      PopupMenuPosition
                                                                          .under,
                                                                  itemBuilder:
                                                                      (ctx) => [
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeOrderStatus(
                                                                              orderId:
                                                                                  widget.orderId!,
                                                                              uuid:
                                                                                  widget.orderUuid,
                                                                              statusCode:
                                                                                  4,
                                                                            );

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              if (widget.orderUuid !=
                                                                                  null) {
                                                                                order.getOrderDetailsByUuid(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                );
                                                                              } else {
                                                                                order.getOrderDetails(
                                                                                  id:
                                                                                      widget.orderId!,
                                                                                );
                                                                              }
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            'ACCEPT'.tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.fontColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeOrderStatus(
                                                                              orderId:
                                                                                  widget.orderId!,
                                                                              uuid:
                                                                                  widget.orderUuid,
                                                                              statusCode:
                                                                                  7,
                                                                            );

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              if (widget.orderUuid !=
                                                                                  null) {
                                                                                order.getOrderDetailsByUuid(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                );
                                                                              } else {
                                                                                order.getOrderDetails(
                                                                                  id:
                                                                                      widget.orderId!,
                                                                                );
                                                                              }
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            'PREPARING'.tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.fontColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeOrderStatus(
                                                                              orderId:
                                                                                  widget.orderId!,
                                                                              uuid:
                                                                                  widget.orderUuid,
                                                                              statusCode:
                                                                                  8,
                                                                            );

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              if (widget.orderUuid !=
                                                                                  null) {
                                                                                order.getOrderDetailsByUuid(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                );
                                                                              } else {
                                                                                order.getOrderDetails(
                                                                                  id:
                                                                                      widget.orderId!,
                                                                                );
                                                                              }
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            'PREPARED'.tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.fontColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeOrderStatus(
                                                                              orderId:
                                                                                  widget.orderId!,
                                                                              uuid:
                                                                                  widget.orderUuid,
                                                                              statusCode:
                                                                                  10,
                                                                            );

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              if (widget.orderUuid !=
                                                                                  null) {
                                                                                order.getOrderDetailsByUuid(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                );
                                                                              } else {
                                                                                order.getOrderDetails(
                                                                                  id:
                                                                                      widget.orderId!,
                                                                                );
                                                                              }
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            'OUT_FOR_DELIVERY'.tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.fontColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeOrderStatus(
                                                                              orderId:
                                                                                  widget.orderId!,
                                                                              uuid:
                                                                                  widget.orderUuid,
                                                                              statusCode:
                                                                                  13,
                                                                            );

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              if (widget.orderUuid !=
                                                                                  null) {
                                                                                order.getOrderDetailsByUuid(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                );
                                                                              } else {
                                                                                order.getOrderDetails(
                                                                                  id:
                                                                                      widget.orderId!,
                                                                                );
                                                                              }
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            'DELIVERED'.tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.fontColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        PopupMenuItem(
                                                                          onTap: () async {
                                                                            var response = await OrderDetailsRepo.changeOrderStatus(
                                                                              orderId:
                                                                                  widget.orderId!,
                                                                              statusCode:
                                                                                  22,
                                                                            );

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              customSnackbar(
                                                                                "SUCCESS".tr,
                                                                                'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                AppColor.success,
                                                                              );
                                                                              if (widget.orderUuid !=
                                                                                  null) {
                                                                                order.getOrderDetailsByUuid(
                                                                                  uuid:
                                                                                      widget.orderUuid!,
                                                                                );
                                                                              } else {
                                                                                order.getOrderDetails(
                                                                                  id:
                                                                                      widget.orderId!,
                                                                                );
                                                                              }
                                                                              order.getOnlineOrdersList();
                                                                            } else {
                                                                              print(
                                                                                response.statusMessage,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Text(
                                                                            'RETURNED'.tr,
                                                                            style: GoogleFonts.rubik(
                                                                              color:
                                                                                  AppColor.fontColor,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              fontSize:
                                                                                  12.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                  child: Container(
                                                                    height:
                                                                        40.h,
                                                                    width:
                                                                        150.w,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          AppColor
                                                                              .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            10.r,
                                                                          ),
                                                                      border: Border.all(
                                                                        color:
                                                                            AppColor.primaryColor,
                                                                        width:
                                                                            1.w,
                                                                      ),
                                                                    ),
                                                                    child: Center(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(
                                                                          left:
                                                                              10.w,
                                                                          right:
                                                                              10.w,
                                                                        ),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              order.orderDetailsModel!.data!.status ==
                                                                                      1
                                                                                  ? 'PENDING'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      4
                                                                                  ? 'ACCEPT'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      7
                                                                                  ? 'PREPARING'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      8
                                                                                  ? 'PREPARED'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      10
                                                                                  ? 'OUT_FOR_DELIVERY'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      13
                                                                                  ? 'DELIVERED'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      16
                                                                                  ? 'CANCELED'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      19
                                                                                  ? 'REJECTED'.tr
                                                                                  : order.orderDetailsModel!.data!.status ==
                                                                                      22
                                                                                  ? 'RETURNED'.tr
                                                                                  : '',
                                                                              style: GoogleFonts.rubik(
                                                                                color:
                                                                                    AppColor.primaryColor,
                                                                                fontWeight:
                                                                                    FontWeight.w400,
                                                                                fontSize:
                                                                                    14.sp,
                                                                              ),
                                                                            ),
                                                                            SvgPicture.asset(
                                                                              Images.iconArrowDown,
                                                                              height:
                                                                                  6.h,
                                                                              width:
                                                                                  6.w,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                : GestureDetector(
                                                                  onTap: () {
                                                                    Get.to(
                                                                      () => OnlinePrintInvoice(
                                                                        orderDetails:
                                                                            order.orderDetailsModel!.data!,
                                                                        comapnyInfo:
                                                                            order.companyInfo!.data!,
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Container(
                                                                    height:
                                                                        40.h,
                                                                    width:
                                                                        150.w,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          AppColor
                                                                              .primaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            10.r,
                                                                          ),
                                                                      border: Border.all(
                                                                        color: Color(
                                                                          0xFFFF006B,
                                                                        ),
                                                                        width:
                                                                            1.w,
                                                                      ),
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(
                                                                        "PRINT_INVOICE"
                                                                            .tr,
                                                                        style: GoogleFonts.rubik(
                                                                          color:
                                                                              AppColor.white,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              14.sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                            order.orderDetailsModel!.data!.orderType ==
                                                                        5 &&
                                                                    order
                                                                            .orderDetailsModel!
                                                                            .data!
                                                                            .transaction ==
                                                                        null
                                                                ? GestureDetector(
                                                                  onTap: () {
                                                                    Get.to(
                                                                      () => OnlinePrintInvoice(
                                                                        orderDetails:
                                                                            order.orderDetailsModel!.data!,
                                                                        comapnyInfo:
                                                                            order.companyInfo!.data!,
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Container(
                                                                    height:
                                                                        40.h,
                                                                    width:
                                                                        150.w,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          AppColor
                                                                              .primaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            10.r,
                                                                          ),
                                                                      border: Border.all(
                                                                        color: Color(
                                                                          0xFFFF006B,
                                                                        ),
                                                                        width:
                                                                            1.w,
                                                                      ),
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(
                                                                        "PRINT_INVOICE"
                                                                            .tr,
                                                                        style: GoogleFonts.rubik(
                                                                          color:
                                                                              AppColor.white,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              14.sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                : SizedBox(),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                    : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Get.dialog(
                                                              AlertDialog(
                                                                content: SizedBox(
                                                                  height: 180.h,
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                          8.0,
                                                                        ),
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'REASON'
                                                                              .tr,
                                                                          style: GoogleFonts.rubik(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize:
                                                                                12.sp,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              4.h,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              reasonController,
                                                                          validator: (
                                                                            value,
                                                                          ) {
                                                                            if (value!.isEmpty) {
                                                                              return "ENTER_REASON".tr;
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                          decoration: InputDecoration(
                                                                            errorBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                8.r,
                                                                              ),
                                                                              borderSide: BorderSide(
                                                                                width:
                                                                                    1.w,
                                                                                color:
                                                                                    AppColor.primaryColor,
                                                                              ),
                                                                            ),
                                                                            focusedErrorBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                8.r,
                                                                              ),
                                                                              borderSide: BorderSide(
                                                                                width:
                                                                                    1.w,
                                                                                color:
                                                                                    AppColor.primaryColor,
                                                                              ),
                                                                            ),
                                                                            fillColor:
                                                                                Colors.red,
                                                                            focusedBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(
                                                                                  8.r,
                                                                                ),
                                                                              ),
                                                                              borderSide: BorderSide(
                                                                                color:
                                                                                    AppColor.primaryColor,
                                                                                width:
                                                                                    1.w,
                                                                              ),
                                                                            ),
                                                                            enabledBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(
                                                                                  8.r,
                                                                                ),
                                                                              ),
                                                                              borderSide: BorderSide(
                                                                                width:
                                                                                    1.w,
                                                                                color:
                                                                                    AppColor.dividerColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              20.h,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Expanded(
                                                                              child: ElevatedButton(
                                                                                onPressed: () {
                                                                                  Get.back();
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  elevation:
                                                                                      1,
                                                                                  backgroundColor:
                                                                                      AppColor.itembg,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      24.r,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                child: Text(
                                                                                  "CLOSE".tr,
                                                                                  style: GoogleFonts.rubik(
                                                                                    color:
                                                                                        AppColor.primaryColor,
                                                                                    fontWeight:
                                                                                        FontWeight.w500,
                                                                                    fontSize:
                                                                                        15.sp,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                                  20.w,
                                                                            ),
                                                                            Expanded(
                                                                              child: ElevatedButton(
                                                                                onPressed: () async {
                                                                                  if (reasonController.text.isNotEmpty) {
                                                                                    var response = await OrderDetailsRepo.rejectOrder(
                                                                                      orderId:
                                                                                          widget.orderId!,
                                                                                      uuid:
                                                                                          widget.orderUuid,
                                                                                      statusCode:
                                                                                          19,
                                                                                      reason:
                                                                                          reasonController.text,
                                                                                    );

                                                                                    if (response.statusCode ==
                                                                                        200) {
                                                                                      customSnackbar(
                                                                                        "SUCCESS".tr,
                                                                                        'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                        AppColor.success,
                                                                                      );
                                                                                      if (widget.orderUuid !=
                                                                                          null) {
                                                                                        order.getOrderDetailsByUuid(
                                                                                          uuid:
                                                                                              widget.orderUuid!,
                                                                                        );
                                                                                      } else {
                                                                                        order.getOrderDetails(
                                                                                          id:
                                                                                              widget.orderId!,
                                                                                        );
                                                                                      }
                                                                                      order.getOnlineOrdersList();
                                                                                    } else {
                                                                                      print(
                                                                                        response.statusMessage,
                                                                                      );
                                                                                    }
                                                                                    Get.back();
                                                                                  } else {
                                                                                    customSnackbar(
                                                                                      "ERROR".tr,
                                                                                      "ENTER_REASON".tr,
                                                                                      AppColor.error,
                                                                                    );
                                                                                  }
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  elevation:
                                                                                      1,
                                                                                  backgroundColor:
                                                                                      AppColor.primaryColor,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      24.r,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                child: Text(
                                                                                  "SAVE".tr,
                                                                                  style: GoogleFonts.rubik(
                                                                                    color:
                                                                                        AppColor.white,
                                                                                    fontWeight:
                                                                                        FontWeight.w500,
                                                                                    fontSize:
                                                                                        15.sp,
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
                                                              barrierDismissible:
                                                                  false,
                                                            );
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            minimumSize: Size(
                                                              150.w,
                                                              45.h,
                                                            ),
                                                            backgroundColor:
                                                                AppColor
                                                                    .redColor,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    24.r,
                                                                  ),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .highlight_remove_rounded,
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Text(
                                                                "REJECT".tr,
                                                                style: GoogleFonts.rubik(
                                                                  color:
                                                                      AppColor
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      16.sp,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Get.dialog(
                                                              AlertDialog(
                                                                content: SizedBox(
                                                                  height: 160.h,
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                          8.0,
                                                                        ),
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "ARE_YOU_SURE_TO_ACCEPT_THIS_ORDER"
                                                                              .tr,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: GoogleFonts.rubik(
                                                                            color:
                                                                                AppColor.fontColor,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                16.sp,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              20.h,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Expanded(
                                                                              child: ElevatedButton(
                                                                                onPressed: () {
                                                                                  Get.back();
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  elevation:
                                                                                      1,
                                                                                  backgroundColor:
                                                                                      AppColor.itembg,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      24.r,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                child: Text(
                                                                                  "CLOSE".tr,
                                                                                  style: GoogleFonts.rubik(
                                                                                    color:
                                                                                        AppColor.primaryColor,
                                                                                    fontWeight:
                                                                                        FontWeight.w500,
                                                                                    fontSize:
                                                                                        15.sp,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                                  20.w,
                                                                            ),
                                                                            Expanded(
                                                                              child: ElevatedButton(
                                                                                onPressed: () async {
                                                                                  var response = await OrderDetailsRepo.changeOrderStatus(
                                                                                    orderId:
                                                                                        widget.orderId!,
                                                                                    uuid:
                                                                                        widget.orderUuid,
                                                                                    statusCode:
                                                                                        4,
                                                                                  );

                                                                                  if (response.statusCode ==
                                                                                      200) {
                                                                                    Get.back();
                                                                                    customSnackbar(
                                                                                      "SUCCESS".tr,
                                                                                      'STATUS_UPDATED_SUCCESSFULLY'.tr,
                                                                                      AppColor.success,
                                                                                    );
                                                                                    if (widget.orderUuid !=
                                                                                        null) {
                                                                                      order.getOrderDetailsByUuid(
                                                                                        uuid:
                                                                                            widget.orderUuid!,
                                                                                      );
                                                                                    } else {
                                                                                      order.getOrderDetails(
                                                                                        id:
                                                                                            widget.orderId!,
                                                                                      );
                                                                                    }
                                                                                    order.getOnlineOrdersList();
                                                                                  } else {
                                                                                    print(
                                                                                      response.statusMessage,
                                                                                    );
                                                                                  }
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  elevation:
                                                                                      1,
                                                                                  backgroundColor:
                                                                                      AppColor.primaryColor,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      24.r,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                child: Text(
                                                                                  "ACCEPT".tr,
                                                                                  style: GoogleFonts.rubik(
                                                                                    color:
                                                                                        AppColor.white,
                                                                                    fontWeight:
                                                                                        FontWeight.w500,
                                                                                    fontSize:
                                                                                        15.sp,
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
                                                              barrierDismissible:
                                                                  false,
                                                            );
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            minimumSize: Size(
                                                              150.w,
                                                              45.h,
                                                            ),
                                                            backgroundColor:
                                                                AppColor.green,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    24.r,
                                                                  ),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .check_circle,
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Text(
                                                                "ACCEPT".tr,
                                                                style: GoogleFonts.rubik(
                                                                  color:
                                                                      AppColor
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      16.sp,
                                                                ),
                                                              ),
                                                            ],
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
  final orderController = Get.find<OnlineOrderController>();
  return Column(
    children: [
      orderController.orderDetailsModel!.data!.orderItems![i].instruction !=
                  null &&
              orderController
                  .orderDetailsModel!
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
                      .orderDetailsModel!
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
  final orderController = Get.find<OnlineOrderController>();
  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: Column(
      children: [
        orderController.orderDetailsModel!.data!.orderItems![i].itemExtras !=
                    null &&
                orderController
                    .orderDetailsModel!
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
                              .orderDetailsModel!
                              .data!
                              .orderItems![i]
                              .itemExtras!
                              .length,
                      itemBuilder: (BuildContext context, index) {
                        return Text(
                          index ==
                                  orderController
                                          .orderDetailsModel!
                                          .data!
                                          .orderItems![i]
                                          .itemExtras!
                                          .length -
                                      1
                              ? "${orderController.orderDetailsModel!.data!.orderItems![i].itemExtras![index].name}."
                              : "${orderController.orderDetailsModel!.data!.orderItems![i].itemExtras![index].name},",
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

Widget customerInformationSection() {
  return GetBuilder<OnlineOrderController>(
    builder:
        (onlineOrderController) => Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.itembg,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 5.0.r,
                  spreadRadius: 1.0.r,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50.r,
                              height: 50.r,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.r),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      onlineOrderController
                                          .orderDetailsModel
                                          ?.data
                                          ?.user
                                          ?.image ??
                                      '',
                                  imageBuilder:
                                      (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                  placeholder:
                                      (context, url) => Shimmer.fromColors(
                                        child: Container(
                                          height: 86.h,
                                          width: 154.w,
                                          color: Colors.grey,
                                        ),
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[400]!,
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          const Icon(Icons.error),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("CUSTOMER".tr, style: fontRegular),
                                Text(
                                  onlineOrderController
                                          .orderDetailsModel
                                          ?.data
                                          ?.user
                                          ?.name
                                          .toString() ??
                                      "",
                                  style: fontMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final call = Uri.parse(
                            'tel:${Get.find<SplashController>().countryInfoData.callingCode! + onlineOrderController.orderDetailsModel!.data!.user!.phone.toString()}',
                          );
                          if (await canLaunchUrl(call)) {
                            launchUrl(call);
                          } else {
                            throw 'Could not launch $call';
                          }
                        },
                        child: Container(
                          width: 45.r,
                          height: 45.r,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.r),
                            ),
                            color: AppColor.viewAllbg,
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            Images.call,
                            height: 25.h,
                            width: 25.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  onlineOrderController.orderDetailsModel?.data?.orderAddress ==
                          null
                      ? SizedBox()
                      : addressSection(),
                ],
              ),
            ),
          ),
        ),
  );
}

Widget addressSection() {
  return GetBuilder<OnlineOrderController>(
    builder:
        (onlineOrderController) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DELIVERY_ADDRESS'.tr, style: fontMedium),
            SizedBox(height: 6.h),
            Row(
              children: [
                SvgPicture.asset(
                  Images.locationIcon,
                  height: 15.h,
                  width: 15.w,
                  color: AppColor.primaryColor,
                ),
                SizedBox(width: 10.w),
                Flexible(
                  child: Text(
                    onlineOrderController
                            .orderDetailsModel!
                            .data!
                            .orderAddress!['apartment']
                            .toString() +
                        "," +
                        " " +
                        onlineOrderController
                            .orderDetailsModel!
                            .data!
                            .orderAddress!['address']
                            .toString(),
                    style: fontRegular,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ],
        ),
  );
}
