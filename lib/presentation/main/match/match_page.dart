import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchScreen extends StatefulWidget {
  final bool hasMatches;

  const MatchScreen({super.key, this.hasMatches = true});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final List<Map<String, dynamic>> profiles = [
    {
      'name': 'Emma',
      'age': '25',
      'image':
          'https://i.pinimg.com/736x/7e/33/57/7e3357cfb8ee9bf31cf2a5b427b50a92.jpg',
      'date': DateTime.now(),
    },
    {
      'name': 'Mia',
      'age': '22',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=800&q=80',
      'date': DateTime.now(),
    },
    {
      'name': 'Liam',
      'age': '27',
      'image':
          'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=800&q=80',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
  ];

  Map<String, List<Map<String, dynamic>>> groupProfilesByDate() {
    Map<String, List<Map<String, dynamic>>> grouped = {};

    String getDateLabel(DateTime date) {
      final now = DateTime.now();
      final diff =
          DateTime(
            now.year,
            now.month,
            now.day,
          ).difference(DateTime(date.year, date.month, date.day)).inDays;

      if (diff == 0) return 'Today';
      if (diff == 1) return 'Yesterday';
      return "${date.day}/${date.month}/${date.year}";
    }

    for (var profile in profiles) {
      final label = getDateLabel(profile['date']);
      grouped.putIfAbsent(label, () => []).add(profile);
    }

    return grouped;
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupedProfiles = groupProfilesByDate();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child:
          widget.hasMatches
              ? SingleChildScrollView(
                child: Column(
                  children:
                      groupedProfiles.entries.map((entry) {
                        final label = entry.key;
                        final items = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildSectionHeader(label),
                            Column(
                              children: List.generate(
                                (items.length / 2).ceil(),
                                (index) {
                                  final first = items[index * 2];
                                  final second =
                                      (index * 2 + 1 < items.length)
                                          ? items[index * 2 + 1]
                                          : null;

                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          second == null
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildMatchCard(
                                          imageUrl: first['image'],
                                          name: first['name'],
                                          age: first['age'],
                                        ),
                                        if (second != null)
                                          _buildMatchCard(
                                            imageUrl: second['image'],
                                            name: second['name'],
                                            age: second['age'],
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              )
              : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'No matched profiles!',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'You don’t have any matched profiles.\nSend match requests to connect!',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildMatchCard({
    required String imageUrl,
    required String name,
    required String age,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: SizedBox(
        width: 150.w,
        height: 200.h,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                imageUrl,
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
                    color: Colors.black.withOpacity(0.4),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      '$name, $age',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
