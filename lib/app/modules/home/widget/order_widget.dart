import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderWidget extends StatelessWidget {
  OrderWidget(
      {super.key, this.icon, this.count, this.text, this.backgroundColor});
  final String? icon, text, count;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126.h,
      width: 156.w,
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
            Container(
              height: 32.r,
              width: 32.r,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Center(
                child: SvgPicture.asset('$icon'),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            FittedBox(
              child: Text(
                '$text',
                style: GoogleFonts.rubik(
                    color: AppColor.gray,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              '$count',
              style: GoogleFonts.rubik(
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 22.sp),
            )
          ],
        ),
      ),
    );
  }
}
