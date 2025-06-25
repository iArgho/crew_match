import 'package:crew_match/presentation/main/match/match_screen.dart';
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
              height: 500.h,
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
                                SizedBox(width: 12.w),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => MatchScreen(
                                              matchName: 'Liam',
                                              matchImageUrl:
                                                  'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=800&q=80',
                                              myImageUrl:
                                                  'https://img.freepik.com/free-photo/business-young-woman-looking-camera-office_1301-6423.jpg',
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
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

            // Bottom detail section with titles outside rounded boxes
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bio", style: _headerStyle),
                  SizedBox(height: 8.h),
                  _buildContentBox(bio),
                  SizedBox(height: 16.h),

                  Text("Company", style: _headerStyle),
                  SizedBox(height: 8.h),
                  _buildContentBox(company),
                  SizedBox(height: 16.h),

                  Text("Ship Name", style: _headerStyle),
                  SizedBox(height: 8.h),
                  _buildContentBox(ship),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentBox(String content) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1.5),
      ),
      child: Text(content, style: _bodyStyle),
    );
  }

  TextStyle get _headerStyle =>
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold);

  TextStyle get _bodyStyle =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);
}
