import 'package:crew_match/presentation/widget/text_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedIndex = 0;

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
                Text(
                  'All personal and payment data are protected with advanced encryption. '
                  'By continuing, you confirm that you’ve read and accepted.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
                SizedBox(height: 20.h),
                TextWidgetButton(
                  text: 'Continue – $price',
                  onPressed: () => Navigator.pop(context),
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
        title: Text("Subscription", style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        physics: const BouncingScrollPhysics(),
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
              height: 170.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: plans.length,
                separatorBuilder: (_, __) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  final plan = plans[index];
                  final isSelected = index == selectedIndex;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedIndex = index);
                      Future.delayed(Duration.zero, () {
                        _showBottomSheet(context, plan['total']!);
                      });
                    },
                    child: Container(
                      width: 220.w,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        gradient:
                            isSelected
                                ? LinearGradient(
                                  colors: [
                                    Color(0xFFD30579),
                                    Color(0xFFFAB558),
                                  ],
                                )
                                : null,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border:
                              isSelected
                                  ? null
                                  : Border.all(color: Colors.grey.shade300),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: isSelected ? 8.h : 12.h),
                                Text(
                                  plan['duration']!,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
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
                            if (isSelected)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Icon(
                                  Icons.check,
                                  color: Color(0xFFD30579),
                                  size: 24.sp,
                                ),
                              ),
                          ],
                        ),
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
