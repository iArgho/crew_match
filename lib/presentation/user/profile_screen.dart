import 'package:crew_match/presentation/auth/createaccout/personal_details_screen.dart';
import 'package:crew_match/presentation/auth/createaccout/upload_photos_screen.dart';
import 'package:crew_match/presentation/settings/setting_screens.dart';
import 'package:crew_match/presentation/user/accout_information_screen.dart';
import 'package:crew_match/presentation/user/privecy_mode.dart';
import 'package:crew_match/presentation/user/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Information",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.off(() => const UploadPhotosScreen());
                  },
                  child: CircleAvatar(
                    radius: 74.r,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?semt=ais_hybrid&w=740',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Get.off(() => const PersonalDetailsScreen());
                    },
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.edit, color: Colors.white, size: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              "John Doe",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4.h),
            Text(
              "ACME Corp • Ship Titan",
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24.h),

            // Subscription
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/Subscribtion.svg',
                width: 24.w,
                height: 24.h,
              ),
              title: Text("Subscription", style: TextStyle(fontSize: 16.sp)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.black,
              ),
              onTap: () => Get.off(() => const SubscriptionScreen()),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 4.h,
              ),
            ),
            Divider(height: 1.h, color: Colors.grey.shade300),

            // Privacy Mode
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/privecy.svg',
                width: 24.w,
                height: 24.h,
              ),
              title: Text("Privacy Mode", style: TextStyle(fontSize: 16.sp)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.black,
              ),
              onTap: () => Get.off(() => const PrivacyModeScreen()),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 4.h,
              ),
            ),
            Divider(height: 1.h, color: Colors.grey.shade300),

            // Account Information
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/account.svg',
                width: 24.w,
                height: 24.h,
              ),
              title: Text(
                "Account Information",
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.grey,
              ),
              onTap: () => Get.off(() => const AccoutInformationScreen()),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 4.h,
              ),
            ),
            Divider(height: 1.h, color: Colors.grey.shade300),

            // Settings
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/setting.svg',
                width: 24.w,
                height: 24.h,
              ),
              title: Text("Settings", style: TextStyle(fontSize: 16.sp)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.grey,
              ),
              onTap: () => Get.off(() => const SettingScreens()),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 4.h,
              ),
            ),
            Divider(height: 1.h, color: Colors.grey.shade300),

            // Log Out
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/logout.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: const ColorFilter.mode(
                  Colors.red,
                  BlendMode.srcIn,
                ),
              ),
              title: Text(
                "Log Out",
                style: TextStyle(fontSize: 16.sp, color: Colors.red),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 4.h,
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
