import 'package:crew_match/presentation/user/profile_screen.dart';
import 'package:crew_match/presentation/widget/text_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PrivacyModeScreen extends StatelessWidget {
  const PrivacyModeScreen({super.key});

  // Define constants for reusability and easy maintenance
  static const String privacyModePrice = '\$1.00';
  static const String priceText = 'One dollar only';

  // Method to show bottom sheet with confirmation
  void _showBottomSheet(BuildContext context) {
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
                SizedBox(height: 20.h),
                Text(
                  'All personal and payment data are protected with advanced encryption. '
                  'By continuing, you confirm that you’ve read and accepted.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  semanticsLabel:
                      'All personal and payment data are protected with advanced encryption. '
                      'By continuing, you confirm that you have read and accepted.',
                ),
                SizedBox(height: 40.h),
                TextWidgetButton(
                  text: 'Continue – $privacyModePrice',
                  onPressed: () async {
                    // Placeholder for payment processing logic
                    bool paymentSuccess = await _processPayment(
                      privacyModePrice,
                    );
                    if (paymentSuccess) {
                      Navigator.pop(context);
                      // Optionally navigate to a success screen or update state
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Payment successful! Privacy mode activated.',
                          ),
                        ),
                      );
                    } else {
                      // Show error feedback
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Payment failed. Please try again.'),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
    );
  }

  // Placeholder for payment processing (replace with actual payment gateway integration)
  Future<bool> _processPayment(String price) async {
    // Simulate payment processing (e.g., with Stripe, PayPal, etc.)
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return true; // Return true for success, false for failure
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Mode",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor ?? Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.off(ProfileScreen());
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hidden Until You're Ready",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
              semanticsLabel: "Hidden Until You're Ready",
            ),
            SizedBox(height: 12.h),
            Text(
              "Hide your profile from others until you like theirs.",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              semanticsLabel:
                  "Hide your profile from others until you like theirs.",
            ),
            SizedBox(height: 104.h),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      privacyModePrice,
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      semanticsLabel: priceText,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Make a one-time payment of only a dollar\nand enjoy your privacy mode forever.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      semanticsLabel:
                          "Make a one-time payment of only a dollar and enjoy your privacy mode forever.",
                    ),
                    Spacer(),
                    TextWidgetButton(
                      text: 'Continue – $privacyModePrice',
                      onPressed: () => _showBottomSheet(context),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
