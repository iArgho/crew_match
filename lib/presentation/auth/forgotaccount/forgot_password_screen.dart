import 'package:crew_match/presentation/auth/forgotaccount/otp_verification.dart';
import 'package:crew_match/presentation/auth/signin/signin_screen.dart';
import 'package:crew_match/presentation/widget/text_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleGetOtp() {
    if (_formKey.currentState?.validate() ?? false) {
      print("OTP requested for: ${_emailController.text}");
      // Navigate to OTP screen after validation
      Get.off(() => const OtpVerificationScreen());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.off(() => const SigninScreen()),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                Text(
                  'Forgot Your Password?',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please enter your registered Email & we will send an OTP code to reset your password.',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                ),
                SizedBox(height: 32.h),
                Text('Email', style: TextStyle(fontSize: 16.sp)),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  decoration: const InputDecoration(
                    hintText: 'Enter your Email',
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter your Email';
                    }
                    // Match email validation with SigninScreen
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(text)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 104.h),
                TextWidgetButton(text: 'Get OTP', onPressed: _handleGetOtp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
