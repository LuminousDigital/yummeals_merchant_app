import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking_admin/app/modules/home/controllers/home_controller.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:foodking_admin/widget/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key, required this.index});
  final index;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  String showFromDate = '';
  String showToDate = '';

  DateTime? pickedDate;
  DateTime? pickedDate1;

  formDatePicker() async {
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
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
      showFromDate = DateFormat('dd/MM/yyyy').format(pickedDate!);
      print(formattedDate);

      setState(() {
        fromController.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  toDatePicker() async {
    pickedDate1 = await showDatePicker(
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

    if (pickedDate1 != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate1!);
      showToDate = DateFormat('dd/MM/yyyy').format(pickedDate1!);

      setState(() {
        toController.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 320.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.white, borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'SELECT_DATE'.tr,
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w400, fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'FROM'.tr,
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w400, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 4.h,
                ),
                GestureDetector(
                  onTap: () {
                    formDatePicker();
                  },
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: AppColor.dividerColor, width: 1.w)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            showFromDate.toString(),
                            style: GoogleFonts.rubik(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
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
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'TO'.tr,
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w400, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 4.h,
                ),
                GestureDetector(
                  onTap: () {
                    toDatePicker();
                  },
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: AppColor.dividerColor, width: 1.w)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            showToDate.toString(),
                            style: GoogleFonts.rubik(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
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
                SizedBox(
                  height: 24.h,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (fromController.text.isNotEmpty &&
                        toController.text.isNotEmpty) {
                      if (widget.index == 1) {
                        homeController.getStatisticsListByDate(
                            first_date: fromController.text,
                            last_date: toController.text);
                      }
                      if (widget.index == 2) {
                        homeController.getSalesSummaryListByDate(
                            first_date: fromController.text,
                            last_date: toController.text);
                      }
                      if (widget.index == 3) {
                        homeController.getOrdersSummaryListByDate(
                            first_date: fromController.text,
                            last_date: toController.text);
                      }
                      Navigator.pop(context);
                    } else {
                      customSnackbar(
                          "ERROR".tr, "PLEASE_SELECT_DATE".tr, AppColor.error);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColor.primaryColor,
                    minimumSize: Size(292.w, 52.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                  ),
                  child: Text(
                    'SUBMIT'.tr,
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10.w,
          top: 10.h,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset(
              Images.close,
              color: AppColor.redColor,
            ),
          ),
        )
      ],
    );
  }
}
