import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'user_detailed_home_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> people = [
      {
        'name': 'Emma',
        'age': '25',
        'image':
            'https://i.pinimg.com/736x/7e/33/57/7e3357cfb8ee9bf31cf2a5b427b50a92.jpg',
        'quote': 'Loves hiking & coffee.',
      },
      {
        'name': 'Mia',
        'age': '22',
        'image':
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=800&q=80',
        'quote': 'Always smiling.',
      },
      {
        'name': 'Liam',
        'age': '28',
        'image':
            'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=800&q=80',
        'quote': 'Music is life.',
      },
    ];

    final controller = PageController(viewportFraction: 0.92);

    return PageView.builder(
      controller: controller,
      itemCount: people.length,
      itemBuilder: (context, index) {
        final person = people[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Stack(
              children: [
                // Background image
                Image.network(
                  person['image']!,
                  width: double.infinity,
                  height: double.infinity,
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

                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
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

                // Name, age, quote, and buttons
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
                            '${person['name']}, ${person['age']}',
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
                          SizedBox(height: 4.h),
                          Text(
                            '“${person['quote']}”',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Transform.translate(
                        offset: Offset(0, -30.h),
                        child: Row(
                          children: [
                            // Cross icon
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
                            // Favorite icon with navigation
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            const UserDetailedHomePage(),
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
        );
      },
    );
  }
}
