import 'package:crew_match/presentation/widget/text_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleUpdatePassword() {
    if (_formKey.currentState?.validate() ?? false) {
      print("Password updated to: ${_newPasswordController.text}");
      // Implement actual password update logic here
      Get.snackbar('Success', 'Password updated successfully');
    }
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
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
                  'Change Password',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please enter your new password',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                ),
                SizedBox(height: 32.h),
                Text('New Password', style: TextStyle(fontSize: 16.sp)),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter new password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your new password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                Text('Confirm Password', style: TextStyle(fontSize: 16.sp)),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Re-enter new password',
                  ),
                  validator: (value) {
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Text(
                  '*NOTE: Choose a password that is distinctive & you can easily remember.',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
                SizedBox(height: 64.h),
                TextWidgetButton(
                  text: 'Update Password',
                  onPressed: _handleUpdatePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
