import 'package:crew_match/presentation/auth/forgotaccount/forgot_password_screen.dart';
import 'package:crew_match/presentation/auth/forgotaccount/reset_password_screen.dart';
import 'package:crew_match/presentation/widget/text_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleVerify() {
    String otp = _controllers.map((c) => c.text).join();
    print("Entered OTP: $otp");

    if (otp.length == 6) {
      print("Valid OTP, proceeding...");
      Get.off(() => const ResetPasswordScreen());
    } else {
      print("OTP incomplete");
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.off(() => const ForgotPasswordScreen()),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            Text(
              'OTP Verification',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text(
              "Please enter the 6-digit verification code sent to example@gmail.com",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 110.h),

            Center(
              child: Wrap(
                spacing: 16.w,
                runSpacing: 14.h,
                alignment: WrapAlignment.center,
                children: List.generate(6, (index) {
                  return _otpTextField(context, index, index == 0);
                }),
              ),
            ),
            SizedBox(height: 29.h),

            Text(
              "The OTP you entered is incorrect, please check again or resend it now.",
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.red,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 19.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive the code?",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print("Resend OTP pressed");
                  },
                  child: Text(
                    "Resend Now",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF326BDF),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),

            TextWidgetButton(text: 'Verify', onPressed: _handleVerify),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _otpTextField(BuildContext context, int index, bool autoFocus) {
    return SizedBox(
      width: 45.w,
      height: 50.h,
      child: TextField(
        controller: _controllers[index],
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        cursorColor: Colors.grey,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          counterText: '',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
