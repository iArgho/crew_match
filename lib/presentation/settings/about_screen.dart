import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'About Us',
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
              "1. What type of data we collect?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Lorem ipsum dolor sit amet...",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade800),
            ),
            SizedBox(height: 16.h),
            Text(
              "2. Why we collect data?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Lorem ipsum dolor sit amet...",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade800),
            ),
            SizedBox(height: 16.h),
            Text(
              "3. How we use your data?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Lorem ipsum dolor sit amet...",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade800),
            ),
          ],
        ),
      ),
    );
  }
}
