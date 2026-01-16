import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking_admin/app/modules/order/controller/online_order_controller.dart';
import 'package:foodking_admin/app/modules/order/controller/pos_order_controller.dart';
import 'package:foodking_admin/app/modules/sales/controller/sales_controller.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.index});
  final index;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController orderIDController = TextEditingController();
  SalesController sales = Get.put(SalesController());
  OnlineOrderController order = Get.put(OnlineOrderController());
  POSOrderController posOrder = Get.put(POSOrderController());
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    sales.getCustomersList();
  }

  String date = '';
  String datePick = '';
  String status = '';
  String statusPick = '';
  String customer = '';
  String customerPick = '';

  DateTime? pickedDate;

  datePicker() async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
      date = DateFormat('dd/MM/yyyy').format(pickedDate!);

      setState(() {
        datePick = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  bool onTap = false;
  bool onTap1 = false;
  bool onTap2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: box.read('languageCode') == 'ar' ? 550.h : 526.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FILTER'.tr,
              style: GoogleFonts.rubik(
                color: AppColor.fontColor,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'ORDER_ID'.tr,
              style: GoogleFonts.rubik(
                color: AppColor.fontColor,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),
            TextFormField(
              controller: orderIDController,
              onTap: () {
                setState(() {
                  onTap = false;
                  onTap1 = false;
                  onTap2 = false;
                });
              },
              decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: AppColor.primaryColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: AppColor.primaryColor,
                  ),
                ),
                fillColor: Colors.red,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  borderSide: BorderSide(
                    color: AppColor.primaryColor,
                    width: 1.w,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: AppColor.dividerColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'STATUS'.tr,
              style: GoogleFonts.rubik(
                color: AppColor.fontColor,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),
            PopupMenuButton(
              onOpened: () {
                setState(() {
                  onTap = true;
                  onTap1 = false;
                  onTap2 = false;
                });
              },
              position: PopupMenuPosition.under,
              itemBuilder:
                  (ctx) => [
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          status = 'PENDING'.tr;
                          statusPick = '1';
                        });
                      },
                      child: Text(
                        'PENDING'.tr,
                        style: GoogleFonts.rubik(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          status = 'ACCEPT'.tr;
                          statusPick = '4';
                        });
                      },
                      child: Text(
                        'ACCEPT'.tr,
                        style: GoogleFonts.rubik(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          status = 'PROCESSING'.tr;
                          statusPick = '7';
                        });
                      },
                      child: Text(
                        'PROCESSING'.tr,
                        style: GoogleFonts.rubik(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          status = 'OUT_FOR_DELIVERY'.tr;
                          statusPick = '10';
                        });
                      },
                      child: Text(
                        'OUT_FOR_DELIVERY'.tr,
                        style: GoogleFonts.rubik(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          status = 'DELIVERED'.tr;
                          statusPick = '13';
                        });
                      },
                      child: Text(
                        'DELIVERED'.tr,
                        style: GoogleFonts.rubik(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          status = 'CANCELED'.tr;
                          statusPick = '16';
                        });
                      },
                      child: Text(
                        'CANCELED'.tr,
                        style: GoogleFonts.rubik(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          status = 'REJECTED'.tr;
                          statusPick = '19';
                        });
                      },
                      child: Text(
                        'REJECTED'.tr,
                        style: GoogleFonts.rubik(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          status = 'RETURNED'.tr;
                          statusPick = '22';
                        });
                      },
                      child: Text(
                        'RETURNED'.tr,
                        style: GoogleFonts.rubik(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
              child: Container(
                height: 58.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color:
                        onTap == true
                            ? AppColor.primaryColor
                            : AppColor.dividerColor,
                    width: 1.w,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        status,
                        style: GoogleFonts.rubik(
                          color: AppColor.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                      SvgPicture.asset(
                        Images.arrowDown,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'CUSTOMER'.tr,
              style: GoogleFonts.rubik(
                color: AppColor.fontColor,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),
            PopupMenuButton(
              onOpened: () {
                setState(() {
                  onTap = false;
                  onTap1 = true;
                  onTap2 = false;
                });
              },
              position: PopupMenuPosition.under,
              itemBuilder:
                  (ctx) => List.generate(
                    sales.customersModel!.data!.length,
                    (index) => PopupMenuItem(
                      onTap: () {
                        setState(() {
                          customer =
                              sales.customersModel!.data![index].name
                                  .toString();
                          customerPick =
                              sales.customersModel!.data![index].id.toString();
                        });
                      },
                      child: Text(
                        sales.customersModel!.data![index].name.toString(),
                        style: GoogleFonts.rubik(
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
              child: Container(
                height: 58.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color:
                        onTap1 == true
                            ? AppColor.primaryColor
                            : AppColor.dividerColor,
                    width: 1.w,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        customer,
                        style: GoogleFonts.rubik(
                          color: AppColor.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                      SvgPicture.asset(
                        Images.arrowDown,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'DATE'.tr,
              style: GoogleFonts.rubik(
                color: AppColor.fontColor,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: () {
                datePicker();
                setState(() {
                  onTap = false;
                  onTap1 = false;
                  onTap2 = true;
                });
              },
              child: Container(
                height: 58.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color:
                        onTap2 == true
                            ? AppColor.primaryColor
                            : AppColor.dividerColor,
                    width: 1.w,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date,
                        style: GoogleFonts.rubik(
                          color: AppColor.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                      SvgPicture.asset(
                        Images.filterCalendar,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      orderIDController.clear();
                      status = '';
                      customer = '';
                      date = '';
                    });
                  },
                  child: Container(
                    height: 48.h,
                    width: 156.w,
                    decoration: BoxDecoration(
                      color: AppColor.error,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Images.close,
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'CLEAR'.tr,
                          style: GoogleFonts.rubik(
                            color: AppColor.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.index == 1) {
                      order.getOnlineOrdersListByFilter(
                        order_serial_no: orderIDController.text,
                        status: statusPick,
                        user_id: customerPick,
                        order_datetime: datePick,
                      );
                    }
                    if (widget.index == 2) {
                      posOrder.getPOSOrdersListByFilter(
                        order_serial_no: orderIDController.text,
                        status: statusPick,
                        user_id: customerPick,
                        order_datetime: datePick,
                      );
                    }
                    if (widget.index == 3) {
                      sales.getSalesReportListByFilter(
                        order_serial_no: orderIDController.text,
                        status: statusPick,
                        user_id: customerPick,
                        order_datetime: datePick,
                      );
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48.h,
                    width: 156.w,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Images.searchButton,
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'SEARCH'.tr,
                          style: GoogleFonts.rubik(
                            color: AppColor.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
