import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodking_admin/app/data/model/response/top_customers_model.dart';
import 'package:foodking_admin/util/constant.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CustomerWidget extends StatefulWidget {
  const CustomerWidget({super.key, required this.customer});
  final Data customer;

  @override
  State<CustomerWidget> createState() => _CustomerWidgetState();
}

class _CustomerWidgetState extends State<CustomerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.h,
      width: 144.w,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColor.border,
          )),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 48.r,
                    width: 48.r,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(48.r),
 ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(48.r),
                              child: CachedNetworkImage(
                                                      imageUrl: widget.customer.image!,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.cover,
                                                            // colorFilter: ColorFilter.mode(
                                                            //     Colors.red, BlendMode.colorBurn),
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder:
                                                          (context, url) =>
                                                              Shimmer.fromColors(
                                                        child: Container(
                                                            height: 86.h,
                                                            width: 154.w,
                                                            color: Colors.grey),
                                                        baseColor:
                                                            Colors.grey[300]!,
                                                        highlightColor:
                                                            Colors.grey[400]!,
                                                      ),
                                                      errorWidget: (context, url,
                                                              error) =>
                                                          const Icon(Icons.error),
                                                    ),
                            ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    widget.customer.name.toString(),
                    style: GoogleFonts.rubik(
                        color: AppColor.fontColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.activeTxtColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.r),
                  topRight: Radius.circular(4.r),
                  bottomLeft: Radius.circular(11.r),
                  bottomRight: Radius.circular(11.r),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.customer.order.toString()} ',
                      style: GoogleFonts.rubik(
                          color: AppColor.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp),
                    ),
                    Text(
                      'ORDERS'.tr,
                      style: GoogleFonts.rubik(
                          color: AppColor.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
