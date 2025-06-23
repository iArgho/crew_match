import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crew_match/presentation/widget/image_picker_widget.dart';
import 'package:crew_match/presentation/widget/text_widget_button.dart';

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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Text(
              'Upload Photos',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text(
              'Upload your best photos to find a good match!',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (index) => ImagePickerWidget(
                  index: index,
                  onPick: _pickImage,
                  onRemove: _removeImage,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            ImagePickerWidget(
              index: 3,
              onPick: _pickImage,
              onRemove: _removeImage,
            ),
            const Spacer(),
            TextWidgetButton(
              text: 'Next',
              onPressed: () {
                print("Next pressed");
              },
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
