import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showWaitDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              SvgPicture.asset(
                'assets/icons/avatar.svg',
                width: 80.w,
                height: 80.w,
              ),
              SizedBox(height: 20.h),
              Text(
                'Successfully Signed In',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Please wait...\nYou will be directed to the homepage soon.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.sp, color: Colors.black54),
              ),
              SizedBox(height: 24.h),
              const CircularProgressIndicator(color: Colors.red),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      );
    },
  );
}
