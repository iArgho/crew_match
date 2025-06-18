import 'package:crew_match/presentation/auth/signin/signin_screen.dart';
import 'package:crew_match/presentation/widget/text_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
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

  void _handleSignIn() {
    String otp = _controllers.map((controller) => controller.text).join();
    print("Entered OTP: $otp");

    if (otp.length == 6) {
      print("Valid OTP, proceed with sign-in...");
    } else {
      print("OTP incomplete");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.off(() => const SigninScreen());
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please Enter the 6-digit verification code sent to",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              "example@gmail.com",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            SizedBox(height: 30.h),

            // OTP input fields with underline only
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 10.w,
              runSpacing: 10.h,
              children: List.generate(6, (index) {
                return _otpTextField(context, index, index == 0);
              }),
            ),
            SizedBox(height: 20.h),

            Text(
              "The OTP you entered is incorrect, please check again or resend it now.",
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                Text(
                  "Didn't receive the code?",
                  style: TextStyle(fontSize: 14.sp),
                ),
                TextButton(
                  onPressed: () {
                    print("Resend OTP pressed");
                    // TODO: Implement resend logic
                  },
                  child: const Text("Resend Now"),
                ),
              ],
            ),

            const Spacer(),

            TextWidgetButton(text: 'Sign In', onPressed: _handleSignIn),
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
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
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
