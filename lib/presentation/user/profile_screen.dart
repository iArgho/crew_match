import 'package:crew_match/presentation/auth/createaccout/personal_details_screen.dart';
import 'package:crew_match/presentation/auth/createaccout/upload_photos_screen.dart';
import 'package:crew_match/presentation/settings/setting_screens.dart';
import 'package:crew_match/presentation/user/accout_information_screen.dart';
import 'package:crew_match/presentation/user/privecy_mode.dart';
import 'package:crew_match/presentation/user/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.off(() => const UploadPhotosScreen());
                  },
                  child: CircleAvatar(
                    radius: 60.r,
                    backgroundImage: const AssetImage('assets/profile.jpg'),
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
                      backgroundColor: const Color(0xFFD30579),
                      child: Icon(Icons.edit, color: Colors.white, size: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              "John Doe",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4.h),
            Text(
              "ACME Corp • Ship Titan",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            SizedBox(height: 24.h),
            ListTile(
              leading: const Icon(
                Icons.subscriptions,
                color: Color(0xFFD30579),
              ),
              title: Text("Subscription", style: TextStyle(fontSize: 16.sp)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.grey,
              ),
              onTap: () {
                Get.off(() => const SubscriptionScreen());
              },
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 4.h,
              ),
            ),
            Divider(height: 1.h, color: Colors.grey.shade300),
            ListTile(
              leading: const Icon(Icons.lock, color: Color(0xFFD30579)),
              title: Text("Privacy Mode", style: TextStyle(fontSize: 16.sp)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.grey,
              ),
              onTap: () {
                Get.off(() => const PrivacyModeScreen());
              },
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 4.h,
              ),
            ),
            Divider(height: 1.h, color: Colors.grey.shade300),
            ListTile(
              leading: const Icon(
                Icons.account_circle,
                color: Color(0xFFD30579),
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
              onTap: () {
                Get.off(() => const AccoutInformationScreen());
              },
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 4.h,
              ),
            ),
            Divider(height: 1.h, color: Colors.grey.shade300),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFFD30579)),
              title: Text("Settings", style: TextStyle(fontSize: 16.sp)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.grey,
              ),
              onTap: () {
                Get.off(() => const SettingScreens());
              },
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 4.h,
              ),
            ),
            Divider(height: 1.h, color: Colors.grey.shade300),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
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
