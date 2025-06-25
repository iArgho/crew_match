import 'package:crew_match/presentation/auth/createaccout/personal_details_screen.dart';
import 'package:crew_match/presentation/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:crew_match/presentation/widget/image_picker_widget.dart';
import 'package:crew_match/presentation/widget/text_widget_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UploadPhotosScreen extends StatelessWidget {
  const UploadPhotosScreen({super.key});

  void _pickImage(int index) {
    print("Image picked from index: $index");
  }

  void _removeImage(int index) {
    print("Image removed from index: $index");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.off(PersonalDetailsScreen());
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 26.h),
              Text(
                'Upload Photos',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Upload your best photos to find a good match!',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 48.h),
              SizedBox(
                height: 0.5.sh,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 24.w,
                  mainAxisSpacing: 24.h,
                  childAspectRatio: 0.9,
                  children: List.generate(
                    4,
                    (index) => ImagePickerWidget(
                      index: index,
                      onPick: _pickImage,
                      onRemove: _removeImage,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              TextWidgetButton(
                text: 'Next',
                onPressed: () {
                  Get.off(MainPage());
                },
              ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}
