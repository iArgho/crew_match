import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  void _showBottomSheet(BuildContext context, String price) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder:
          (_) => Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock, size: 40.sp, color: const Color(0xFFD30579)),
                SizedBox(height: 12.h),
                Text(
                  'All personal and payment data are protected with advanced encryption. '
                  'By continuing, you confirm that you’ve read and accepted.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD30579),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    child: Text(
                      'Continue – $price Total',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final plans = [
      {
        "tag": "Popular",
        "duration": "1 Week",
        "price": "\$34.78 /wk",
        "total": "\$34.78",
      },
      {
        "tag": "Best Offer",
        "duration": "1 Month",
        "price": "\$44.78 /mo",
        "total": "\$44.78",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subscribe",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Access All Features – Subscribe Now",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10.h),
            Text(
              "Unlock everything you need to find real connections—faster and easier.",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            SizedBox(height: 24.h),
            Text(
              "Select a Plan",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 160.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: plans.length,
                separatorBuilder: (_, __) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  final plan = plans[index];
                  return GestureDetector(
                    onTap: () => _showBottomSheet(context, plan['total']!),
                    child: Container(
                      width: 220.w,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD30579).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16.r),
                        //border: const BorderSide(color: Color(0xFFD30579)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Chip(
                            label: Text(
                              plan['tag']!,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: const Color(0xFFD30579),
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            plan['duration']!,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            plan['price']!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
