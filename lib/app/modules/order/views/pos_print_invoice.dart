import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/response/company_info_model.dart' as info;
import '../../../data/model/response/pos_order_details_model.dart' as order;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class POSPrintInvoice extends StatefulWidget {
  final info.Data? comapnyInfo;
  final order.Data? orderDetails;
  const POSPrintInvoice({
    super.key,
    required this.comapnyInfo,
    required this.orderDetails,
  });

  @override
  State<POSPrintInvoice> createState() => _POSPrintInvoiceState();
}

class _POSPrintInvoiceState extends State<POSPrintInvoice> {
  final GlobalKey<State<StatefulWidget>> keys = GlobalKey();
  final box = GetStorage();

  void _printScreen() {
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
        final doc = pw.Document();

        final image = await WidgetWrapper.fromKey(key: keys, pixelRatio: 2.0);

        doc.addPage(
          pw.Page(
            pageFormat: format,
            build: (pw.Context context) {
              return pw.Center(child: pw.Expanded(child: pw.Image(image)));
            },
          ),
        );

        return doc.save();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: RepaintBoundary(
                key: keys,
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          widget.comapnyInfo!.companyName.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ptSans(
                            color: AppColor.fontColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Center(
                        child: Text(
                          widget.comapnyInfo!.companyAddress.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ptSans(
                            color: AppColor.fontColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Center(
                        child: Text(
                          "Tel: ${widget.orderDetails!.branch?.phone}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ptSans(
                            color: AppColor.fontColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ptSans(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Order #${widget.orderDetails!.orderSerialNo.toString()}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.ptSans(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.orderDetails!.orderDate.toString()}",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.ptSans(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            "${widget.orderDetails!.orderTime.toString()}",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.ptSans(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ptSans(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Qty",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.ptSans(
                                color: AppColor.fontColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Text(
                              "Item Description",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.ptSans(
                                color: AppColor.fontColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Price",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.ptSans(
                                color: AppColor.fontColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ptSans(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: widget.orderDetails!.orderItems!.length,
                        itemBuilder: (BuildContext context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  widget
                                      .orderDetails!
                                      .orderItems![index]
                                      .quantity
                                      .toString(),
                                  style: const TextStyle(
                                    color: AppColor.fontColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 11,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget
                                              .orderDetails!
                                              .orderItems![index]
                                              .itemName
                                              .toString(),
                                          style: GoogleFonts.ptSans(
                                            color: AppColor.fontColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 2.h),
                                        widget
                                                    .orderDetails!
                                                    .orderItems![index]
                                                    .itemVariations !=
                                                null
                                            ? SizedBox(
                                              width: 240.w,
                                              height: 20.h,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount:
                                                    widget
                                                        .orderDetails!
                                                        .orderItems![index]
                                                        .itemVariations!
                                                        .length,
                                                itemBuilder: (
                                                  BuildContext context,
                                                  i,
                                                ) {
                                                  return Text(
                                                    index ==
                                                            widget
                                                                    .orderDetails!
                                                                    .orderItems![index]
                                                                    .itemVariations!
                                                                    .length -
                                                                1
                                                        ? "${widget.orderDetails!.orderItems![index].itemVariations![i].variationName} : ${widget.orderDetails!.orderItems![index].itemVariations![i].name}."
                                                        : "${widget.orderDetails!.orderItems![index].itemVariations![i].variationName} : ${widget.orderDetails!.orderItems![index].itemVariations![i].name}, ",
                                                    style: GoogleFonts.ptSans(
                                                      color: AppColor.fontColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11.sp,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  );
                                                },
                                              ),
                                            )
                                            : const SizedBox.shrink(),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: orderDetailsVariationSection(
                                            index,
                                            widget.orderDetails,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: orderItemInstructionSection(
                                            index,
                                            widget.orderDetails,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      widget
                                          .orderDetails!
                                          .orderItems![index]
                                          .price
                                          .toString(),
                                      style: GoogleFonts.roboto(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ptSans(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex: 1, child: SizedBox()),
                              Expanded(
                                flex: 11,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'SUBTOTAL'.tr,
                                      style: GoogleFonts.ptSans(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      widget
                                          .orderDetails!
                                          .subtotalWithoutTaxCurrencyPrice
                                          .toString(),
                                      style: GoogleFonts.roboto(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex: 1, child: SizedBox()),
                              Expanded(
                                flex: 11,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'TOTAL_TAX'.tr,
                                      style: GoogleFonts.ptSans(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      widget.orderDetails!.totalTaxCurrencyPrice
                                          .toString(),
                                      style: GoogleFonts.roboto(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex: 1, child: SizedBox()),
                              Expanded(
                                flex: 11,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'DISCOUNT'.tr,
                                      style: GoogleFonts.ptSans(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      widget.orderDetails!.discountCurrencyPrice
                                          .toString(),
                                      style: GoogleFonts.roboto(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          widget.orderDetails!.orderType == 10
                              ? SizedBox()
                              : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(flex: 1, child: SizedBox()),
                                  Expanded(
                                    flex: 11,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'DELIVERY_CHARGE'.tr,
                                          style: GoogleFonts.ptSans(
                                            color: AppColor.fontColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          widget
                                              .orderDetails!
                                              .deliveryChargeCurrencyPrice
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                            color: AppColor.fontColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          SizedBox(height: 4.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex: 1, child: SizedBox()),
                              Expanded(
                                flex: 11,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'TOTAL'.tr,
                                      style: GoogleFonts.ptSans(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      widget.orderDetails!.totalCurrencyPrice
                                          .toString(),
                                      style: GoogleFonts.roboto(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: FittedBox(
                              child: Text(
                                "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ptSans(
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: box.read('languageCode') == 'fr' ? 5 : 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'ORDER_TYPE'.tr,
                                          style: GoogleFonts.ptSans(
                                            color: AppColor.fontColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                        Text(
                                          ':',
                                          style: GoogleFonts.ptSans(
                                            color: AppColor.fontColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      children: [
                                        Text(
                                          'PAYMENT_TYPE'.tr,
                                          style: GoogleFonts.ptSans(
                                            color: AppColor.fontColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                        Text(
                                          ':',
                                          style: GoogleFonts.ptSans(
                                            color: AppColor.fontColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    widget
                                                    .orderDetails
                                                    ?.posReceivedCurrencyAmount ==
                                                null ||
                                            widget
                                                    .orderDetails!
                                                    .posReceivedCurrencyAmount ==
                                                "\$0.00" ||
                                            widget
                                                    .orderDetails!
                                                    .posReceivedCurrencyAmount ==
                                                "0.00\$" ||
                                            widget
                                                    .orderDetails!
                                                    .cashBackCurrencyAmount ==
                                                "\$0.00" ||
                                            widget
                                                    .orderDetails!
                                                    .cashBackCurrencyAmount ==
                                                "0.00\$"
                                        ? SizedBox()
                                        : SizedBox(height: 36.h),
                                  ],
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.orderDetails!.orderType == 5
                                          ? 'DELIVERY'.tr
                                          : widget.orderDetails!.orderType == 10
                                          ? 'TAKEAWAY'.tr
                                          : widget.orderDetails!.orderType == 15
                                          ? 'POS'.tr
                                          : widget.orderDetails!.orderType == 20
                                          ? 'DINE_IN'.tr
                                          : '',
                                      style: GoogleFonts.ptSans(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      widget.orderDetails!.posPaymentMethod == 1
                                          ? "CASH".tr
                                          : widget
                                                  .orderDetails!
                                                  .posPaymentMethod ==
                                              2
                                          ? "CARD".tr +
                                              " (${widget.orderDetails!.posPaymentNote})"
                                          : widget
                                                  .orderDetails!
                                                  .posPaymentMethod ==
                                              3
                                          ? "MOBILE_BANKING".tr +
                                              " (${widget.orderDetails!.posPaymentNote})"
                                          : widget
                                                  .orderDetails!
                                                  .posPaymentMethod ==
                                              4
                                          ? "OTHER".tr +
                                              " (${widget.orderDetails!.posPaymentNote})"
                                          : "CASH".tr,
                                      style: GoogleFonts.ptSans(
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),

                                    widget
                                                    .orderDetails
                                                    ?.posReceivedCurrencyAmount ==
                                                null ||
                                            widget
                                                    .orderDetails!
                                                    .posReceivedCurrencyAmount ==
                                                "\$0.00" ||
                                            widget
                                                    .orderDetails!
                                                    .posReceivedCurrencyAmount ==
                                                "0.00\$" ||
                                            widget
                                                    .orderDetails!
                                                    .cashBackCurrencyAmount ==
                                                "\$0.00" ||
                                            widget
                                                    .orderDetails!
                                                    .cashBackCurrencyAmount ==
                                                "0.00\$"
                                        ? SizedBox()
                                        : Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'CASH:'.tr,
                                                  style: GoogleFonts.ptSans(
                                                    color: AppColor.fontColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11.sp,
                                                  ),
                                                ),
                                                SizedBox(width: 6.w),
                                                Text(
                                                  widget
                                                          .orderDetails
                                                          ?.posReceivedCurrencyAmount
                                                          .toString() ??
                                                      "",
                                                  style: GoogleFonts.ptSans(
                                                    color: AppColor.fontColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'CHANGE:'.tr,
                                                  style: GoogleFonts.ptSans(
                                                    color: AppColor.fontColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11.sp,
                                                  ),
                                                ),
                                                SizedBox(width: 6.w),
                                                Text(
                                                  widget
                                                          .orderDetails
                                                          ?.cashBackCurrencyAmount
                                                          .toString() ??
                                                      "",
                                                  style: GoogleFonts.ptSans(
                                                    color: AppColor.fontColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: FittedBox(
                              child: Text(
                                "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ptSans(
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "TOKEN".tr,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ptSans(
                                          color: AppColor.fontColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        '#${widget.orderDetails?.token.toString() ?? ""}',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ptSans(
                                          color: AppColor.fontColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: FittedBox(
                              child: Text(
                                "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ptSans(
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Text(
                                    "THANK_YOU".tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ptSans(
                                      color: AppColor.fontColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "PLEASE_COME_AGAIN".tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ptSans(
                                      color: AppColor.fontColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Powered by",
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.ptSans(
                                      color: AppColor.fontColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                  Text(
                                    "Yummeals",
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.ptSans(
                                      color: AppColor.fontColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: GestureDetector(
                    onTap: () {
                      _printScreen();
                    },
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Text(
                          "Print Invoice",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.ptSans(
                            color: AppColor.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget orderItemInstructionSection(int i, order.Data? order) {
  return Column(
    children: [
      order!.orderItems![i].instruction != null &&
              order.orderItems![i].instruction!.isNotEmpty
          ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "INSTRUCTION".tr + ' : ',
                style: GoogleFonts.ptSans(
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(
                width: Get.width - 160.w,
                child: Text(
                  order.orderItems![i].instruction.toString(),
                  style: GoogleFonts.ptSans(
                    color: AppColor.fontColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          )
          : const SizedBox.shrink(),
    ],
  );
}

Widget orderDetailsVariationSection(int i, order.Data? order) {
  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: Column(
      children: [
        order!.orderItems![i].itemExtras != null &&
                order.orderItems![i].itemExtras!.isNotEmpty
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
                    width: 200.w,
                    height: 15.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: order.orderItems![i].itemExtras!.length,
                      itemBuilder: (BuildContext context, index) {
                        return Text(
                          index == order.orderItems![i].itemExtras!.length - 1
                              ? "${order.orderItems![i].itemExtras![index].name}."
                              : "${order.orderItems![i].itemExtras![index].name},",
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
