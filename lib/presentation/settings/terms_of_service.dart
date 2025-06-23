import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Terms of Service',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              "1. User Agreement",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "By using this app, you agree to our terms...",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade800),
            ),
            SizedBox(height: 16.h),
            Text(
              "2. Eligibility",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "You must be at least 18 years old...",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade800),
            ),
          ],
        ),
      ),
    );
  }
}
