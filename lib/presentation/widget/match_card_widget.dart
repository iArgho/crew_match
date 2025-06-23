import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crew_match/presentation/main/home/user_detailed_home_page.dart';

class MatchCardWidget extends StatelessWidget {
  final Map<String, dynamic> profile;

  // ✅ Add margin/padding as optional parameters
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const MatchCardWidget({
    super.key,
    required this.profile,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => UserDetailedHomePage(
                  name: profile['name'],
                  bio: profile['bio'],
                  company: profile['company'],
                  ship: profile['ship'],
                  image: profile['image'],
                ),
          ),
        );
      },
      child: Container(
        margin: margin,
        padding: padding,
        width: 160.w,
        child: AspectRatio(
          aspectRatio: 3 / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    profile['image'],
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          color: Colors.grey,
                          child: const Icon(Icons.error, color: Colors.red),
                        ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.3),
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          children: [
                            SizedBox(width: 15.w),
                            Text(
                              '${profile['name']}, ${profile['age']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
