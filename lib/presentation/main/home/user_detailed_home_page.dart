import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetailedHomePage extends StatelessWidget {
  final String name;
  final String bio;
  final String company;
  final String ship;
  final String image;

  const UserDetailedHomePage({
    super.key,
    required this.name,
    required this.bio,
    required this.company,
    required this.ship,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name), centerTitle: true, elevation: 4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top image section
            SizedBox(
              height: 400.h, // Fixed height for image section
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        loadingBuilder:
                            (context, child, progress) =>
                                progress == null
                                    ? child
                                    : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                        errorBuilder:
                            (context, error, stackTrace) => const Center(
                              child: Icon(Icons.broken_image, size: 60),
                            ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30.h,
                      left: 20.w,
                      right: 20.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.6),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Transform.translate(
                            offset: Offset(0, 0),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(2.w),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                    size: 35.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: ShaderMask(
                                    shaderCallback:
                                        (bounds) => const LinearGradient(
                                          colors: [
                                            Color(0xFFD30579),
                                            Color(0xFFFAB558),
                                          ],
                                        ).createShader(bounds),
                                    blendMode: BlendMode.srcIn,
                                    child: Icon(
                                      Icons.favorite,
                                      size: 45.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom detail section
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bio", style: _headerStyle),
                  Text(bio, style: _bodyStyle),
                  SizedBox(height: 16.h),
                  Text("Company", style: _headerStyle),
                  Text(company, style: _bodyStyle),
                  SizedBox(height: 16.h),
                  Text("Ship Name", style: _headerStyle),
                  Text(ship, style: _bodyStyle),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _headerStyle =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  TextStyle get _bodyStyle =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
}
