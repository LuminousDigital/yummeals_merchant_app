// ignore_for_file: sort_child_properties_last, deprecated_member_use, prefer_interpolation_to_compose_strings
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking_admin/app/modules/auth/views/login_view.dart';
import 'package:foodking_admin/app/modules/profile/controllers/profile_controller.dart';
import 'package:foodking_admin/app/modules/profile/widget/change_language_view.dart';
import 'package:foodking_admin/app/modules/profile/widget/change_password_view.dart';
import 'package:foodking_admin/app/modules/profile/widget/edit_profile_view.dart';
import 'package:foodking_admin/app/modules/splash/controllers/splash_controller.dart';
import 'package:foodking_admin/widget/loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import 'pages_screen.dart';

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final box = GetStorage();

  bool? isLogedIn;

  @override
  void initState() {
    Get.put(SplashController());
    ProfileController profileController = Get.put(ProfileController());
    super.initState();
    bool isLogedIn = box.read('isLogedIn');
    if (isLogedIn) {
      profileController.getProfileData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder:
          (profileController) => Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text(
                    "MY_PROFILE".tr,
                    style: GoogleFonts.rubik(
                      color: AppColor.fontColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                ),
                body: RefreshIndicator(
                  color: AppColor.primaryColor,
                  onRefresh: () async {
                    if (box.read('isLogedIn') != null &&
                        box.read('isLogedIn') != false) {
                      profileController.getProfileData();
                    }
                  },
                  child: SafeArea(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: SizedBox(
                        child: Column(
                          children: [
                            SizedBox(
                              child:
                                  profileController.profileData.image == null
                                      ? const SizedBox()
                                      : Column(
                                        children: [
                                          SizedBox(
                                            height: 140.h,
                                            child: Stack(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              children: [
                                                SizedBox(
                                                  width: 100.r,
                                                  height: 100.r,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(50.r),
                                                        ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                        4.r,
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(
                                                                50.r,
                                                              ),
                                                            ),
                                                        child: CachedNetworkImage(
                                                          imageUrl:
                                                              profileController
                                                                  .profileData
                                                                  .image!,
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
                                                                        BoxFit
                                                                            .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                          placeholder:
                                                              (
                                                                context,
                                                                url,
                                                              ) => Shimmer.fromColors(
                                                                child: Container(
                                                                  height: 86.h,
                                                                  width: 154.w,
                                                                  color:
                                                                      Colors
                                                                          .grey,
                                                                ),
                                                                baseColor:
                                                                    Colors
                                                                        .grey[300]!,
                                                                highlightColor:
                                                                    Colors
                                                                        .grey[400]!,
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
                                                ),
                                                SizedBox(
                                                  width: 105.w,
                                                  height: 105.h,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Image.asset(
                                                      Images.dotCircle,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  width: 100.w,
                                                  bottom: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      profileController
                                                          .getImageFromGallary();
                                                    },
                                                    child: SizedBox(
                                                      width: 44.w,
                                                      height: 44.h,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: SizedBox(
                                                          width: 40.w,
                                                          height: 40.h,
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                AppColor
                                                                    .darkGray,
                                                            child:
                                                                SvgPicture.asset(
                                                                  Images
                                                                      .iconEdit,
                                                                  fit:
                                                                      BoxFit
                                                                          .cover,
                                                                  width: 22.w,
                                                                  height: 22.h,
                                                                  color:
                                                                      Colors
                                                                          .white,
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
                                          SizedBox(height: 16.h),
                                          Text(
                                            profileController.profileData.name
                                                .toString(),
                                            style: GoogleFonts.rubik(
                                              color: AppColor.fontColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          if (profileController
                                                  .profileData
                                                  .email !=
                                              null)
                                            Text(
                                              profileController
                                                  .profileData
                                                  .email
                                                  .toString(),
                                              style: GoogleFonts.rubik(
                                                color: AppColor.gray,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          SizedBox(height: 2.h),
                                          Text(
                                            profileController
                                                    .profileData
                                                    .countryCode! +
                                                profileController
                                                    .profileData
                                                    .phone
                                                    .toString(),
                                            style: GoogleFonts.rubik(
                                              color: AppColor.gray,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            Get.find<SplashController>()
                                                    .configData
                                                    .siteDefaultCurrencySymbol
                                                    .toString() +
                                                profileController
                                                    .profileData
                                                    .balance
                                                    .toString(),
                                            style: GoogleFonts.roboto(
                                              color: AppColor.fontColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                            ),
                            SizedBox(height: 32.h),
                            Padding(
                              padding: EdgeInsets.only(left: 18.w, right: 18.w),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => EditProfileView());
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          Images.edit,
                                          height: 16.h,
                                          width: 16.w,
                                        ),
                                        SizedBox(width: 16.w),
                                        Text(
                                          "EDIT_PROFILE".tr,
                                          style: GoogleFonts.rubik(
                                            color: AppColor.fontColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Divider(
                                    thickness: 1,
                                    endIndent: 10,
                                    color: AppColor.dividerColor,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 18.w,
                                top: 12.h,
                                right: 18.w,
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => ChangePasswordView());
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          Images.change_pass,
                                          height: 16.h,
                                          width: 16.w,
                                        ),
                                        SizedBox(width: 16.w),
                                        Text(
                                          "CHANGE_PASSWORD".tr,
                                          style: GoogleFonts.rubik(
                                            color: AppColor.fontColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Divider(
                                    thickness: 1,
                                    endIndent: 10,
                                    color: AppColor.dividerColor,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ChangeLanguageView());
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 18.w,
                                  top: 12.h,
                                  right: 18.w,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          Images.change_language,
                                          height: 16.h,
                                          width: 16.w,
                                        ),
                                        SizedBox(width: 16.w),
                                        Text(
                                          "CHANGE_LANGUAGE".tr,
                                          style: GoogleFonts.rubik(
                                            color: AppColor.fontColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12.h),
                                    Divider(
                                      thickness: 1,
                                      endIndent: 10,
                                      color: AppColor.dividerColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GetBuilder<SplashController>(
                              builder:
                                  (splashController) => SizedBox(
                                    child: ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                      ),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          splashController.pageDataList.length,
                                      itemBuilder: (
                                        BuildContext context,
                                        index,
                                      ) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 12.h,
                                          ),
                                          child: profileItem(
                                            PagesScreen(
                                              description:
                                                  splashController
                                                      .pageDataList[index]
                                                      .description,
                                              tittle:
                                                  splashController
                                                      .pageDataList[index]
                                                      .title,
                                            ),
                                            Images.terms_condition,
                                            splashController
                                                .pageDataList[index]
                                                .title,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            ),
                            GestureDetector(
                              onTap: () {
                                box.write('isLogedIn', false);
                                (context as Element).markNeedsBuild();
                                Get.offAll(() => LoginView());
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 18.w,
                                  right: 18.w,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          Images.logout,
                                          height: 16.h,
                                          width: 16.w,
                                        ),
                                        SizedBox(width: 12.w),
                                        Text(
                                          "LOGOUT".tr,
                                          style: GoogleFonts.rubik(
                                            color: AppColor.fontColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12.h),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              profileController.loader
                  ? Positioned(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white60,
                      child: const Center(child: LoaderCircle()),
                    ),
                  )
                  : const SizedBox.shrink(),
            ],
          ),
    );
  }

  GestureDetector profileItem(route, icon, textValue) {
    return GestureDetector(
      onTap: () => Get.to(route, transition: Transition.cupertino),
      child: Padding(
        padding: EdgeInsets.only(left: 18.w, right: 18.w),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  height: 16.h,
                  width: 16.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16.h),
                Text(
                  "$textValue",
                  style: GoogleFonts.rubik(
                    color: AppColor.fontColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            const Divider(
              thickness: 1,
              endIndent: 10,
              color: AppColor.dividerColor,
            ),
          ],
        ),
      ),
    );
  }
}
